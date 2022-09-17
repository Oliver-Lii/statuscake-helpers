
<#
.SYNOPSIS
    Create a StatusCake PageSpeed Test
.DESCRIPTION
    Creates a new StatusCake PageSpeed Test using the supplied parameters.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Name
    Name for PageSpeed test
.PARAMETER WebsiteURL
    URL that should be checked
.PARAMETER Checkrate
    Number of seconds between checks
.PARAMETER AlertBigger
    An alert will be sent if the size of the page is larger than this value (kb). A value of 0 prevents alerts being sent.
.PARAMETER AlertSlower
    Time in ms, will alert to Contact Groups if actual time is slower
.PARAMETER AlertSmaller
    Size in kb, will alert to Contact Groups if actual size is smaller
.PARAMETER ContactID
    IDs of selected Contact Groups to alert
.PARAMETER Region
    2-letter code of the region from which to run the checks. Valid values: AU, CA, DE, FR, IN, JP, NL, SG, UK, US, USW
.PARAMETER Paused
    Whether the test should be run.
.PARAMETER Force
    Force creation of the test even if a test with the same name already exists
.PARAMETER Passthru
    Return the page speed test details instead of the page speed test id
.EXAMPLE
    C:\PS>New-StatusCakeHelperPageSpeedTest -WebsiteURL "https://www.example.com" -Checkrate 60 Region UK -AlertSlower 10000
    Create a page speed test to check site "https://www.example.com" every 60 minutes from a UK test server and alert when page speed load time is slower than 10000ms
.EXAMPLE
    C:\PS>New-StatusCakeHelperPageSpeedTest -WebsiteURL "https://www.example.com" -Checkrate 60 -Region UK -AlertSmaller 500
    Create a page speed test to check site "https://www.example.com" every 60 minutes from a UK test server and alert when page load is less than 500kb
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/PageSpeed/New-StatusCakeHelperPageSpeedTest.md
.LINK
    https://www.statuscake.com/api/v1/#tag/pagespeed/operation/create-pagespeed-test
#>
function New-StatusCakeHelperPageSpeedTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory=$true)]
        [ValidatePattern('^((http|https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [Alias('website_url')]
        [string]$WebsiteURL,

        [Parameter(Mandatory=$true)]
        [ValidateSet("60","300","600","900","1800","3600","86400")]
        [Alias('check_rate')]
        [int]$Checkrate,

        [Alias('alert_bigger')]
        [int]$AlertBigger=0,

        [Alias('alert_slower')]
        [int]$AlertSlower=0,

        [Alias('alert_smaller')]
        [int]$AlertSmaller=0,

        [Alias('contact_groups')]
        [int[]]$ContactID,

        [Parameter(Mandatory=$true)]
        [ValidateSet("AU","CA","DE","FR","IN","JP","NL","SG","UK","US","USW")]
        [string]$Region,

        [boolean]$Paused,

        [switch]$Force,

        [switch]$PassThru
    )

    #If force flag not set then check if an existing test with the same name already exists
    if(!$Force)
    {
       $statusCakeItem = Get-StatusCakeHelperPageSpeedTest -APICredential $APICredential -Name $Name
       if($statusCakeItem)
       {
            Write-Error "Existing pagespeed test(s) found with name [$Name]. Please use a different name for the check or use the -Force argument"
            Return $null
       }
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude @("Force","PassThru") | ConvertTo-StatusCakeHelperAPIValue

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake Pagespeed Check") )
    {
        Return (New-StatusCakeHelperItem -APICredential $APICredential -Type PageSpeed -Parameter $statusCakeAPIParams -PassThru:$PassThru)
    }
}