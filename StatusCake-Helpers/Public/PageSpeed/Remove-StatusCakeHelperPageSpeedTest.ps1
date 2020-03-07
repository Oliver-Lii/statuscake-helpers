
<#
.Synopsis
   Remove a StatusCake PageSpeed Test
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Name
    Name for PageSpeed test
.PARAMETER ID
    ID of the PageSpeed Test to remove
.PARAMETER Passthru
    2-letter ISO code of the location. Valid values: AU, CA, DE, IN, NL, SG, UK, US, PRIVATE
.EXAMPLE
   Remove-StatusCakeHelperPageSpeedTest -ID 123456
.FUNCTIONALITY
   Deletes a StatusCake PageSpeed Test using the supplied ID.
#>
function Remove-StatusCakeHelperPageSpeedTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [int]$ID,

        [Parameter(ParameterSetName = "Name")]
        [string]$Name,

        [switch]$PassThru
    )

    $checkParams = @{}
    if($Name)
    {
        $checkParams.Add("name",$Name)
    }
    else
    {
        $checkParams.Add("id",$ID)
    }

    $pageSpeedTest = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -Detailed @checkParams
    if($pageSpeedTest)
    {
        if($pageSpeedTest.GetType().Name -eq 'Object[]')
        {
            Write-Error "Multiple PageSpeed Tests found with name [$Name]. Please remove the PageSpeed test by ID"
            Return $null
        }
        $ID = $pageSpeedTest.id
    }
    else
    {
        Write-Error "Unable to find PageSpeed Test with name [$Name]"
        Return $null
    }

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Pagespeed/Update/?id=$ID"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Delete"
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Remove StatusCake PageSpeed Test") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams = @{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
        }
        elseif($PassThru)
        {
            Return $pageSpeedTest
        }
    }
}