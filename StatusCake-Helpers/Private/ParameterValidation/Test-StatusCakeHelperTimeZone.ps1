
<#
.SYNOPSIS
    Tests to confirm that a supplied TimeZone is valid
.DESCRIPTION
    Tests to confirm that a supplied TimeZone is valid
.PARAMETER TimeZone
    TimeZone string to test is valid
.PARAMETER TimeZoneFile
    Path to JSON file containing valid timezones
.EXAMPLE
    C:\PS>"UTC" | Test-StatusCakeHelperTimeZone
    Test if UTC is a valid time zone
.OUTPUTS
    Returns true if Time Zone is valid
#>
function Test-StatusCakeHelperTimeZone
{
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Boolean])]
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
