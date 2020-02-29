
<#
.Synopsis
   Remove a StatusCake SSL Test
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Domain
    Name of the test to retrieve
.PARAMETER ID
    Test ID to retrieve
.PARAMETER PassThru
    Return the object that is removed
.EXAMPLE
   Remove-StatusCakeHelperSSLTest -Username "Username" -ApiKey "APIKEY" -ID 123456
.FUNCTIONALITY
   Deletes a StatusCake SSL Test using the supplied ID.
#>
function Remove-StatusCakeHelperSSLTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [int]$id,

        [Parameter(ParameterSetName = "domain")]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [string]$domain,

        [switch]$PassThru
    )

    $checkParams = @{}
    if($domain)
    {
        $checkParams.Add("domain",$domain)
    }
    else
    {
        $checkParams.Add("id",$id)
    }

    $sslTest = Get-StatusCakeHelperSSLTest -APICredential $APICredential @checkParams
    if($sslTest)
    {
        if($sslTest.GetType().Name -eq 'Object[]')
        {
            Write-Error "Multiple SSL Tests found with domain [$domain]. Please remove the SSL test by ID"
            Return $null
        }
        $id = $sslTest.id
    }
    else
    {
        Write-Error "Unable to find SSL Test with name [$domain]"
        Return $null
    }

    $requestParams = @{
        uri = "https://app.statuscake.com/API/SSL/Update?id=$id"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Delete"
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Remove StatusCake SSL Test") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams = @{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
        }
        elseif($PassThru)
        {
            Return $sslTest
        }
    }
}