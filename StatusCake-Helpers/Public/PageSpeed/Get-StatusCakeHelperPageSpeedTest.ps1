
<#
.Synopsis
   Gets a StatusCake PageSpeed Test
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Name
    Name of the PageSpeed test
.PARAMETER ID
    ID of the PageSpeed Test
.PARAMETER Detailed
    Retrieve detailed test data
.EXAMPLE
    # Retrieve all page speed tests
    Get-StatusCakeHelperPageSpeedTest
.EXAMPLE
    # Retrieve detailed page speed test information for a test
    Get-StatusCakeHelperPageSpeedTest -Name "Example Page Speed Test" -Detailed
.FUNCTIONALITY
    Retrieves a specific StatusCake PageSpeed Test

#>
function Get-StatusCakeHelperPageSpeedTest
{
    [CmdletBinding(PositionalBinding=$false,DefaultParameterSetName='All')]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "Name")]
        [string]$Name,

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID,

        [switch]$Detailed
    )

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Pagespeed/"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
    }

    $response = Invoke-RestMethod @requestParams
    $requestParams=@{}
    $matchingTests = $response.data

    if($Name)
    {
        $matchingTests = $response.data | Where-Object {$_.Title -eq $Name}
    }
    elseif($ID)
    {
        $matchingTests = $response.data | Where-Object {$_.ID -eq $ID}
    }

    $result = $matchingTests
    if($Detailed)
    {
        $detailList = [System.Collections.Generic.List[PSObject]]::new()
        foreach($test in $matchingTests)
        {
            $item = Get-StatusCakeHelperPageSpeedTestDetail -APICredential $APICredential -Id $test.Id
            $detailList.Add($item)
        }
        $result = $detailList
    }
    $requestParams = @{}
    Return $result
}

