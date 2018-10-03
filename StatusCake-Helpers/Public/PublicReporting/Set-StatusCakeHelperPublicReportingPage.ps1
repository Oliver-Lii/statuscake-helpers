
<#
.Synopsis
   Updates a StatusCake Public Reporting Page
.EXAMPLE
   Set-StatusCakeHelperPublicReportingPage -id 123456 -display_orbs $false
.INPUTS
    baseAPIURL - Base URL endpoint of the statuscake ContactGroup API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API

    title - The title of the Public Reporting Page
    cname - Cname record for a custom domain
    password - Password protection for the page. Leave empty to disable
    twitter - Twitter handle to display with the @. Leave empty to disable
    display_annotations - 	Set to true to show annotations for status periods
    display_orbs - Set to true to display uptime as colored orbs
    search_indexing - Set to false to disable search engine indexing
    sort_alphabetical - Set to true to order tests by alphabetical name
    use_tags - Set to true to select tests by their tag, rather than ID
    tests_or_tags - Array of TestIDs or Tags, depends on previous value
    tags_inclusive - Set to true to select all tests that include one or more of the provided tags
    announcement - Free text field that will appear as an announcement on the page.
    bg_color - HEX value for the background colour
    header_color - HEX value for the header colour
    title_color - HEX value for the header text colour

.FUNCTIONALITY
   Sets the configuration of StatusCake Public Reporting Page using the supplied parameters.
#>
function Set-StatusCakeHelperPublicReportingPage
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        #[Parameter(ParameterSetName='SetByTitle',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        $baseAPIURL = "https://app.statuscake.com//API/PublicReporting/Update",

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName='SetByID',Mandatory=$true)]
        $id,

        [Parameter(ParameterSetName='SetByTitle',Mandatory=$true)]
        [switch]$SetByTitle,

        [Parameter(ParameterSetName='NewPublicReportingPage',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTitle')]
        [ValidateNotNullOrEmpty()]
        $title,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [ValidatePattern('^([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+)$')]
        [object]$cname,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [string]$twitter,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [ValidateRange(0,1)]
        $display_annotations,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [ValidateRange(0,1)]
        $display_orbs,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [ValidateRange(0,1)]
        $search_indexing,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [ValidateRange(0,1)]
        $sort_alphabetical,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [ValidateRange(0,1)]
        $use_tags,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [object]$tests_or_tags,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByTitle')]
        [Parameter(ParameterSetName='NewPublicReportingPage')]
        [ValidateRange(0,1)]
        $tags_inclusive,

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
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}

    if($SetByTitle -and $title)
    {   #If setting page by title verify if a page or pages with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Public Reporting Pages"))
        {
            $statusCakeItem = Get-StatusCakeHelperPublicReportingPage @statusCakeFunctionAuth -title $title
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
            $statusCakeItem = Get-StatusCakeHelperPublicReportingPage @statusCakeFunctionAuth -id $id
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
            $statusCakeItem = Get-StatusCakeHelperPublicReportingPage @statusCakeFunctionAuth -title $title
            if($statusCakeItem)
            {
                Write-Error "Public Reporting Page with specified name already exists [$title] [$($statusCakeItem.id)]"
                Return $null
            }
        }
    }

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("baseAPIURL","Username","ApiKey")
    foreach ($key in $ParameterList.keys)
    {
        $var = Get-Variable -Name $key -ErrorAction SilentlyContinue;
        if($ParamsToIgnore -contains $var.Name)
        {
            continue
        }
        elseif($var.value -or $var.value -eq 0)
        {
            $psParams.Add($var.name,$var.value)
        }
    }

    $statusCakeAPIParams = $psParams | ConvertTo-StatusCakeHelperAPIParams

    $webRequestParams = @{
        uri = $baseAPIURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Post"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Set StatusCake Public Reporting Page") )
    {
        $jsonResponse = Invoke-WebRequest @webRequestParams
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }
        Return $response
    }

}