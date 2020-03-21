
<#
.SYNOPSIS
    Tests to confirm that a supplied string is a valid email address
.DESCRIPTION
    Tests to confirm that a supplied string is a valid email address
.PARAMETER EmailAddress
    String containing the email address to be tested
.OUTPUTS
    Returns true if email address is valid
.EXAMPLE
    C:\PS>"test@example.com" | Test-StatusCakeHelperEmailAddress
    Test if the string "test@example.com" is a valid email address
#>
function Test-StatusCakeHelperEmailAddress
{
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Boolean])]
    Param(
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]
        [string] $EmailAddress
    )

    if($EmailAddress -match '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
    {
        Return $true
    }
    Return $false
}
