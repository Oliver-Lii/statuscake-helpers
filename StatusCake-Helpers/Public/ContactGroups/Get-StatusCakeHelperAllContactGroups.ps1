
<#
.Synopsis
   Gets all the StatusCake Contact Groups
.PARAMETER baseContactGroupURL
    Base URL endpoint of the statuscake Contact Group API
.PARAMETER Username
    Username associated with the API key
.PARAMETER ApiKey
    APIKey to access the StatusCake API
.EXAMPLE
   Get-StatusCakeHelperAllContactGroups -Username "Username" -ApiKey "APIKEY"
.OUTPUTS
    Returns all the StatusCake ContactGroups as an object
.FUNCTIONALITY
    Retrieves all the contact groups from StatusCake

#>
function Get-StatusCakeHelperAllContactGroups
{
    [CmdletBinding(PositionalBinding=$false)]
    Param(
        $baseContactGroups = "https://app.statuscake.com/API/ContactGroups/",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password
    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    Write-Warning "Get-StatusCakeHelperAllContactGroups will be deprecated in the next release"
    $requestParams = @{
        uri = $baseContactGroups
        Headers = $authenticationHeader
        UseBasicParsing = $true
    }

    $jsonResponse = Invoke-WebRequest @requestParams
    $response = $jsonResponse | ConvertFrom-Json
    Return $response
}

