
<#
.SYNOPSIS
    Tests to confirm that a supplied node location is valid
.DESCRIPTION
    Tests to confirm that a supplied node location server code is valid. Test is carried out by retrieving the list of all probes and verifying the string is present in the list.
.PARAMETER NodeLocation
    Node location server code to validate
.EXAMPLE
    C:\PS>"EU1" | Test-StatusCakeHelperNodeLocation
    Test if "EU1" is a valid StatusCake node location
.OUTPUTS
    Returns true if node location server code is valid
#>
function Test-StatusCakeHelperNodeLocation
{
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Boolean])]
    Param(
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]
        [string] $NodeLocation
    )

    $StatusCakeServerCodes = (Get-StatusCakeHelperProbe).servercode

    if($StatusCakeServerCodes -contains $NodeLocation)
    {
        Return $true
    }
    Return $false
}
