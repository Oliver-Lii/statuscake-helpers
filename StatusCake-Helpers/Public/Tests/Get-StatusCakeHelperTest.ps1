
<#
.Synopsis
   Retrieves a StatusCake Test with a specific name or Test ID
.EXAMPLE
   Get-StatusCakeHelperTest
.INPUTS
    baseTestURL - Base URL endpoint of the statuscake auth API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    TestName - Name of the test to retrieve
    TestID - Test ID to retrieve
.OUTPUTS    
    Returns the details of the test which exists returning $null if no matching test
.FUNCTIONALITY
    Retrieves StatusCake Test via the test name of the test or Test ID
   
#>
function Get-StatusCakeHelperTest
{
    [CmdletBinding(PositionalBinding=$false)]    
    Param(
        $baseTestURL = "https://app.statuscake.com/API/Tests/",
        [Parameter(Mandatory=$true)]        
        $Username,
        [Parameter(Mandatory=$true)]
        $ApiKey,
        [Parameter(ParameterSetName = "Test Name")]
        [ValidateNotNullOrEmpty()]            
        [string]$TestName,
        [Parameter(ParameterSetName = "Test ID")]
        [ValidateNotNullOrEmpty()]            
        [int]$TestID        
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}

    $requestParams = @{
        uri = $baseTestURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
    }

    $jsonResponse = Invoke-WebRequest @requestParams
    $response = $jsonResponse | ConvertFrom-Json

    if($TestName)
    {
        $matchingTests = $response | Where-Object {$_.WebsiteName -eq $TestName}
    }
    elseif($TestID)
    {
        $matchingTests = $response | Where-Object {$_.TestID -eq $TestID}
    }

    if($matchingTests)
    {
        Return $matchingTests
    }
    Return $null
}

