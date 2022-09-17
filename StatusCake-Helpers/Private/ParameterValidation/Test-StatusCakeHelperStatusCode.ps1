
<#
.SYNOPSIS
    Tests to confirm that a supplied HTTP Status Code is valid
.DESCRIPTION
    Tests to confirm that a supplied HTTP Status Code is valid
.PARAMETER StatusCode
    StatusCode to test is valid
.EXAMPLE
    C:\PS>"404" | Test-StatusCakeHelperHTTPStatusCode
    Test if the value 404 is a valid status code
.OUTPUTS
    Returns true if HTTP Status Code code is valid
#>
function Test-StatusCakeHelperHTTPStatusCode
{
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Boolean])]
    Param(
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]
        [string] $StatusCode
    )
    Process{
        Return $StatusCode -as [System.Net.HttpStatusCode] -as [Bool]
    }
}
