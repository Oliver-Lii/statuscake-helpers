
<#
.SYNOPSIS
    Retrieves a StatusCake Test with a Test ID
.DESCRIPTION
    Retrieves StatusCake Detailed Test Data via the Test ID
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestID
    Test ID to retrieve detailed test data
.EXAMPLE
    C:\PS>Get-StatusCakeHelperTestDetail -testID 123456
    Retrieve detailed test information for test with ID 123456
.OUTPUTS
    Returns detailed test information

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

