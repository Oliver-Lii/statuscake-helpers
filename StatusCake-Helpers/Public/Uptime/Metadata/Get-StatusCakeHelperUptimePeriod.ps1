
<#
.SYNOPSIS
    Returns a list of uptime check periods for a uptime test
.DESCRIPTION
    Returns a list of uptime check periods for a given id or name, detailing the creation time of the period, when it ended and the duration.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the Test to retrieve the uptime check periods for
.PARAMETER Name
    Name of the Test to retrieve the uptime check periods for
.PARAMETER Before
    Return only check periods created before this date
.PARAMETER After
    Return only check periods created after this date
.PARAMETER Limit
    The maximum of number of results to return
.OUTPUTS
    Returns an object with the details of the uptime check periods
.EXAMPLE
    C:\PS> Get-StatusCakeHelperUptimePeriod -TestID 123456 -Before "2017-08-19 13:29:49"
    Return all the alerts sent for test ID 123456 since the 19th August 2017 13:29:49
.EXAMPLE
    C:\PS> Get-StatusCakeHelperUptimePeriod -ID 123456 -After "2018-01-01 00:00:00" -Before "2019-01-01 00:00:00"
    Return all the uptime check periods for test ID 123456 created after the 1st January 2018 but before 1st January 2019
.EXAMPLE
    C:\PS> Get-StatusCakeHelperUptimePeriod -ID 123456 -Limit 100
    Return the last 100 uptime check periods sent for test ID 123456
.EXAMPLE
    C:\PS> Get-StatusCakeHelperUptimePeriod -ID 123456 -Limit 1
    Return the most recent uptime check period sent for test ID 123456
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Uptime/Property/Get-StatusCakeHelperUptimePeriod.md
.LINK
    https://www.statuscake.com/api/v1/#tag/uptime/operation/list-uptime-test-periods
#>
function Get-StatusCakeHelperUptimePeriod
{
    [CmdletBinding(PositionalBinding=$false)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID,

        [Parameter(ParameterSetName = "name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [ValidateNotNullOrEmpty()]
        [datetime]$Before,

        [ValidateNotNullOrEmpty()]
        [datetime]$After,

        [int]$Limit
    )

    # If name supplied find the ID of the test
    if($Name)
    {
        $statusCakeItem = Get-StatusCakeHelperUptimeTest -APICredential $APICredential -Name $Name
        $ID = $statusCakeItem.id
    }

    $metaDataParameters = @{
        APICredential = $APICredential
        Type = "Uptime"
        Property = "Periods"
        ID = $ID
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $metaDataParameters["Parameter"] = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude @("Limit") | ConvertTo-StatusCakeHelperAPIValue -DateUnix @("Before","After")

    if($Limit)
    {
        $metaDataParameters["ResultLimit"] = $Limit
    }

    Return (Get-StatusCakeHelperItemMetadata @metaDataParameters)

}

