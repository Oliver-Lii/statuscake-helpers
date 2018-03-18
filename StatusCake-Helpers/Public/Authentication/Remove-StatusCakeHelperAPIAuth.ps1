
<#
.Synopsis
   Removes the StatusCake Authentication Username and API Key
.EXAMPLE
   Remove-StatusCakeHelperAPIAuth
.OUTPUTS    
   Returns a Boolean value on the authentication removal operation
.FUNCTIONALITY
   Removes the StatusCake Authentication Username and API Key
   
#>
function Remove-StatusCakeHelperAPIAuth
{

    Try 
    {
        Remove-Variable -Name StatusCakeAPICredentials -Scope Global -ErrorAction Stop
    }
    Catch 
    {
        Write-Error $_
        Return $false
    }

    Return $true
}