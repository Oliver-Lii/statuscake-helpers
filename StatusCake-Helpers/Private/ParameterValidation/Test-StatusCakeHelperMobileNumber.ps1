
<#
.SYNOPSIS
    Tests to confirm that a supplied phone number has a valid phone number format
.DESCRIPTION
    Tests to confirm that a supplied phone number is in the E.164 phone number format
.PARAMETER MobileNumber
    String containing phone number
.EXAMPLE
    C:\PS>"+1023456789" | Test-StatusCakeHelperMobileNumber
    Test to confirm that "+1023456789" is in E.164 phone number format
.OUTPUTS
    Returns true if mobile number is valid
#>
function Test-StatusCakeHelperMobileNumber
{
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Boolean])]
    Param(
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]
        [string] $MobileNumber
    )

    if($MobileNumber -match '^\+[1-9]{1}[0-9]{9,14}$')
    {
        Return $true
    }
    Return $false
}
