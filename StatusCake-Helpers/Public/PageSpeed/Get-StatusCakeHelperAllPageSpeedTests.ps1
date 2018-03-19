
<#
.Synopsis
   Gets all StatusCake PageSpeed Tests
.EXAMPLE
   Get-StatusCakeHelperAllPageSpeedTests -Username "Username" -ApiKey "APIKEY"
.INPUTS
    basePageSpeedTestURL - Base URL endpoint of the statuscake auth API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
.OUTPUTS    
    Returns all the StatusCake PageSpeed Tests as an object
.FUNCTIONALITY
    Retrieves all the PageSpeed Tests from StatusCake
   
#>
function Get-StatusCakeHelperAllPageSpeedTests
{
    [CmdletBinding(PositionalBinding=$false)]    
    Param(
        $basePageSpeedTestURL = "https://app.statuscake.com/API/Pagespeed/",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,
        [ValidateNotNullOrEmpty()]        
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password
    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}

    $requestParams = @{
        uri = $basePageSpeedTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
    }

    $jsonResponse = Invoke-WebRequest @requestParams
    $response = $jsonResponse | ConvertFrom-Json
    Return $response.data
}

