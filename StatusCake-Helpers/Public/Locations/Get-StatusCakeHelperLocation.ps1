<#
.SYNOPSIS
   Retrieve the details of the StatusCake locations from StatusCake
.DESCRIPTION
   Retrieves details of StatusCake locations from StatusCake
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER RegionCode
   The StatusCake region code to return locations for. All locations returned if no region code supplied.
.PARAMETER Type
   The type of test to retrieve locations for. Options are Uptime or Pagespeed. Default is Uptime
.PARAMETER Best
   Return only locations with the least number of tests. Default is false.
.EXAMPLE
   C:\PS>Get-StatusCakeHelperLocation -Type Uptime-Locations
   Retrieve all StatusCake uptime locations
.EXAMPLE
   C:\PS>Get-StatusCakeHelperLocation -Type Uptime-Locations -Location GBR -Best
   Retrieve all StatusCake uptime locations in Great Britian with the least number of checks
.EXAMPLE
   C:\PS>Get-StatusCakeHelperLocation -Type PageSpeed-Locations
   Retrieve all StatusCake pagespeed locations
.OUTPUTS
   StatusCakeLocations - Object containing details of StatusCake Locations
      description : Australia, Sydney - 1
      region      : Australia / Sydney
      region_code : sydney
      status      : up
      ipv4        : 45.76.123.211
.LINK
   https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Locations/Get-StatusCakeHelperLocation.md
.LINK
   https://www.statuscake.com/api/v1/#tag/locations
#>
function Get-StatusCakeHelperLocation
{
   [CmdletBinding(PositionalBinding=$false,DefaultParameterSetName='All')]
   Param(
      [ValidateNotNullOrEmpty()]
      [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

      [ValidateNotNullOrEmpty()]
      [Alias("region_code")]
      [string]$RegionCode,

      [ValidateSet("Uptime-Locations","PageSpeed-Locations")]
      [string]$Type="Uptime-Locations",

      [ValidateNotNullOrEmpty()]
      [bool]$Best
   )

      $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
      $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude @("Type")
      $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIValue

      $requestParams = @{
         uri = "https://api.statuscake.com/v1/$($Type.ToLower())"
         Headers = @{"Authorization"="Bearer $($APICredential.GetNetworkCredential().password)"}
         UseBasicParsing = $true
         Method = "Get"
         Body = $statusCakeAPIParams
      }
      do{
         try {
            $locationList = Invoke-RestMethod @requestParams
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
   Return $locationList.data
}

