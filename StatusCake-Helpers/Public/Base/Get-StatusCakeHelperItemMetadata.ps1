
<#
.SYNOPSIS
    Gets the metadata for a StatusCake Pagespeed or Uptime test
.DESCRIPTION
    Retrieves the metadata for a StatusCake item by type.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the item
.PARAMETER Type
    Type of item to retrieve
.PARAMETER Property
    Type of metadata to retrieve
.PARAMETER Parameter
    Hashtable of parameters to be used for the request
.PARAMETER PageLimit
    The number of results to return per page
.PARAMETER ResultLimit
    The maximum number of results to return
.EXAMPLE
    C:\PS>Get-StatusCakeHelperItemMetadata -Type "PageSpeed" -Property History -Name "Pagespeed Test"
    Retrieve pagespeed test history for test with name PageSpeed Test
.EXAMPLE
    C:\PS>Get-StatusCakeHelperItemMetadata -Type "Uptime" -Property Alerts -Name "Example Uptime Speed Test"
    Retrieve details of alerts sent for a Uptime test called "Example Page Speed Test"
#>
function Get-StatusCakeHelperItemMetadata
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
        [ValidateSet("PageSpeed","Uptime")]
        [string]$Type,

        [Parameter(Mandatory=$true)]
        [ValidateSet("History","Periods","Alerts")]
        [string]$Property,

        [ValidateNotNullOrEmpty()]
        [hashtable]$Parameter,

        [ValidateRange(1,100)]
        [int]$PageLimit=25,

        [ValidateNotNullOrEmpty()]
        [int]$ResultLimit
    )

    $requestParams = @{
        uri = "https://api.statuscake.com/v1/$($Type.ToLower())/$ID/$($Property.ToLower())"
        Headers = @{"Authorization"="Bearer $($APICredential.GetNetworkCredential().password)"}
        Method = "Get"
        UseBasicParsing = $true
    }

    #If the maximum of results requested is less than the API limit change the page limit to match the maximum number of results requested
    if($ResultLimit -gt 0 -and $ResultLimit -le 100)
    {
        $PageLimit = $ResultLimit
    }

    If($Parameter)
    {
        $Parameter.Add("limit",$PageLimit)
    }
    else
    {
        $Parameter = @{"limit" = $PageLimit}
    }
    $requestParams["Body"] = $Parameter

    $results = 0
    $itemData = [System.Collections.Generic.List[PSObject]]::new()
    do
    {
        try{
            do{
                $response = Invoke-RestMethod @requestParams
                foreach($item in $response.data)
                {
                    $itemData.Add($item)
                }
                $requestParams.Remove("Body")
                $requestParams["uri"] = $response.links.next
                $results += ($response.data).Count

                #If the number of results exceeds the requested amount exit out of the loop
                if($ResultLimit)
                {
                    if($results -ge $ResultLimit)
                    {
                        break
                    }
                    elseif(($ResultLimit - $results) -le 100)
                    {   #If the number of remaining results to retrieve is less than the API limit adjust the limit accordingly to retrieve the requested number
                        $requestParams["Body"] = @{"limit" = ($ResultLimit - $results) }
                    }

                }
            }while($response.links.next)
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

    Return $itemData
}

