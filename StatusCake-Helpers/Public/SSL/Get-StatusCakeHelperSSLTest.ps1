
<#
.SYNOPSIS
    Gets a StatusCake SSL Test
.DESCRIPTION
    Retrieves a StatusCake SSL Test. If no domain or id is supplied all tests are returned.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Domain
    Name of the test to retrieve
.PARAMETER ID
    Test ID to retrieve
.EXAMPLE
    C:\PS>Get-StatusCakeHelperSSLTest
    Retrieve all SSL tests
.EXAMPLE
    C:\PS>Get-StatusCakeHelperSSLTest -ID 123456
    Retrieve SSL test with ID 123456
.OUTPUTS
    Returns a StatusCake SSL Tests as an object
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

