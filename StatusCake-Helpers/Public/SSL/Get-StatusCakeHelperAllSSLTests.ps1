
<#
.Synopsis
   Gets all StatusCake SSL Tests
.EXAMPLE
   Get-StatusCakeHelperAllSSLTests
.INPUTS
    baseSSLTestURL - Base URL endpoint of the statuscake auth API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
.OUTPUTS
    Returns all the StatusCake SSL Tests as an object
.FUNCTIONALITY
    Retrieves all the SSL Tests from StatusCake

#>
function Get-StatusCakeHelperAllSSLTests
{
    [CmdletBinding(PositionalBinding=$false)]
    Param(
        $baseSSLTestURL = "https://app.statuscake.com/API/SSL/",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password
    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    Write-Warning -Message "Get-StatusCakeHelperAllSSLTests will be deprecated in the next release"

    $requestParams = @{
        uri = $baseSSLTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
    }

    $jsonResponse = Invoke-WebRequest @requestParams
    $response = $jsonResponse | ConvertFrom-Json
    Return $response
}

