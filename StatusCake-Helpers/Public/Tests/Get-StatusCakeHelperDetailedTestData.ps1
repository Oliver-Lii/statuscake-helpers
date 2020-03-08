
<#
.Synopsis
   Retrieves the detailed StatusCake Test data
.EXAMPLE
   Get-StatusCakeHelperDetailedTestData -Username "Username" -ApiKey "APIKEY" -TestID 123456
.INPUTS
    baseTestURL - Base URL endpoint of the statuscake auth API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    TestID - ID of the Test to retrieve the detailed information for
    TestName - Name of the Test to retrieve the detailed information for
.OUTPUTS
    Returns all the StatusCake Tests as an object
.FUNCTIONALITY
    Retrieves the detailed StatusCake Test data for a specific Test ID or Test Name

#>
function Get-StatusCakeHelperDetailedTestData
{
    [CmdletBinding(PositionalBinding=$false)]
    Param(
        $baseTestURL = "https://app.statuscake.com/API/Tests/Details/?TestID=",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName = "Test ID")]
        [ValidateNotNullOrEmpty()]
        [int]$TestID,
        [Parameter(ParameterSetName = "Test Name")]
        [ValidateNotNullOrEmpty()]
        [string]$TestName

    )

    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}
    Write-Warning -Message "Get-StatusCakeHelperDetailedTestData will be renamed to Get-StatusCakeHelperTestDetail in the next release"
    if($TestName)
    {
        $testCheck = Get-StatusCakeHelperTest @statusCakeFunctionAuth -TestName $TestName
        if($testCheck)
        {
            $TestID = $testCheck.TestID
        }
        else
        {
            Write-Error "Unable to find Test with name [$TestName]"
            Return $null
        }
    }

    $requestParams = @{
        uri = "$baseTestURL$TestID"
        Headers = $authenticationHeader
        UseBasicParsing = $true
    }

    $jsonResponse = Invoke-WebRequest @requestParams
    $response = $jsonResponse | ConvertFrom-Json
    if($response.error)
    {
        Write-Error "$($response.Error)"
    }
    Return $response
}

