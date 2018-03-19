
<#
.Synopsis
   Gets the StatusCake API Username and API Key
.EXAMPLE
   Get-StatusCakeHelperAPIAuth
.OUTPUTS    
   Returns a hashtable containing the StatusCake API Credentials
.FUNCTIONALITY
   Returns a hashtable containing the StatusCake API Credentials
   
#>
function Get-StatusCakeHelperAPIAuth
{
    if(Test-StatusCakeHelperAPIAuthSet)
    {
        Return $Global:StatusCakeAPICredentials
    }
    else 
    {
        Return    
    }
}