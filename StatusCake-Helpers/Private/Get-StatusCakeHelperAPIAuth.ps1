
<#
.Synopsis
   Gets the StatusCake API Username and API Key
.PARAMETER Credential
   Credential object should not be passed to function but set using Set-StatusCakeHelperAPIAuth
.EXAMPLE
   Get-StatusCakeHelperAPIAuth
.FUNCTIONALITY
   Returns a PSCredential object containing the StatusCake API Credential

#>
function Get-StatusCakeHelperAPIAuth
{
   [CmdletBinding()]
   [OutputType([System.Management.Automation.PSCredential])]
   Param(
      [System.Management.Automation.PSCredential] $Credential
   )

   if($PSDefaultParameterValues.ContainsKey("Get-StatusCakeHelperAPIAuth:Credential"))
   {
      $Credential = $PSDefaultParameterValues["Get-StatusCakeHelperAPIAuth:Credential"]
   }
   elseif(Test-StatusCakeHelperAPIAuthSet)
   {
      $moduleName = (Get-Command $MyInvocation.MyCommand.Name).Source
      $Credential = Import-CliXml -Path "$env:userprofile\.$moduleName\$moduleName-Credentials.xml"
   }

   Return $Credential
}