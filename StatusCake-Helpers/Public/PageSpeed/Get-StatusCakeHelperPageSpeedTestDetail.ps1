
<#
.Synopsis
   Retrieves the details of a StatusCake Page Speed Test
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestID
    Test ID to retrieve detailed test data
.EXAMPLE
   Get-StatusCakeHelperPageSpeedTestDetail -ID 123456
.OUTPUTS
    Returns the details of the page speed test
.FUNCTIONALITY
    Retrieves StatusCake Detailed Page Speed Test Data via the Test ID
#>
function Get-StatusCakeHelperPageSpeedTestDetail
{
    [CmdletBinding(PositionalBinding=$false)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [ValidateNotNullOrEmpty()]
        [int]$id

    )

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Pagespeed/"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = @{id = $id}
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

