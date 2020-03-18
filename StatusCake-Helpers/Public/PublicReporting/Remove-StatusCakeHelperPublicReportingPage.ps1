
<#
.SYNOPSIS
   Remove a StatusCake Public Reporting Page
.DESCRIPTION
   Deletes a StatusCake Public Reporting page using the supplied ID.
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER ID
    ID of the public reporting page
.PARAMETER Title
    Title of the public reporting page
.PARAMETER Passthru
    Return the object to be deleted
.EXAMPLE
   C:\PS>Remove-StatusCakeHelperPublicReportingPage -ID a1B2c3D4e5
   Delete the public reporting page with ID a1B2c3D4e5
.EXAMPLE
   C:\PS>Remove-StatusCakeHelperPublicReportingPage -Title "Example.com Public Reporting Page"
   Delete the public reporting page called "Example.com Public Reporting Page"

#>
function Remove-StatusCakeHelperPublicReportingPage
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [string]$ID,

        [Parameter(ParameterSetName = "Title")]
        [string]$Title,

        [switch]$PassThru
    )

    $checkParams = @{}
    if($Title)
    {
        $checkParams.Add("title",$Title)
    }
    else
    {
        $checkParams.Add("id",$ID)
    }

    $publicReportingPage = Get-StatusCakeHelperPublicReportingPage -APICredential $APICredential -Detailed @checkParams
    if($publicReportingPage)
    {
        if($publicReportingPage.GetType().Name -eq 'Object[]')
        {
            Write-Error "Multiple Public Reporting pages found with title [$Title]. Please remove the Public Reporting page by ID"
            Return $null
        }
        $ID = $publicReportingPage.id
    }
    else
    {
        Write-Error "Unable to find Public Reporting page with name [$Title]"
        Return $null
    }

    $requestParams = @{
        uri = "https://app.statuscake.com/API/PublicReporting/Update/?id=$ID"
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