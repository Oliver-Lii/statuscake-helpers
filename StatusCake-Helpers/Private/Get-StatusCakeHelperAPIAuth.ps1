
<#
.Synopsis
   Gets the StatusCake API Username and API Key
.PARAMETER Credentials
   Credentials object should not be passed to function but set using Set-StatusCakeHelperAPIAuth
.EXAMPLE
   Get-StatusCakeHelperAPIAuth
.FUNCTIONALITY
   Returns a PSCredential object containing the StatusCake API Credentials

#>
function Get-StatusCakeHelperAPIAuth
{
   [CmdletBinding()]
   [OutputType([System.Management.Automation.PSCredential])]
   Param(
      [System.Management.Automation.PSCredential] $Credentials
   )

   if($PSDefaultParameterValues.ContainsKey("Get-StatusCakeHelperAPIAuth:Credentials"))
   {
      $Credential = $PSDefaultParameterValues["Get-StatusCakeHelperAPIAuth:Credentials"]
   }
   elseif(Test-StatusCakeHelperAPIAuthSet)
   {
      $moduleName = (Get-Command $MyInvocation.MyCommand.Name).Source
      $Credential = Import-CliXml -Path "$env:userprofile\.$moduleName\$moduleName-Credentials.xml"
   }

   Return $Credential
}