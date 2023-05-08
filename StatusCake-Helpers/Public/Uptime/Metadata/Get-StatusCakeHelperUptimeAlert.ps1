
<#
.SYNOPSIS
    Returns a list of uptime check alerts for a test
.DESCRIPTION
    Returns all alerts that have been triggered for a test by its name or id. The return order is newest alerts are shown first.
    Alerts to be returned can be filtered by date using the After/Before parameters. The number of alerts returned can be controlled
    using the Limit argument.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the Test to retrieve the triggered alerts for
.PARAMETER Name
    Name of the Test to retrieve the triggered alerts for
.PARAMETER Before
    Return only alerts triggered before this date
.PARAMETER After
    Return only alerts triggered after this date
.PARAMETER Limit
    The maximum of number of results to return
.OUTPUTS
    Returns an object with the details on the alerts triggered
.EXAMPLE
    C:\PS> Get-StatusCakeHelperUptimeAlert -ID 123456 -Before "2017-08-19 13:29:49"
    Return all the alerts triggered for test ID 123456 since the 19th August 2017 13:29:49
.EXAMPLE
    C:\PS> Get-StatusCakeHelperUptimeAlert -ID 123456 -After "2018-01-01 00:00:00" -Before "2019-01-01 00:00:00"
    Return all the alerts triggered for test ID 123456 after the 1st January 2018 but before 1st January 2019
.EXAMPLE
    C:\PS> Get-StatusCakeHelperUptimeAlert -ID 123456 -Limit 100
    Return the last 100 alerts triggered for test ID 123456
.EXAMPLE
    C:\PS> Get-StatusCakeHelperUptimeAlert -ID 123456 -Limit 1
    Return the most recent alert triggered for test ID 123456
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Uptime/Base/Get-StatusCakeHelperUptimeAlert.md
.LINK
    https://www.statuscake.com/api/v1/#tag/uptime/operation/list-uptime-test-alerts
#>
function Get-StatusCakeHelperUptimeAlert
{
    [CmdletBinding(PositionalBinding=$false)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID,

        [ValidateNotNullOrEmpty()]
        [datetime]$Before,

        [ValidateNotNullOrEmpty()]
        [datetime]$After,

        [ValidateNotNullOrEmpty()]
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
        Property = "Alerts"
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

