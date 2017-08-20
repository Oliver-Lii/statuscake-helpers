
<#
.Synopsis
   Gets all the StatusCake Tests that the user has permission for
.EXAMPLE
   Get-StatusCakeHelperAllTests
.INPUTS
    baseTestURL - Base URL endpoint of the statuscake auth API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
.OUTPUTS    
    Returns all the StatusCake Tests as an object
.FUNCTIONALITY
    Retrieves all the tests from StatusCake that the user has permissions to see
   
#>
function Get-StatusCakeHelperAllTests
{
    [CmdletBinding(PositionalBinding=$false)]    
    Param(
        $baseTestURL = "https://app.statuscake.com/API/Tests/",
        [Parameter(Mandatory=$true)]        
        $Username,
        [Parameter(Mandatory=$true)]        
        $ApiKey
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}

    $requestParams = @{
        uri = $baseTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
    }

    $jsonResponse = Invoke-WebRequest @requestParams
    $response = $jsonResponse | ConvertFrom-Json
    Return $response
}

