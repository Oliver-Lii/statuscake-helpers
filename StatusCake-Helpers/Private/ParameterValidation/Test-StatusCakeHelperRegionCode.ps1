
<#
.SYNOPSIS
    Tests to confirm that a supplied region code is valid
.DESCRIPTION
    Tests to confirm that a supplied region code is valid. Test is carried out by retrieving the list of all region codes and verifying the string is present in the list.
.PARAMETER RegionCode
    Region code to validate
.PARAMETER StatusCakeRegionCodes
    List of StatusCake Region Codes.
.PARAMETER Refresh
    Refresh the list of region codes the function has stored.
.EXAMPLE
    C:\PS>"london" | Test-StatusCakeHelperRegion
    Test if "london" is a valid StatusCake node location
.OUTPUTS
    Returns true if node location server code is valid
#>
function Test-StatusCakeHelperRegionCode
{
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Boolean])]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]
        [string] $RegionCode,

        [string[]]$StatusCakeRegionCodes,

        [switch]$Refresh
    )

    Process{

        If($PSDefaultParameterValues.ContainsKey("Test-StatusCakeHelperRegion:StatusCakeRegionCodes"))
        {
            $StatusCakeRegionCodes = $PSDefaultParameterValues["Test-StatusCakeHelperRegion:StatusCakeRegionCodes"]
        }
        elseif($Refresh)
        {
            # Update the list of region code stored by the function
            $StatusCakeRegionCodes = (Get-StatusCakeHelperLocation -APICredential $APICredential).region_code | Sort-Object -Unique
            $PSDefaultParameterValues["Test-StatusCakeHelperRegion:StatusCakeRegionCodes"] = $StatusCakeRegionCodes
        }
        elseif(! $StatusCakeRegionCodes)
        {
            $StatusCakeRegionCodes = (Get-StatusCakeHelperLocation -APICredential $APICredential).region_code | Sort-Object -Unique
            $PSDefaultParameterValues["Test-StatusCakeHelperRegion:StatusCakeRegionCodes"] = $StatusCakeRegionCodes
        }

        if($StatusCakeRegionCodes -contains $RegionCode)
        {
            Return $true
        }

    Return $false
    }
}
