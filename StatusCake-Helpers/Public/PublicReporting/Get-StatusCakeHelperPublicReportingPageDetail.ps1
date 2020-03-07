
<#
.Synopsis
   Retrieves a StatusCake Public Reporting Page
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER ID
    ID of the public reporting page
.EXAMPLE
   Get-StatusCakeHelperPublicReportingPageDetail -ID a1b2c3d4
.OUTPUTS
    Returns the details of a StatusCake Public Reporting page
.FUNCTIONALITY
    Retrieves StatusCake Detailed Public Reporting Page Data via the ID

#>
function Get-StatusCakeHelperPublicReportingPageDetail
{
    [CmdletBinding(PositionalBinding=$false)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [ValidateNotNullOrEmpty()]
        [string]$ID
    )

    $requestParams = @{
        uri = "https://app.statuscake.com/API/PublicReporting/"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = @{id = $ID}
    }

    $response = Invoke-RestMethod @requestParams
    $requestParams=@{}

    if(!$response.Success)
    {
        Write-Error "Error Message[$($response.Message)]"
    }
    else
    {
        $result = $response.data
    }
    Return $result

}

