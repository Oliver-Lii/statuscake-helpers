
<#
.SYNOPSIS
    Gets the history of a StatusCake PageSpeed Test
.DESCRIPTION
    Retrieves the history for a StatusCake PageSpeed Test. Use the Days parameter to specify the number of days which should be retrieved.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the PageSpeed Test
.PARAMETER Name
    Name of the PageSpeed test
.PARAMETER Before
    Return only results from before this date
.PARAMETER Limit
    The maximum of number of results to return
.EXAMPLE
    C:\PS>Get-StatusCakeHelperPageSpeedTestHistory -ID 123456
    Retrieve the page speed test history for page speed test with id 123456
.EXAMPLE
    C:\PS>Get-StatusCakeHelperPageSpeedTestHistory -ID 123456 -Before 2022-01-01
    Retrieve all page speed test history before the 1st January 2022
.EXAMPLE
    C:\PS>Get-StatusCakeHelperPageSpeedTestHistory -ID 123456 -Limit 1
    Retrieve the history of the most recent page speed test
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/PageSpeed/Get-StatusCakeHelperPageSpeedTestHistory.md
.LINK
    https://www.statuscake.com/api/v1/#tag/pagespeed/operation/list-pagespeed-test-history
.OUTPUTS
    Returns a StatusCake PageSpeed Tests History as an object
#>
function Get-StatusCakeHelperPageSpeedTestHistory
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
        [int]$Limit
    )

    # If name supplied find the ID of the test
    if($Name)
    {
        $statusCakeItem = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -Name $Name
        $ID = $statusCakeItem.id
    }

    $metaDataParameters = @{
        APICredential = $APICredential
        Type = "PageSpeed"
        Property = "History"
        ID = $ID
    }

    if($Before)
    {
        $parameter = $Before | ConvertTo-StatusCakeHelperAPIValue -DateUnix @("Before")
        $metaDataParameters["Parameter"] = $parameter
    }

    if($Limit)
    {
        $metaDataParameters["ResultLimit"] = $Limit
    }

    Return (Get-StatusCakeHelperItemMetadata @metaDataParameters)

}

