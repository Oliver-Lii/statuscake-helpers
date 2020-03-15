
<#
.SYNOPSIS
    Gets a StatusCake PageSpeed Test
.DESCRIPTION
    Retrieves a StatusCake PageSpeed Test. If no name or id is supplied all tests are returned.
    By default only standard information about a test is returned and more detailed information can be retrieved by using detailed switch.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Name
    Name of the PageSpeed test
.PARAMETER ID
    ID of the PageSpeed Test
.PARAMETER Detailed
    Retrieve detailed test data
.EXAMPLE
    C:\PS>Get-StatusCakeHelperPageSpeedTest
    Retrieve all page speed tests
.EXAMPLE
    C:\PS>Get-StatusCakeHelperPageSpeedTest -Name "Example Page Speed Test" -Detailed
    Retrieve detailed page speed test information for a test called "Example Page Speed Test"

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

