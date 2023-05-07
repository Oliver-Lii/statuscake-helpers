
<#
.SYNOPSIS
    Returns uptime check history results for tests
.DESCRIPTION
    Returns uptime check history results for tests detailing the runs performed on the StatusCake testing infrastructure. The return order is newest alerts are shown first.
    Alerts to be returned can be filtered by date using the Before parameter.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the Test to retrieve the sent alerts for
.PARAMETER Name
    Name of the Test to retrieve the sent alerts for
.PARAMETER Before
    Return only results from before this date
.PARAMETER After
    Return only results after this date
.PARAMETER Limit
    The maximum of number of results to return
.OUTPUTS
    Returns an object with the details on the Alerts Sent
.EXAMPLE
    C:\PS> Get-StatusCakeHelperUptimeHistory -ID 123456 -Before "2017-08-19 13:29:49"
    Return all the uptime history for test ID 123456 since the 19th August 2017 13:29:49
.EXAMPLE
    C:\PS> Get-StatusCakeHelperUptimeHistory -ID 123456 -Limit 100
    Return the last 100 historical results sent for test ID 123456
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Uptime/Property/Get-StatusCakeHelperUptimeHistory.md
.LINK
    https://www.statuscake.com/api/v1/#tag/uptime/operation/list-uptime-test-history
#>
function Get-StatusCakeHelperUptimeHistory
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
        Property = "History"
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

