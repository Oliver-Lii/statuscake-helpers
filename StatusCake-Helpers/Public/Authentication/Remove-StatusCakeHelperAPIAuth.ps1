
<#
.SYNOPSIS
   Removes the StatusCake Authentication Username and API Key
.DESCRIPTION
   Removes the StatusCake Authentication Username and API Key credential file used by the module. If session switch is used this will remove the credentials added for the session.
.PARAMETER Session
   Switch to remove credentials configured for the session
.EXAMPLE
   C:\PS> Remove-StatusCakeHelperAPIAuth
   Remove the StatusCake Authentication credential file
.EXAMPLE
   C:\PS> Remove-StatusCakeHelperAPIAuth -Session
   Remove the StatusCake Authentication credential configured for the session
.OUTPUTS
   Returns a Boolean value on whether authentication removal operation was successful
.LINK
   https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Authentication/Remove-StatusCakeHelperAPIAuth.md
#>
function Remove-StatusCakeHelperAPIAuth
{
   [CmdletBinding(SupportsShouldProcess=$true)]
   [OutputType([System.Boolean])]
   Param(
      [Switch]$Session
   )

   If($Session)
   {
      if($PSDefaultParameterValues.ContainsKey("Get-StatusCakeHelperAPIAuth:Credential"))
      {
         $PSDefaultParameterValues.Remove("Get-StatusCakeHelperAPIAuth:Credential")
      }
   }
   else
   {
      Try
      {
         $moduleName = (Get-Command $MyInvocation.MyCommand.Name).Source
         Remove-Item "$env:userprofile\.$moduleName\$moduleName-Credentials.xml" -Force
      }
      Catch
      {
         Write-Error $_
         Return $false
      }
   }


    Return $true
}