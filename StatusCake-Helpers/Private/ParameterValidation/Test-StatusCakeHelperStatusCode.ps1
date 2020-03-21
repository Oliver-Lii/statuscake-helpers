
<#
.SYNOPSIS
    Tests to confirm that a supplied HTTP Status Code is valid
.DESCRIPTION
    Tests to confirm that a supplied HTTP Status Code is valid
.PARAMETER StatusCode
    StatusCode to test is valid
.EXAMPLE
    C:\PS>"404" | Test-StatusCakeHelperStatusCode
    Test if the value 404 is a valid status code
.OUTPUTS
    Returns true if HTTP Status Code code is valid
#>
function Test-StatusCakeHelperStatusCode
{
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Boolean])]
    Param(
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]
        [string] $StatusCode
    )

    if($StatusCode -match '^[1-5]{1}[0-9]{1}[0-9]{1}$')
    {
        Return $true
    }
    Return $false
}
