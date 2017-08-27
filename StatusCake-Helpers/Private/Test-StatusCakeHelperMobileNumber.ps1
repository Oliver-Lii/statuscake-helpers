
<#
.Synopsis
   Tests to confirm that a supplied mobile number is valid
.EXAMPLE
   Test-StatusCakeHelperMobileNo "test@example.com"
.INPUTS
    MobileNumber - String containing mobile number
.OUTPUTS    
    Returns true if mobile number is valid
.FUNCTIONALITY
   Tests to confirm that a supplied mobile number meets the E.164 number formatting
   
#>
function Test-StatusCakeHelperMobileNumber
{
    [CmdletBinding(PositionalBinding=$false)]    
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
