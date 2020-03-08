
<#
.Synopsis
   Create a StatusCake Public Reporting Page
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Title
    The title of the Public Reporting Page
.PARAMETER CName
    CName record for a custom domain
.PARAMETER Password
    Password protection for the page. Leave empty to disable
.PARAMETER Twitter
    Twitter handle to display with the @. Leave empty to disable
.PARAMETER DisplayAnnotations
    Set to true to show annotations for status periods
.PARAMETER DisplayOrbs
    Set to true to display uptime as colored orbs
.PARAMETER SearchIndexing
    Set to false to disable search engine indexing
.PARAMETER SortAlphabetical
    Set to true to order tests by alphabetical name
.PARAMETER TestTags
    Array of tags which a test must contain to be included on the Public Reporting Page
.PARAMETER TagsInclusive
    Set to true to select all tests that include one or more of the provided tags
.PARAMETER TestIDs
    Array of TestIDs to be associated with Public Reporting page
.PARAMETER Announcement
    Free text field that will appear as an announcement on the page
.PARAMETER BgColor
    HEX value for the background colour
.PARAMETER HeaderColor
    HEX value for the header colour
.PARAMETER TitleColor
    HEX value for the header text colour
.EXAMPLE
   New-StatusCakeHelperPublicReportingPage -Title "Example.com Public Reporting Page"
.FUNCTIONALITY
   Creates a new StatusCake Public Reporting Page using the supplied parameters.
#>
function New-StatusCakeHelperPublicReportingPage
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true,DefaultParameterSetName='Title')]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Title,

        [ValidatePattern('^([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+)$')]
        [string]$CName,

        [securestring]$Password,

        [string]$Twitter,

        [Alias('display_annotations')]
        [boolean]$DisplayAnnotations,

        [Alias('display_orbs')]
        [boolean]$DisplayOrbs,

        [Alias('search_indexing')]
        [boolean]$SearchIndexing,

        [Alias('sort_alphabetical')]
        [boolean]$SortAlphabetical,

        [Parameter(ParameterSetName='UseTags')]
        [string[]]$TestTags,

        [Parameter(ParameterSetName='UseTags')]
        [Alias('tags_inclusive')]
        [boolean]$TagsInclusive,

        [Parameter(ParameterSetName='UseTestIDs')]
        [int[]]$TestIDs,

        [string]$Announcement,

        [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
        [Alias('bg_color')]
        [string]$BGColor,

        [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
        [Alias('header_color')]
        [string]$HeaderColor,

        [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
        [Alias('title_color')]
        [string]$TitleColor

    )

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Public Reporting Pages") )
    {
        $statusCakeItem = Get-StatusCakeHelperPublicReportingPage -APICredential $APICredential -Title $Title
        if($statusCakeItem)
        {
            Write-Error "Public Reporting Page with specified domain already exists [$Title] [$($statusCakeItem.id)]"
            Return $null
        }
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $apiParameterParams =@{"InvocationInfo" = $MyInvocation}
    If($TestTags -or $TestIDs)
    {
        if($TestTags)
        {
            $tests_or_tags = $TestTags
            $allParameterValues.Add("use_tags","true")
        }
        elseif($TestIDs)
        {
            $tests_or_tags = $TestIDs
            $allParameterValues.Add("use_tags","false")
        }
        $join = @{"Tests_or_Tags" = "|"} #Tags and tests for public reporting are separated by pipe symbol "|"
        $exclude = @("TestTags","TestIDs")
        $allParameterValues.Add("tests_or_tags",$tests_or_tags)
        $apiParameterParams.Add("join",$join)
        $apiParameterParams.Add("exclude",$exclude)
    }
    $lower = @('Title','CName','Password','Twitter','Announcement')
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter @apiParameterParams -ToLowerName $lower
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    $requestParams = @{
        uri = "https://app.statuscake.com/API/PublicReporting/Update"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Post"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Add StatusCake Public Reporting Page") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams=@{}
        $statusCakeAPIParams=@{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }
        $response = Get-StatusCakeHelperPublicReportingPageDetail -APICredential $APICredential -id $response.data.new_id
        Return $response
    }

}