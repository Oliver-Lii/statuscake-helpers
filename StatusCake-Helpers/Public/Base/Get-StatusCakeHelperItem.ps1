
<#
.SYNOPSIS
    Gets a StatusCake Contact Group, Maintenance Window, PageSpeed, SSL or Uptime item
.DESCRIPTION
    Retrieves a StatusCake item by type. If no name or id is supplied all items of that type are returned.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the item to retrieve
.PARAMETER Type
    Type of item to retrieve
.PARAMETER Parameter
    Hashtable of parameters for the item. The keys and values in the hashtable should match the parameters expected by the StatusCake API.
.PARAMETER Limit
    Number of items to retrieve per page
.EXAMPLE
    C:\PS>Get-StatusCakeHelperItem -Type "PageSpeed"
    Retrieve all pagespeed tests
.EXAMPLE
    C:\PS>Get-StatusCakeHelperItem -Type "SSL" -ID 1234
    Retrieve ssl test information for a test with ID 1234
#>
function Get-StatusCakeHelperItem
{
    [CmdletBinding(PositionalBinding=$false,DefaultParameterSetName='All')]
    [OutputType([System.Collections.Generic.List[PSObject]])]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID,

        [Parameter(Mandatory=$true)]
        [ValidateSet("Contact-Groups","Heartbeat","Maintenance-Windows","PageSpeed","SSL","Uptime")]
        [string]$Type,

        [ValidateNotNullOrEmpty()]
        [hashtable]$Parameter,

        [ValidateRange(1,100)]
        [int]$Limit=25
    )

    $requestURL = "https://api.statuscake.com/v1/$($Type.ToLower())"
    $requestParams = @{
        Headers = @{"Authorization"="Bearer $($APICredential.GetNetworkCredential().password)"}
        Method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        UseBasicParsing = $true
    }

    $itemData = [System.Collections.Generic.List[PSObject]]::new()
    do
    {
        try{
            if($ID)
            {
                $requestParams["uri"] = "$requestURL/$ID"
                $response = Invoke-RestMethod @requestParams
                $itemData = $response.data
            }
            else
            {
                $page =1
                if($Parameter)
                {
                    $Parameter["limit"] = $Limit
                }
                else
                {
                    $Parameter = @{"limit" = $Limit}
                }

                do{
                    $Parameter["page"] = $page
                    $queryParameters = $Parameter | ConvertTo-StatusCakeHelperXW3FormUrlEncoded
                    $requestParams["uri"] = "$requestURL`?$queryParameters"
                    $response = Invoke-RestMethod @requestParams
                    $response.data | ForEach-Object{$itemData.Add($_)}
                    $page++

                }
                while($page -le $response.metadata.page_count)
            }
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
    Return $itemData
}
