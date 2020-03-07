
<#
.Synopsis
    Gets a StatusCake SSL Test
.EXAMPLE
    Get-StatusCakeHelperSSLTest -Username "Username" -ApiKey "APIKEY" -id 123456
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Domain
    Name of the test to retrieve
.PARAMETER ID
    Test ID to retrieve
.OUTPUTS
    Returns a StatusCake SSL Tests as an object
.FUNCTIONALITY
    Retrieves a specific StatusCake SSL Test

#>
function Get-StatusCakeHelperSSLTest
{
    [CmdletBinding(PositionalBinding=$false,DefaultParameterSetName='All')]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "Domain")]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$Domain,

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID
    )

    $requestParams = @{
        uri = "https://app.statuscake.com/API/SSL/"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
    }

    $response = Invoke-RestMethod @requestParams
    $requestParams = @{}

    if($Domain)
    {
        $matchingTests = $response | Where-Object {$_.domain -eq $Domain}
    }
    elseif($ID)
    {
        $matchingTests = $response | Where-Object {$_.id -eq $ID}
    }
    else
    {
        $matchingTests = $response
    }

    if($matchingTests)
    {
        Return $matchingTests
    }

    Return $null
}

