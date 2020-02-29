
<#
.Synopsis
   Retrieves a StatusCake Test with a Test ID
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestID
    Test ID to retrieve detailed test data
.EXAMPLE
   Get-StatusCakeHelperTestDetail -testID 123456
.OUTPUTS
    Returns the details of the test
.FUNCTIONALITY
    Retrieves StatusCake Detailed Test Data via the Test ID
#>
function Get-StatusCakeHelperTestDetail
{
    [CmdletBinding(PositionalBinding=$false)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [ValidateNotNullOrEmpty()]
        [int]$TestID

    )

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Tests/Details/"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        body = @{TestID = $TestID}
        UseBasicParsing = $true
    }

    $response = Invoke-RestMethod @requestParams
    $requestParams=@{}

    if($response.Error)
    {
        Write-Error "ErrNo[$($response.ErrNo)] - $($response.Error)"
    }
    else
    {
        $result = $response
    }
    Return $result
}

