
<#
.SYNOPSIS
    Retrieves the details of a StatusCake Page Speed Test
.DESCRIPTION
    Retrieves StatusCake Detailed Page Speed Test Data via the Test ID
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    Test ID to retrieve detailed test data
.EXAMPLE
    C:\PS>Get-StatusCakeHelperPageSpeedTestDetail -ID 123456
    Retrieve detailed page speed test data by ID 123456
.OUTPUTS
    Returns the details of the page speed test

#>
function Get-StatusCakeHelperPageSpeedTestDetail
{
    [CmdletBinding(PositionalBinding=$false)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [ValidateNotNullOrEmpty()]
        [int]$ID

    )

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Pagespeed/"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = @{id = $ID}
    }

    $response = Invoke-RestMethod @requestParams
    $requestParams=@{}

    if($response.Error)
    {
        Write-Error "ErrNo[$($response.ErrNo)] - $($response.Error)"
    }
    else
    {
        $result = $response.data
    }
    Return $result
}

