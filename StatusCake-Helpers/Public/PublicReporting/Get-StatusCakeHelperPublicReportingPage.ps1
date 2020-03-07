
<#
.Synopsis
   Retrieves a StatusCake Public Reporting Page
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER ID
    ID of the public reporting page
.PARAMETER Title
    Title of the public reporting page
.PARAMETER Detailed
    Retrieve detailed public reporting page data
.EXAMPLE
   Get-StatusCakeHelperPublicReportingPage -ID 123456
.OUTPUTS
    Returns StatusCake Public Reporting Pages as an object
.FUNCTIONALITY
    Retrieves all StatusCake Public Reporting Pages if no parameters supplied otherwise returns the specified public reporting page.

#>
function Get-StatusCakeHelperPublicReportingPage
{
    [CmdletBinding(PositionalBinding=$false)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [ValidateNotNullOrEmpty()]
        [string]$Title,

        [ValidateNotNullOrEmpty()]
        [string]$ID,

        [switch]$Detailed
    )

    $requestParams = @{
        uri = "https://app.statuscake.com/API/PublicReporting/"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
    }

    $response = Invoke-RestMethod @requestParams
    $requestParams = @{}
    $matchingItems = $response.data
    if($Title)
    {
        $matchingItems = $response.data | Where-Object {$_.title -eq $Title}
    }
    elseif($ID)
    {
        $matchingItems = $response.data | Where-Object {$_.id -eq $ID}
    }

    $result = $matchingItems
    if($Detailed)
    {
        $detailList = [System.Collections.Generic.List[PSObject]]::new()
        foreach($test in $matchingItems)
        {
            $item = Get-StatusCakeHelperPublicReportingPageDetail -APICredential $APICredential -Id $test.Id
            $detailList.Add($item)
        }
        $result = $detailList
    }
    $requestParams = @{}
    Return $result

}

