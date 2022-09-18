<#
.SYNOPSIS
    Tests to confirm that a supplied IP Address is valid
.DESCRIPTION
    Tests to confirm that a supplied IP Address is valid. The IP Address class is used to determine if the supplied IP address is valid.
.PARAMETER IPAddress
    IP Address to test is valid
.EXAMPLE
    C:\PS>"10.0.0.1" | Test-StatusCakeHelperIPAddress
    Test if the value 10.0.0.1 is a valid IP address
.OUTPUTS
    Returns true if the IP Address is valid
#>
function Test-StatusCakeHelperIPAddress
{
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Boolean])]
    Param(
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]
        [string] $IPAddress
    )
    Process{
        Return $IPAddress -as [IPAddress] -as [Bool]
    }
}
