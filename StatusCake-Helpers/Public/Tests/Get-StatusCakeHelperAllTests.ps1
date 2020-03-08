
<#
.Synopsis
   Gets all the StatusCake Tests that the user has permission for
.EXAMPLE
   Get-StatusCakeHelperAllTests -Username "Username" -ApiKey "APIKEY"
.INPUTS
    baseTestURL - Base URL endpoint of the statuscake auth API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API

    CUID - Filter tests using a specific Contact Group ID
    Status - Filter tests to a specific status
    Tags - Match tests with tags
    Matchany - Match tests which have any of the supplied tags (true) or all of the supplied tags (false)
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

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [ValidatePattern('^\d{1,}$')]
        $CUID,

        [ValidateSet("Down","Up")]
        $Status,

        [array]$tags,

        [ValidateSet("true","false")]
        [string]$matchany
    )

    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    Write-Warning -Message "Get-StatusCakeHelperAllTests will be deprecated in the next release"
    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("baseTestURL","Username","ApiKey")
    foreach ($key in $ParameterList.keys)
    {
        $var = Get-Variable -Name $key -ErrorAction SilentlyContinue;
        if($ParamsToIgnore -contains $var.Name)
        {
            continue
        }
        elseif($var.value -or $var.value -eq 0)
        {
            $psParams.Add($var.name,$var.value)
        }
    }

    $statusCakeAPIParams = $psParams | ConvertTo-StatusCakeHelperAPIParams

    $requestParams = @{
        uri = $baseTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    $jsonResponse = Invoke-WebRequest @requestParams
    $response = $jsonResponse | ConvertFrom-Json
    Return $response
}

