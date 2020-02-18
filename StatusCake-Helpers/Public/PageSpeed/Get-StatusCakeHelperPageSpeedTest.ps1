
<#
.Synopsis
   Gets a StatusCake PageSpeed Test
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Name
    Name of the PageSpeed test
.PARAMETER Id
    ID of the PageSpeed Test
.PARAMETER Detailed
    Retrieve detailed test data
.EXAMPLE
   Get-StatusCakeHelperPageSpeedTest -Username "Username" -ApiKey "APIKEY" -id 123456
.OUTPUTS
    Returns a StatusCake PageSpeed Tests as an object
.FUNCTIONALITY
    Retrieves a specific StatusCake PageSpeed Test

#>
function Get-StatusCakeHelperPageSpeedTest
{
    [CmdletBinding(PositionalBinding=$false,DefaultParameterSetName='All')]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "name")]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$name,

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$id,

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

    if($name)
    {
        $matchingTests = $response.data | Where-Object {$_.Title -eq $name}
    }
    elseif($id)
    {
        $matchingTests = $response.data | Where-Object {$_.ID -eq $id}
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

