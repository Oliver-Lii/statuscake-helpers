
<#
.Synopsis
   Gets a StatusCake SSL Test
.EXAMPLE
   Get-StatusCakeHelperSSLTest -Username "Username" -ApiKey "APIKEY" -id 123456
.INPUTS
    baseSSLTestURL - Base URL endpoint of the statuscake auth API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    Domain - Name of the test to retrieve
    ID - Test ID to retrieve    
.OUTPUTS    
    Returns a StatusCake SSL Tests as an object
.FUNCTIONALITY
    Retrieves a specific StatusCake SSL Test
   
#>
function Get-StatusCakeHelperSSLTest
{
    [CmdletBinding(PositionalBinding=$false)]    
    Param(
        $baseSSLTestURL = "https://app.statuscake.com/API/SSL/",
        [Parameter(Mandatory=$true)]        
        $Username,
        [Parameter(Mandatory=$true)]        
        $ApiKey,

        [Parameter(ParameterSetName = "Domain")]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$domain,

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]            
        [int]$id      
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}

    $requestParams = @{
        uri = $baseSSLTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
    }

    $jsonResponse = Invoke-WebRequest @requestParams
    $response = $jsonResponse | ConvertFrom-Json

    if($domain)
    {
        $matchingTests = $response | Where-Object {$_.domain -eq $domain}
    }
    elseif($id)
    {
        $matchingTests = $response | Where-Object {$_.id -eq $id}
    }

    if($matchingTests)
    {
        Return $matchingTests
    }

    Return $null
}

