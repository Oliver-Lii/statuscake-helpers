
<#
.Synopsis
   Tests to confirm that a supplied TimeZone is valid
.EXAMPLE
   Test-StatusCakeHelperTimeZone
.INPUTS
    StatusCode - String containing the TimeZone
.OUTPUTS    
    Returns true if Time Zone is valid
.FUNCTIONALITY
   Tests to confirm that a supplied TimeZone is valid
   
#>
function Test-StatusCakeHelperTimeZone
{
    [CmdletBinding(PositionalBinding=$false)]    
    Param(
        [Parameter(Mandatory=$True,
        ValueFromPipeline=$True)]
        [string] $TimeZone,
        [string] $TimeZoneFile="$PSScriptRoot\Files\TimeZones.json"
    )
    $timeZoneList = Get-Content $TimeZoneFile | ConvertFrom-Json
    
    if($timeZoneList -contains $TimeZone)
    {
        Return $true
    }
    Return $false
}
