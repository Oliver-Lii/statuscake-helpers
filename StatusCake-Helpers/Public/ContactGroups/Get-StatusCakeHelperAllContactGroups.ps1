
<#
.Synopsis
   Gets all the StatusCake Contact Groups
.EXAMPLE
   Get-StatusCakeHelperAllContactGroups -Username "Username" -ApiKey "APIKEY"
.INPUTS
    baseContactGroupURL - Base URL endpoint of the statuscake auth API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
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
        [Parameter(Mandatory=$true)]        
        $Username,
        [Parameter(Mandatory=$true)]        
        $ApiKey
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}

    $requestParams = @{
        uri = $baseContactGroups
        Headers = $authenticationHeader
        UseBasicParsing = $true
    }

    $jsonResponse = Invoke-WebRequest @requestParams
    $response = $jsonResponse | ConvertFrom-Json
    Return $response
}

