<#
.Synopsis
   Sets the StatusCake API Username and API Key
.EXAMPLE
   Set-StatusCakeHelperAPIAuth -Credentials <Credential>
.INPUTS
   Credentials - Credentials object containing the username and API Key
.FUNCTIONALITY
    Sets the StatusCake API Username and API Key
   
#>
function Set-StatusCakeHelperAPIAuth
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    [OutputType([System.Boolean])]
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $Credentials
    )

    Try
    {
        $moduleName = (Get-Command $MyInvocation.MyCommand.Name).Source
        If(! (Test-Path "$env:userprofile\$moduleName\"))
        {
            New-Item "$env:userprofile\$moduleName" -ItemType Directory | Out-Null
        }
        $Credentials | Export-CliXml -Path "$env:userprofile\$moduleName\$moduleName-Credentials.xml"
    }
    Catch
    {
        Write-Error $_
        Return $false
    }

    Return $true
}

