
<#
.SYNOPSIS
    Retrieves a StatusCake Heartbeat Test with a specific name or Test ID
.DESCRIPTION
    Retrieves StatusCake Heartbeat Test via the test name of the test or Test ID
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    Test ID to retrieve
.PARAMETER Name
    Name of the test to retrieve
.PARAMETER Status
    Filter tests to a specific status
.PARAMETER Tag
    Match tests with tags
.PARAMETER MatchAny
    Match tests which have any of the supplied tags (true) or all of the supplied tags (false). Default is false.
.PARAMETER NoUptime
    Do not calculate uptime percentages for results. Default is false.
.PARAMETER Status
    The status of the heartbeat tests to be returned
.EXAMPLE
    C:\PS>Get-StatusCakeHelperHeartbeatTest
    Retrieve all tests
.EXAMPLE
    C:\PS>Get-StatusCakeHelperHeartbeatTest -ID 123456
    Retrieve the test with ID 123456
.OUTPUTS
    Returns the test which exists returning $null if no matching test
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Heartbeat/Get-StatusCakeHelperHeartbeatTest.md
.LINK
    https://www.statuscake.com/api/v1/#tag/heartbeat/operation/list-heartbeat-tests
.LINK
    https://www.statuscake.com/api/v1/#tag/heartbeat/operation/get-heartbeat-test
#>
function Get-StatusCakeHelperHeartbeatTest
{
    [CmdletBinding(PositionalBinding=$false,DefaultParameterSetName='MatchTag')]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ByTestID")]
        [Parameter(ParameterSetName='MatchTag')]
        [Parameter(ParameterSetName='MatchAnyTag')]
        [ValidateNotNullOrEmpty()]
        [int]$ID,

        [Parameter(ParameterSetName = "ByTestName")]
        [Parameter(ParameterSetName='MatchTag')]
        [Parameter(ParameterSetName='MatchAnyTag')]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory=$false,ParameterSetName='MatchTag')]
        [Parameter(Mandatory=$true,ParameterSetName='MatchAnyTag')]
        [Alias('tags')]
        [string[]]$Tag,

        [Parameter(Mandatory=$false,ParameterSetName='MatchTag')]
        [Parameter(Mandatory=$false,ParameterSetName='MatchAnyTag')]
        [switch]$NoUptime,

        [Parameter(Mandatory=$false,ParameterSetName='MatchAnyTag')]
        [switch]$MatchAny,

        [Parameter(Mandatory=$false,ParameterSetName='MatchTag')]
        [Parameter(Mandatory=$false,ParameterSetName='MatchAnyTag')]
        [ValidateSet("down","up")]
        [string]$Status
    )

    if($Name)
    {
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "Heartbeat" | Where-Object{$_.name -eq $Name}
        if($statusCakeItem)
        {
            #Ensure output when retrieving the name is the same as the ID
            $statusCakeItem = $statusCakeItem.id | ForEach-Object{Get-StatusCakeHelperItem -APICredential $APICredential -Type "Heartbeat" -ID $_}
        }
    }
    elseif($ID)
    {
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "Heartbeat" -ID $ID
    }
    else
    {
        $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
        $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude @("Force","Limit")
        if($statusCakeAPIParams.Count -ge 1)
        {
            $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIValue -CsvString "tags"
            $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "Heartbeat" -Parameter $statusCakeAPIParams
        }
        else
        {
            $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "Heartbeat"
        }
    }
    Return $statusCakeItem
}

