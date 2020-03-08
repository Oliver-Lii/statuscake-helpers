<#
.Synopsis
   Sets the StatusCake API Username and API Key
.PARAMETER Credential
   Credential object containing the username and API Key
.PARAMETER Session
   Switch to avoid writing credentials to disk
.EXAMPLE
   Set-StatusCakeHelperAPIAuth -Credential <Credential>
.INPUTS
   Credential - Credential object containing the username and API Key
.FUNCTIONALITY
    Sets the StatusCake API Username and API Key used by the module.

#>
function Set-StatusCakeHelperAPIAuth
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    [OutputType([System.Boolean])]
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [Alias('Credentials')]
        [System.Management.Automation.PSCredential] $Credential,

        [Switch]$Session
    )

    if($Session)
    {
        $PSDefaultParameterValues.Add("Get-StatusCakeHelperAPIAuth:Credential",$Credential)
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
            $Credential | Export-CliXml -Path "$env:userprofile\.$moduleName\$moduleName-Credentials.xml"
        }
        Catch
        {
            Write-Error $_
            Return $false
        }
    }

    Return $true
}

