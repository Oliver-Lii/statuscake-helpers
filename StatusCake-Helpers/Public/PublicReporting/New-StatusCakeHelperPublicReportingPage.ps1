
<#
.Synopsis
   Create a StatusCake Public Reporting Page
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Title
    The title of the Public Reporting Page
.PARAMETER CName
    Cname record for a custom domain
.PARAMETER Password
    Password protection for the page. Leave empty to disable
.PARAMETER Twitter
    Twitter handle to display with the @. Leave empty to disable
.PARAMETER Display_Annotations
    Set to true to show annotations for status periods
.PARAMETER Display_Orbs
    Set to true to display uptime as colored orbs
.PARAMETER Search_Indexing
    Set to false to disable search engine indexing
.PARAMETER Sort_Alphabetical
    Set to true to order tests by alphabetical name
.PARAMETER Tags
    Array of tags which a test must contain to be included on the Public Reporting Page
.PARAMETER Tags_Inclusive
    Set to true to select all tests that include one or more of the provided tags
.PARAMETER TestIDs
    Array of TestIDs to be associated with Public Reporting page
.PARAMETER Announcement
    Free text field that will appear as an announcement on the page
.PARAMETER Bg_Color
    HEX value for the background colour
.PARAMETER Header_Color
    HEX value for the header colour
.PARAMETER Title_Color
    HEX value for the header text colour
.EXAMPLE
   New-StatusCakeHelperPublicReportingPage -Title "Example.com Public Reporting Page"
.FUNCTIONALITY
   Creates a new StatusCake Public Reporting Page using the supplied parameters.
#>
function New-StatusCakeHelperPublicReportingPage
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$title,

        [ValidatePattern('^([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+)$')]
        [string]$cname,

        [securestring]$password,

        [string]$twitter,

        [boolean]$display_annotations,

        [boolean]$display_orbs,

        [boolean]$search_indexing,

        [boolean]$sort_alphabetical,

        [Parameter(ParameterSetName='UseTags')]
        [string[]]$tags,

        [Parameter(ParameterSetName='UseTags')]
        [boolean]$tags_inclusive,

        [Parameter(ParameterSetName='UseTestIDs')]
        [int[]]$testIDs,

        [string]$announcement,

        [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
        [string]$bg_color,

        [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
        [string]$header_color,

        [ValidatePattern('^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$')]
        [string]$title_color

    )

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Public Reporting Pages") )
    {
        $statusCakeItem = Get-StatusCakeHelperPublicReportingPage -APICredential $APICredential -title $title
        if($statusCakeItem)
        {
            Write-Error "Public Reporting Page with specified domain already exists [$title] [$($statusCakeItem.id)]"
            Return $null
        }
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $apiParameterParams =@{"InvocationInfo" = $MyInvocation}
    If($tags -or $testIDs)
    {
        if($tags)
        {
            $tests_or_tags = $tags
            $allParameterValues.Add("use_tags","true")
        }
        elseif($testIDs)
        {
            $tests_or_tags = $testIDs
            $allParameterValues.Add("use_tags","false")
        }
        $join = @{"Tests_or_Tags" = "|"} #Tags and tests for public reporting are separated by pipe symbol "|"
        $exclude = @("tags","testIDs")
        $allParameterValues.Add("tests_or_tags",$tests_or_tags)
        $apiParameterParams.Add("join",$join)
        $apiParameterParams.Add("exclude",$exclude)
    }
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter @apiParameterParams
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    if($statusCakeAPIParams.Password)
    {
        $Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList "UserName", $statusCakeAPIParams.Password
        $statusCakeAPIParams.Password = $Credentials.GetNetworkCredential().Password
    }

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
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }
        $response = Get-StatusCakeHelperPublicReportingPageDetail -APICredential $APICredential -id $response.data.new_id
        Return $response
    }

}