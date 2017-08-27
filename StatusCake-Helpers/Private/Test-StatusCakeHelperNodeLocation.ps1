
<#
.Synopsis
   Tests to confirm that a supplied node location is valid
.EXAMPLE
   Test-StatusCakeHelperNodeLocation [string]
.INPUTS
    NodeLocations - String containing the node location server code
.OUTPUTS    
    Returns true if node location server code is valid
.FUNCTIONALITY
   Tests to confirm that a supplied node location server code is valid
   
#>
function Test-StatusCakeHelperNodeLocation
{
    [CmdletBinding(PositionalBinding=$false)]    
    Param(
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]
        [string] $NodeLocation
    )

    $StatusCakeServerCodes = (Get-StatusCakeHelperProbes).servercode

    if($StatusCakeServerCodes -contains $NodeLocation)
    {
        Return $true
    }
    Return $false
}
