
<#
.Synopsis
   Removes the StatusCake Authentication Username and API Key
.EXAMPLE
   Remove-StatusCakeHelperAPIAuth
.OUTPUTS
   Returns a Boolean value on the authentication removal operation
.FUNCTIONALITY
   Removes the StatusCake Authentication Username and API Key credential file used by the module

#>
function Remove-StatusCakeHelperAPIAuth
{
   [CmdletBinding(SupportsShouldProcess=$true)]
   [OutputType([System.Boolean])]
   Param()
    Try
    {
         $moduleName = (Get-Command $MyInvocation.MyCommand.Name).Source
         Remove-Item "$env:userprofile\$moduleName\$moduleName-Credentials.xml" -Force
    }
    Catch
    {
        Write-Error $_
        Return $false
    }

    Return $true
}