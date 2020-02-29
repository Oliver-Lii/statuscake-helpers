
<#
.Synopsis
   Retrieves a StatusCake Test with a specific name or Test ID
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestName
    Name of the test to retrieve
.PARAMETER TestID
    Test ID to retrieve
.PARAMETER Detailed
    Retrieve detailed test data
.PARAMETER ContactID
    Filter tests using a specific Contact Group ID
.PARAMETER Status
    Filter tests to a specific status
.PARAMETER Tags
    Match tests with tags
.PARAMETER Matchany
    Match tests which have any of the supplied tags (true) or all of the supplied tags (false)
.EXAMPLE
   Get-StatusCakeHelperTest -testID 123456
.OUTPUTS
    Returns the details of the test which exists returning $null if no matching test
.FUNCTIONALITY
    Retrieves StatusCake Test via the test name of the test or Test ID
#>
function Get-StatusCakeHelperTest
{
    [CmdletBinding(PositionalBinding=$false,DefaultParameterSetName='MatchTag')]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ByTestName")]
        [ValidateNotNullOrEmpty()]
        [string]$TestName,

        [Parameter(ParameterSetName = "ByTestID")]
        [ValidateNotNullOrEmpty()]
        [int]$TestID,

        [Parameter(ParameterSetName = "ByTestName")]
        [Parameter(ParameterSetName = "ByTestID")]
        [switch]$Detailed,

        [Alias('CUID')]
        [Parameter(Mandatory=$false,ParameterSetName='MatchTag')]
        [Parameter(Mandatory=$false,ParameterSetName='MatchAnyTag')]
        [ValidateNotNullOrEmpty()]
        [int]$ContactID,

        [Parameter(Mandatory=$false,ParameterSetName='MatchTag')]
        [Parameter(Mandatory=$false,ParameterSetName='MatchAnyTag')]
        [ValidateSet("Down","Up")]
        [string]$Status,

        [Parameter(Mandatory=$false,ParameterSetName='MatchTag')]
        [Parameter(Mandatory=$true,ParameterSetName='MatchAnyTag')]
        [string[]]$tags,

        [Parameter(Mandatory=$false,ParameterSetName='MatchAnyTag')]
        [ValidateSet("true","false")]
        [string]$matchany
    )

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Tests/"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
    }

    if($PSCmdlet.ParameterSetName -eq "MatchTag" -or $PSCmdlet.ParameterSetName -eq "MatchAnyTag")
    {
        $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
        $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation
        $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter
        $requestParams.Add("ContentType","application/x-www-form-urlencoded")
        $requestParams.Add("body",$statusCakeAPIParams)
        $requestParams.Add("method","Get")
    }

    $response = Invoke-RestMethod @requestParams
    $matchingTests = $response
    if($TestName)
    {
        $matchingTests = $response | Where-Object {$_.WebsiteName -eq $TestName}
    }
    elseif($TestID)
    {
        $matchingTests = $response | Where-Object {$_.TestID -eq $TestID}
    }

    $result = $matchingTests
    if($Detailed)
    {
        $detailList = [System.Collections.Generic.List[PSObject]]::new()
        foreach($test in $matchingTests)
        {
            $item = Get-StatusCakeHelperTestDetail -APICredential $APICredential -TestID $test.TestID
            $detailList.Add($item)
        }
        $result = $detailList
    }
    $requestParams = @{}
    Return $result
}

