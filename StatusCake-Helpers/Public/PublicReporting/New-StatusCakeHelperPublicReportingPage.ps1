
<#
.Synopsis
   Create a StatusCake Public Reporting Page
.EXAMPLE
   New-StatusCakeHelperPublicReportingPage -Title "Example.com Public Reporting Page"
.INPUTS
    baseAPIURL - Base URL endpoint of the statuscake Public Report API
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
   Creates a new StatusCake Public Reporting Page using the supplied parameters.
#>
function New-StatusCakeHelperPublicReportingPage
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        $baseAPIURL = "https://app.statuscake.com/API/PublicReporting/Update",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        $title,

        [ValidatePattern('^([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+)$')]
        $cname,

        [securestring]$password,

        [string]$twitter,

        [ValidateRange(0,1)]
        $display_annotations,

        [ValidateRange(0,1)]
        $display_orbs,

        [ValidateRange(0,1)]
        $search_indexing,

        [ValidateRange(0,1)]
        $sort_alphabetical,

        [ValidateRange(0,1)]
        $use_tags,

        [object]$tests_or_tags,

        [ValidateRange(0,1)]
        $tags_inclusive,

        [string]$announcement,

        [ValidatePattern('^\#([A-F0-9])+$')]
        [string]$bg_color,

        [ValidatePattern('^\#([A-F0-9])+$')]
        [string]$header_color,

        [ValidatePattern('^\#([A-F0-9])+$')]
        [string]$title_color

    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Public Reporting Pages") )
    {
        $statusCakeItem = Get-StatusCakeHelperPublicReportingPage @statusCakeFunctionAuth -title $title
        if($statusCakeItem)
        {
            Write-Error "Public Reporting Page with specified domain already exists [$title] [$($statusCakeItem.id)]"
            Return $null
        }
    }
    Write-Warning -Message "The output from this function will be changed in the next release"
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

    if($statusCakeAPIParams.Password)
    {
        $Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList "UserName", $statusCakeAPIParams.Password
        $statusCakeAPIParams.Password = $Credentials.GetNetworkCredential().Password
    }

    $webRequestParams = @{
        uri = $baseAPIURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Post"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Add StatusCake Public Reporting Page") )
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