
<#
.Synopsis
   Tests to confirm that a supplied email address is valid
.EXAMPLE
   Test-StatusCakeHelperEmailAddress "test@example.com"
.INPUTS
    Email - String containing email address
.OUTPUTS
    Returns true if email address is valid
.FUNCTIONALITY
   Tests to confirm that a supplied email address is valid

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
