
<#
.Synopsis
   Tests to confirm that a supplied HTTP Status Code is valid
.EXAMPLE
   Test-StatusCakeHelperStatusCode [string]
.INPUTS
    StatusCode - String containing the HTTP StatusCode
.OUTPUTS
    Returns true if HTTP Status Code code is valid
.FUNCTIONALITY
   Tests to confirm that a supplied HTTP Status Code is valid

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

    if($StatusCode -match '^[1-5]{1}[0-5]{1}[0-9]{1}$')
    {
        Return $true
    }
    Return $false
}
