
<#
.Synopsis
   Remove a StatusCake Public Reporting Page
.EXAMPLE
   Remove-StatusCakeHelperPublicReportingPage -ID 123456
.INPUTS
    baseAPIURL - Base URL endpoint of the statuscake ContactGroup API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    
    ID - ID of the Public Reporting page to remove
    Title - The URL of the Public Reporting page to remove
.FUNCTIONALITY
   Deletes a StatusCake Public Reporting page using the supplied ID.
#>
function Remove-StatusCakeHelperPublicReportingPage
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        $baseAPIURL = "https://app.statuscake.com/API/PublicReporting/Update/?id=",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName = "ID")]
        [string]$id,

        [Parameter(ParameterSetName = "title")]
        [string]$title,

        [switch]$PassThru
    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}

    if($title)
    {
        $publicReportingPage = Get-StatusCakeHelperPublicReportingPage @statusCakeFunctionAuth -title $title
        if($publicReportingPage)
        {
            if($publicReportingPage.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Public Reporting pages found with title [$title]. Please remove the Public Reporting page by ID"
                Return $null
            }
            $id = $publicReportingPage.id
        }
        else
        {
            Write-Error "Unable to find Public Reporting page with name [$title]"
            Return $null
        }
    }

    $webRequestParams = @{
        uri = "$baseAPIURL$id"
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Delete"
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Remove StatusCake Public Reporting page") )
    {
        $jsonResponse = Invoke-WebRequest @webRequestParams
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Verbose $response
            Write-Error "$($response.Message) [$($response.Issues)]"
        }
        if(!$PassThru)
        {
            Return
        }
        Return $response
    }

}