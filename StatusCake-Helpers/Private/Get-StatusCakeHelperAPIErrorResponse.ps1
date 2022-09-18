
<#
.SYNOPSIS
   Gets the StatusCake API error response
.DESCRIPTION
   Get the StatusCake API error response. In Powershell 5.1 the error response has to be retrieved if a web exception error is thrown by Invoke-RestMethod.
.PARAMETER ExceptionResponseStream
   Exception response stream containing the error details to be extracted
.EXAMPLE
   C:\PS>$_.Exception.Response.GetResponseStream() | Get-StatusCakeHelperAPIErrorResponse
   Retrieve the details of the error returned by the StatusCake API
#>
function Get-StatusCakeHelperAPIErrorResponse
{
   [CmdletBinding()]
   Param(
      [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
      $ExceptionResponseStream
   )

   Process
   {
      $streamReader = New-Object System.IO.StreamReader($ExceptionResponseStream)
      $streamReader.BaseStream.Position = 0
      $errorResponse = $streamReader.ReadToEnd() | ConvertFrom-Json

      #Get all the error response property names
      $errorProperties = $errorResponse.errors | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty "Name"

      $apiErrors = [System.Collections.Generic.List[PSObject]]::new()
      #Collate the error property details into a single array
      $errorProperties | ForEach-Object{
         $errorPropMsg = $errorResponse.errors | Select-Object -ExpandProperty $_
         $apiErrors.Add("[$_] $errorPropMsg")
      }

      $statusCakeAPIError = [PSCustomObject]@{
         Message = $errorResponse.message
         Errors = $apiErrors
      }

      Return $statusCakeAPIError
   }
}