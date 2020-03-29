[CmdletBinding()]
param (
    [string]$AzDOAccountName,
    [string]$AzDOPat,
    [string]$AzDOArtifactFeedName,
    [string]$AzDOProjectID = $env:SYSTEM_TEAMPROJECT,
    [string]$ModuleFolderPath = (Join-Path -Path $env:BUILD_SOURCESDIRECTORY -ChildPath $env:ModuleChildPath)
)

# Variables
$feedUsername = 'NotChecked'
$packageSourceUrl = "https://pkgs.dev.azure.com/$AzDOAccountName/$AzDOProjectID/_packaging/$AzDOArtifactFeedName/nuget/v2" # NOTE: v2 Feed

# Troubleshooting
# Get-ChildItem env: | Format-Table -AutoSize

# This is downloaded during Step 2, but could also be "C:\Users\USERNAME\AppData\Local\Microsoft\Windows\PowerShell\PowerShellGet\NuGet.exe"
# if not running script as Administrator.
$nugetPath = (Get-Command NuGet.exe).Source
if (-not (Test-Path -Path $nugetPath)) {
    # $nugetPath = 'C:\ProgramData\Microsoft\Windows\PowerShell\PowerShellGet\NuGet.exe'
    $nugetPath = Join-Path -Path $env:LOCALAPPDATA -ChildPath 'Microsoft\Windows\PowerShell\PowerShellGet\NuGet.exe'
}

# Create credential
$password = ConvertTo-SecureString -String $AzDOPat -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($feedUsername, $password)


# Step 1
# Check NuGet is listed
Get-PackageProvider -Name 'NuGet' -ForceBootstrap | Format-List *


# Step 2
# THIS WILL FAIL first time, so don't panic!
# Try to Publish a PowerShell module - this will prompt and download NuGet.exe, and fail publishing the module (we publish at the end)
$publishParams = @{
    Path        = $ModuleFolderPath
    Repository  = $AzDOArtifactFeedName
    NugetApiKey = 'VSTS'
    Force       = $true
    ErrorAction = 'SilentlyContinue'
}
Publish-Module @publishParams


# Step 3
# Register NuGet Package Source

& $nugetPath Sources Add -Name $AzDOArtifactFeedName -Source $packageSourceUrl -Username $feedUsername -Password $AzDOPat


# Check new NuGet Source is registered
& $nugetPath Sources List


# Step 4
# Register feed
$registerParams = @{
    Name                      = $AzDOArtifactFeedName
    ScriptSourceLocation      = $packageSourceUrl
    SourceLocation            = $packageSourceUrl
    PublishLocation           = $packageSourceUrl
    InstallationPolicy        = 'Trusted'
    PackageManagementProvider = 'Nuget'
    Credential                = $credential
}
Register-PSRepository @registerParams

# Check new PowerShell Repository is registered
Get-PSRepository -Name $AzDOArtifactFeedName


# Step 5
# Publish PowerShell module (2nd time lucky!)
Publish-Module @publishParams

