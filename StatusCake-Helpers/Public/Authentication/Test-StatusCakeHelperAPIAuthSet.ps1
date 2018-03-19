
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
    If($Global:StatusCakeAPICredentials)
    {
        Return $true
    }
    else 
    {
        Return $false    
    }
}