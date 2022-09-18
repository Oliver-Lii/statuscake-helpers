
<#
.SYNOPSIS
    Create a StatusCake SSL Test
.DESCRIPTION
    Creates a new StatusCake SSL Test using the supplied parameters. Default settings for a SSL test will check a URL every day with alerts sent at 7, 14 and 30 days.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER WebsiteURL
    URL to check
.PARAMETER Checkrate
    Checkrate in seconds. Default is 86400 seconds (1 day). Options are 300 (5 minutes), 600 (10 minutes), 1800 (30 minutes), 3600 (1 hour), 86400 (1 day), 2073600 (24 days)
.PARAMETER AlertAt
    Number of days before expiration when reminders will be sent. Defaults to reminders at 30, 14 and 7 days. Must be 3 numeric values.
.PARAMETER AlertBroken
    Set to true to enable broken alerts. False to disable
.PARAMETER AlertExpiry
    Set to true to enable expiration alerts. False to disable
.PARAMETER AlertMixed
    Set to true to enable mixed content alerts. False to disable
.PARAMETER AlertReminder
    Set to true to enable reminder alerts. False to disable
.PARAMETER ContactID
    Array containing contact IDs to alert.
.PARAMETER FollowRedirects
    Whether to follow redirects when testing.
.PARAMETER Hostname
    Hostname of the server under test
.PARAMETER Paused
    Whether the test should be run.
.PARAMETER UserAgent
    Custom user agent string set when testing
.PARAMETER Force
    Create an SSL test even if one with the same website URL already exists
.PARAMETER Passthru
    Return the SSL test details instead of the SSL test id
.EXAMPLE
    C:\PS>New-StatusCakeHelperSSLTest -WebsiteURL "https://www.example.com"
    Create a new SSL Test to check https://www.example.com every day
.EXAMPLE
    C:\PS>New-StatusCakeHelperSSLTest -WebsiteURL "https://www.example.com" -AlertAt ("14","30","60")
    Create a new SSL Test to check https://www.example.com every day with alerts sent at 14, 30 and 60 days.
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/SSL/New-StatusCakeHelperSSLTest.md
.LINK
    https://www.statuscake.com/api/v1/#tag/ssl/operation/create-ssl-test
#>
function New-StatusCakeHelperSSLTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$true)]
        [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
        [Alias('website_url','Domain')]
        [string]$WebsiteURL,

        [ValidateSet("300","600","1800","3600","86400","2073600")]
        [Alias('check_rate')]
        [int]$Checkrate=86400,

        [Alias('alert_at')]
        [ValidateCount(3,3)]
        [int[]]$AlertAt=@("7","14","30"),

        [Alias('alert_broken')]
        [boolean]$AlertBroken,

        [Alias('alert_expiry')]
        [boolean]$AlertExpiry=$true,

        [Alias('alert_mixed')]
        [boolean]$AlertMixed,

        [Alias('alert_reminder')]
        [boolean]$AlertReminder=$true,

        [Alias('contact_groups')]
        [int[]]$ContactID,

        [Alias('follow_redirects')]
        [boolean]$FollowRedirects,

        [string]$Hostname,

        [boolean]$Paused,

        [Alias('user_agent')]
        [string]$UserAgent,

        [switch]$Force,

        [switch]$PassThru

    )

    #If force flag not set then check if an existing test with the same website url already exists
    if(!$Force)
    {
       $statusCakeItem = Get-StatusCakeHelperSSLTest -APICredential $APICredential -WebsiteURL $WebsiteURL
       if($statusCakeItem)
       {
            Write-Error "Existing SSL test(s) found with name [$Name]. Please use a different name for the check or use the -Force argument"
            Return $null
       }
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude @("Force","PassThru") | ConvertTo-StatusCakeHelperAPIValue

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake SSL Check") )
    {
        Return (New-StatusCakeHelperItem -APICredential $APICredential -Type SSL -Parameter $statusCakeAPIParams -PassThru:$PassThru)
    }

}