
<#
.Synopsis
   Remove a StatusCake Public Reporting Page
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER ID
    ID of the public reporting page
.PARAMETER Title
    Title of the public reporting page
.PARAMETER Passthru
    Return the object to be deleted
.EXAMPLE
   Remove-StatusCakeHelperPublicReportingPage -ID 123456
.FUNCTIONALITY
   Deletes a StatusCake Public Reporting page using the supplied ID.
#>
function Remove-StatusCakeHelperPublicReportingPage
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [string]$id,

        [Parameter(ParameterSetName = "title")]
        [string]$title,

        [switch]$PassThru
    )

    $checkParams = @{}
    if($title)
    {
        $checkParams.Add("title",$title)
    }
    else
    {
        $checkParams.Add("id",$id)
    }

    $publicReportingPage = Get-StatusCakeHelperPublicReportingPage -APICredential $APICredential -Detailed @checkParams
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

    $requestParams = @{
        uri = "https://app.statuscake.com/API/PublicReporting/Update/?id=$id"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Delete"
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Remove StatusCake Public Reporting page") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams=@{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
        }
        elseif($PassThru)
        {
            Return $publicReportingPage
        }
    }
}