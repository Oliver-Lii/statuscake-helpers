
<#
.Synopsis
   Updates a StatusCake Public Reporting Page
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
   Set-StatusCakeHelperPublicReportingPage -id 123456 -display_orbs $false
.FUNCTIONALITY
   Sets the configuration of StatusCake Public Reporting Page using the supplied parameters.
#>
function Set-StatusCakeHelperPublicReportingPage
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='SetByID',Mandatory=$true)]
        [string]$id,

        [Parameter(ParameterSetName='SetByTitle',Mandatory=$true)]
        [switch]$SetByTitle,

        [Parameter(ParameterSetName='NewPublicReportingPage',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTitle')]
        [ValidateNotNullOrEmpty()]
        [string]$title,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [ValidatePattern('^([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+)$')]
        [string]$cname,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [securestring]$password,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [string]$twitter,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [boolean]$display_annotations,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [boolean]$display_orbs,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [boolean]$search_indexing,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [boolean]$sort_alphabetical,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [boolean]$use_tags,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [string[]]$tests_or_tags,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [boolean]$tags_inclusive,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [string]$announcement,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [ValidatePattern('^\#([A-F0-9])+$')]
        [string]$bg_color,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [ValidatePattern('^\#([A-F0-9])+$')]
        [string]$header_color,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [ValidatePattern('^\#([A-F0-9])+$')]
        [string]$title_color

    )

    if($SetByTitle -and $title)
    {   #If setting page by title verify if a page or pages with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Public Reporting Pages"))
        {
            $statusCakeItem = Get-StatusCakeHelperPublicReportingPage -APICredential $APICredential -title $title
            if(!$statusCakeItem)
            {
                Write-Error "No Public Reporting Page with Specified title Exists [$title]"
                Return $null
            }
            elseif($statusCakeItem.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Public Reporting Pages with the same name [$title] [$($statusCakeItem.id)]"
                Return $null
            }
            $id = $statusCakeItem.id
        }
    }
    elseif($id)
    {   #If setting by id verify that id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Public Reporting Pages"))
        {
            $statusCakeItem = Get-StatusCakeHelperPublicReportingPage -APICredential $APICredential -id $id
            if(!$statusCakeItem)
            {
                Write-Error "No Public Reporting Page with Specified ID Exists [$id]"
                Return $null
            }
            $id = $statusCakeItem.id
        }
    }
    else
    {   #Setup a page with the supplied details
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Public Reporting Pages") )
        {
            $statusCakeItem = Get-StatusCakeHelperPublicReportingPage -APICredential $APICredential -title $title
            if($statusCakeItem)
            {
                Write-Error "Public Reporting Page with specified name already exists [$title] [$($statusCakeItem.id)]"
                Return $null
            }
        }
    }

    $join = @{Tests_or_Tags = "|"}
    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -join $join
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    $requestParams = @{
        uri = "https://app.statuscake.com//API/PublicReporting/Update"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Post"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Set StatusCake Public Reporting Page") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams=@{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }
        $responseId = $response.data.new_id
        if($id)
        {   #Updating a test does not return an id
            $responseId = $id
        }

        $response = Get-StatusCakeHelperPublicReportingPageDetail -APICredential $APICredential -id $responseId
        Return $response
    }

}