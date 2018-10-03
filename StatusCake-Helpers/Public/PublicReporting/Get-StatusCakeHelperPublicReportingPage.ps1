
<#
.Synopsis
   Retrieves a StatusCake Public Reporting Page
.EXAMPLE
   Get-StatusCakeHelperPublicReportingPage -id 123456
.INPUTS
    baseAPIURL - Base URL endpoint of the statuscake auth API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    Title - Name of the test to retrieve
    ID - Test ID to retrieve
.OUTPUTS
    Returns StatusCake Public Reporting Pages as an object
.FUNCTIONALITY
    Retrieves all StatusCake Public Reporting Pages if no parameters supplied otherwise returns the specified public reporting page.

#>
function Get-StatusCakeHelperPublicReportingPage
{
    [CmdletBinding(PositionalBinding=$false)]
    Param(
        $baseAPIURL = "https://app.statuscake.com/API/PublicReporting/",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [ValidateNotNullOrEmpty()]
        [string]$title,

        [ValidateNotNullOrEmpty()]
        [string]$id
    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}

    $requestParams = @{
        uri = $baseAPIURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
    }

    $jsonResponse = Invoke-WebRequest @requestParams
    $response = $jsonResponse | ConvertFrom-Json

    $matchingItems = $response.data
    if($title)
    {
        $matchingItems = $response.data | Where-Object {$_.title -eq $title}
    }
    elseif($id)
    {
        $matchingItems = $response.data | Where-Object {$_.id -eq $id}
    }

    Return $matchingItems

}

