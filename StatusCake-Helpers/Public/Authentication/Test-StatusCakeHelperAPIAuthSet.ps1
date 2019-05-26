
<#
.Synopsis
   Tests whether StatusCake API Credentials have been configured
.EXAMPLE
   Test-StatusCakeHelperAPIAuthSet
.OUTPUTS
   Returns a boolean value
.FUNCTIONALITY
   Returns a boolean value depending on whether StatusCake API Credentials have been set
   
#>
function Test-StatusCakeHelperAPIAuthSet
{
   $moduleName = (Get-Command $MyInvocation.MyCommand.Name).Source
   Return (Test-Path "$env:userprofile\$moduleName\$moduleName-Credentials.xml" -PathType Leaf)
}