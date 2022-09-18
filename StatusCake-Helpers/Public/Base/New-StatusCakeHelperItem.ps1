
<#
.SYNOPSIS
    Creates a StatusCake Contact Group, Maintenance Window, PageSpeed, SSL or Uptime item
.DESCRIPTION
    Creates a StatusCake Contact Group, Maintenance Window, PageSpeed, SSL or Uptime item and returns the ID. Use the passthru switch to return the details of the test created.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Type
    Type of item to create
.PARAMETER Parameter
    Hashtable of parameters to create the item. The keys and values in the hashtable should match the parameters expected by the StatusCake API
.PARAMETER PassThru
    Return the details of the object created. By default only the ID is returned.
.EXAMPLE
    C:\PS>New-StatusCakeHelperItem -Type "pagespeed" -Parameter @{"name"="Example Page Speed Test"; "website_url"="https://www.example.com"; "check_rate"=86400; "region"="US"}
    Create a pagespeed test called "Example Page Speed Test" to check https://www.example.com every day from the US region
.EXAMPLE
    C:\PS>New-StatusCakeHelperItem -Type "ssl" -Parameter @{"website_url"="https://www.example.com"; "check_rate"=86400}
    Create a ssl test to check https://www.example.com every day
.EXAMPLE
    C:\PS>New-StatusCakeHelperItem -Type "uptime" -Parameter @{"name"="Example Uptime Speed Test";"test_type"="HTTP" "website_url"="https://www.example.com"; "check_rate"=86400}
    Create a uptime test called "Example Uptime Speed Test" to perform a HTTP check to test https://www.example.com every day
.EXAMPLE
    C:\PS>New-StatusCakeHelperItem -Type "contact-groups" -Parameter @{"name"="Example Contact Group"}
    Create a contact group called "Example Contact Group"
.EXAMPLE
    C:\PS>New-StatusCakeHelperItem -Type "maintenance-window" -Parameter @{"name"="Example Contact Group";"start_at"="2022-01-01T00:30:00Z";"end_at"="2022-01-01T01:30:00Z";"timezone"="UTC"}
    Create a maintenance window called "Example Maintenance Window" starting at 1st January 2022 00:30 UTC until 1st January 2022 01:30 UTC
#>
function New-StatusCakeHelperItem
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$true)]
        [ValidateSet("PageSpeed","SSL","Uptime","Contact-Groups","Maintenance-Windows")]
        [string]$Type,

        [hashtable]$Parameter,

        [switch]$PassThru
    )

    $requestParams = @{
        uri = "https://api.statuscake.com/v1/$($Type.ToLower())"
        Headers = @{"Authorization"="Bearer $($APICredential.GetNetworkCredential().password)"}
        UseBasicParsing = $true
        Method = "Post"
        ContentType = "application/x-www-form-urlencoded"
        Body = $Parameter | ConvertTo-StatusCakeHelperXW3FormUrlEncoded
    }

    if( $pscmdlet.ShouldProcess("$($requestParams["uri"])", "$($requestParams["Method"]) request to") )
    {
        do{
            try{
                $id = (Invoke-RestMethod @requestParams).data.new_id
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
        if($PassThru)
        {
            Return Get-StatusCakeHelperItem -ID $id -Type $Type -APICredential $APICredential
        }
        else
        {
            Return $id
        }
    }
}

