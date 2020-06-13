
<#
.SYNOPSIS
   Tests whether StatusCake API Credentials have been configured
.DESCRIPTION
   Returns a boolean value depending on whether StatusCake API Credentials file for the module exists
.EXAMPLE
   C:\PS> Test-StatusCakeHelperAPIAuthSet
   Test whether the credential file exists
.OUTPUTS
   Returns a boolean value
.LINK
   https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Authentication/Test-StatusCakeHelperAPIAuthSet.md
#>
function Test-StatusCakeHelperAPIAuthSet
{
   $moduleName = (Get-Command $MyInvocation.MyCommand.Name).Source
   Return (Test-Path "$env:userprofile\.$moduleName\$moduleName-Credentials.xml" -PathType Leaf)
}