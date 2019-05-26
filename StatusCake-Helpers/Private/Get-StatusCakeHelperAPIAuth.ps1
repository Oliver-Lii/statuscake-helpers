
<#
.Synopsis
   Gets the StatusCake API Username and API Key
.EXAMPLE
   Get-StatusCakeHelperAPIAuth
.OUTPUTS
   Returns a PSCredential object containing the StatusCake API Credentials
.FUNCTIONALITY
   Returns a PSCredential object containing the StatusCake API Credentials

#>
function Get-StatusCakeHelperAPIAuth
{
   $moduleName = (Get-Command $MyInvocation.MyCommand.Name).Source
   if(Test-StatusCakeHelperAPIAuthSet)
   {
      $Credential = Import-CliXml -Path "$env:userprofile\$moduleName\$moduleName-Credentials.xml"
   }

   Return $Credential
}