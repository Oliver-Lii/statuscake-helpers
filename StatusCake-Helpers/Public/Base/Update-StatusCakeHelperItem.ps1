
<#
.SYNOPSIS
    Update a StatusCake item
.DESCRIPTION
    Update a StatusCake Contact Group, Maintenance Window, PageSpeed, SSL or Uptime item
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the test
.PARAMETER Type
    Type of test to remove
.PARAMETER Parameter
    Hashtable of parameters to use to update the StatusCake item
.EXAMPLE
    C:\PS>Update-StatusCakeHelperItem -Type "PageSpeed" -ID 12345 -Parameter @{"check_rate"="3600"}
    Update a pagespeed test called "Example Page Speed Test" to check every hour
.EXAMPLE
    C:\PS>Update-StatusCakeHelperItem -Type "SSL" -ID 12345 -Parameter @{"check_rate"=86400}
    Update a ssl test to check the SSL certificate of https://www.example.com every day
.EXAMPLE
    C:\PS>Update-StatusCakeHelperItem -Type "Uptime" ID 12345 -Parameter @{"name"="New Example Uptime Speed Test"}
    Update a uptime test called "Example Uptime Speed Test" and change it's name to "New Example Uptime Speed Test"
.EXAMPLE
    C:\PS>Update-StatusCakeHelperItem -Type "Contact-Groups" ID 12345 -Parameter @{"email_addresses"="postmaster@example.com"}
    Update a contact group called "Example Contact Group" to use the email address postmaster@example.com
.EXAMPLE
    C:\PS>Update-StatusCakeHelperItem -Type "Maintenance-Window" -ID 12345 -Parameter @{"repeat_interval"=2w}
    Update a maintenance window with ID 12345 to have a repeat interval of every 2 weeks
#>
function Update-StatusCakeHelperItem
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID,

        [Parameter(Mandatory=$true)]
        [ValidateSet("Contact-Groups","Heartbeat","Maintenance-Windows","PageSpeed","SSL","Uptime")]
        [string]$Type,

        [hashtable]$Parameter
    )

    $requestParams = @{
        uri = "https://api.statuscake.com/v1/$($Type.ToLower())/$ID"
        Headers = @{"Authorization"="Bearer $($APICredential.GetNetworkCredential().password)"}
        UseBasicParsing = $true
        Method = "Put"
        ContentType = "application/x-www-form-urlencoded"
        Body = $Parameter | ConvertTo-StatusCakeHelperXW3FormUrlEncoded
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

