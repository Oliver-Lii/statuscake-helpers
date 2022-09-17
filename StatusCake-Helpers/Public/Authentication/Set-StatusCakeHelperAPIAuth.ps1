<#
.SYNOPSIS
    Sets the StatusCake API Username and API Key
.DESCRIPTION
    Sets the StatusCake API Username and API Key used by the module. Credential file will be stored in the user's profile folder under .StatusCake-Helpers folder.
    If the credential file already exists then the existing credential file will be overwritten otherwise a credential file will be created.
    To avoid persisting credentials to disk the session switch can be used.
.PARAMETER APIKey
    Statuscake API Key
.PARAMETER Credential
    Credential object containing the username and API Key
.PARAMETER Session
    Switch to configure the credential for the session only and avoid writing them to disk
.EXAMPLE
    C:\PS> Set-StatusCakeHelperAPIAuth -APIKey (Read-Host -AsSecureString -Prompt "Please enter the API key")
    Set the StatusCake Authentication credential file
.EXAMPLE
    C:\PS> Set-StatusCakeHelperAPIAuth -APIKey (Read-Host -AsSecureString -Prompt "Please enter the API key") -Session
    Set the StatusCake Authentication credential for the session
.INPUTS
    Credential - Credential object containing the username and API Key
.OUTPUTS
    Returns a Boolean value on whether the authentication credential was successfully set
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Authentication/Set-StatusCakeHelperAPIAuth.md
#>
function Set-StatusCakeHelperAPIAuth
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    [OutputType([System.Boolean])]
    Param(
        [Parameter(Mandatory=$true,ParameterSetName = "APIKey")]
        [ValidateNotNullOrEmpty()]
        [securestring] $APIKey,

        [Parameter(Mandatory=$true,ParameterSetName = "Credential")]
        [ValidateNotNullOrEmpty()]
        [Alias('Credentials')]
        [System.Management.Automation.PSCredential] $Credential,

        [Switch]$Session
    )

    # If API key provided create a credential object from this
    If($APIKey)
    {
        $scCredentials = New-Object System.Management.Automation.PSCredential ("StatusCake API Key", $APIKey)
    }
    else
    {
        $scCredentials = $Credential
    }

    if($Session)
    {
        $PSDefaultParameterValues["Get-StatusCakeHelperAPIAuth:Credential"] = $scCredentials
    }
    else
    {
        Try
        {
            $moduleName = (Get-Command $MyInvocation.MyCommand.Name).Source
            If(! (Test-Path "$env:userprofile\.$moduleName\"))
            {
                New-Item "$env:userprofile\.$moduleName" -ItemType Directory | Out-Null
            }
            $scCredentials | Export-CliXml -Path "$env:userprofile\.$moduleName\$moduleName-Credentials.xml"
        }
        Catch
        {
            Write-Error $_
            Return $false
        }
    }

    Return $true
}

