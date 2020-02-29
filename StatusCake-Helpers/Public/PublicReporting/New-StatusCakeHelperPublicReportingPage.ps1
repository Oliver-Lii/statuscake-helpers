
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
.PARAMETER Use_Tags
    Set to true to select tests by their tag, rather than ID
.PARAMETER Tests_Or_Tags
    Array of TestIDs or Tags, depends on previous value
.PARAMETER Tags_Inclusive
    Set to true to select all tests that include one or more of the provided tags
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

        [boolean]$use_tags,

        [string[]]$tests_or_tags,

        [boolean]$tags_inclusive,

        [string]$announcement,

        [ValidatePattern('^\#([A-F0-9])+$')]
        [string]$bg_color,

        [ValidatePattern('^\#([A-F0-9])+$')]
        [string]$header_color,

        [ValidatePattern('^\#([A-F0-9])+$')]
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

    $join = @{Tests_or_Tags = "|"}
    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Join $join
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