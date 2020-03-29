[CmdletBinding()]
param (
    [string]$NuGetAPIKey=$env:PSGalleryAPIKey,
    [string]$ModuleFolderPath = (Join-Path -Path $env:BUILD_SOURCESDIRECTORY -ChildPath $env:ModuleChildPath)
)

$publishParams = @{
    Path        = $ModuleFolderPath
    NugetApiKey = $NuGetAPIKey
    Force       = $true
}
Publish-Module @publishParams
