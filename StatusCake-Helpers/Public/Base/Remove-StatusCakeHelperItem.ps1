
<#
.SYNOPSIS
    Remove a StatusCake Contact Group, Maintenance Window, PageSpeed, SSL or Uptime item
.DESCRIPTION
    Remove a StatusCake Contact Group, Maintenance Window, PageSpeed, SSL or Uptime item
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the test
.PARAMETER Type
    Type of test to remove
.EXAMPLE
    C:\PS>Remove-StatusCakeHelperItem -Type "PageSpeed" -Name "Example Page Speed Test"
    Remove a pagespeed test with name "Example Page Speed Test"
.EXAMPLE
    C:\PS>Remove-StatusCakeHelperItem -Type "SSL" -ID 1234
    Remove a ssl speed test with ID 1234
#>
function Remove-StatusCakeHelperItem
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID,

        [Parameter(Mandatory=$true)]
        [ValidateSet("PageSpeed","SSL","Uptime","Contact-Groups","Maintenance-Windows")]
        [string]$Type
    )

    $requestParams = @{
        uri = "https://api.statuscake.com/v1/$($Type.ToLower())/$ID"
        Headers = @{"Authorization"="Bearer $($APICredential.GetNetworkCredential().password)"}
        UseBasicParsing = $true
        method = "Delete"
    }

    if( $pscmdlet.ShouldProcess("$($requestParams["uri"])", "$($requestParams["Method"]) request to") )
    {
        do{
            try{
                Invoke-RestMethod @requestParams
                $finished = $true
            }
            catch [System.Net.WebException] {
                if($_.Exception.Response.StatusCode -eq 429)
                {
                    $retryDelay = [int] ($_.Exception.Response.Headers["x-ratelimit-reset"])
                    Write-Verbose "Rate limit exceeded [$($_.Exception.Response.Headers["x-ratelimit-limit"])], retrying in [$retryDelay] seconds"
                    Start-Sleep -Seconds $retryDelay
                }
                else
                {
                    $errorResponse = $_.Exception.Response.GetResponseStream() | Get-StatusCakeHelperAPIErrorResponse
                    Write-Error "A web exception was caught: [$($_.Exception.Message)] / [$($errorResponse.Message)] / [$($errorResponse.Errors -join ",")]"
                    throw $_
                }

            }
        }while ($finished -ne $true)
        $requestParams = @{}
    }
}

