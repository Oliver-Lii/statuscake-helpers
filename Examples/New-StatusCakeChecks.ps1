<#
.SYNOPSIS
    Creates a StatusCake PageSpeed, Test, SSL Test and Maintenance Window for a specified URL using supplied values.
.DESCRIPTION
    Creates a StatusCake PageSpeed, Test, SSL Test and Maintenance Window for a specified URL using supplied values.
    The defaults will create checks as follows using the domain as the name of the relevant check:
    New Contact group using supplied email address
    URL Test check every 5 minutes
    SSL test every day
    Page speed test every 30 minutes from the UK alerting when the page load time is slower than 5000ms
    Maintenance window every Saturday 20:00 UTC for 4 hours
    A PSCustomObject is returned containing the details of each item created.
.PARAMETER Credential
    Credentials for the StatusCake API. The API credentials must come from the primary account which hosts the tests and not a subaccount which was given access
.PARAMETER EmailAddress
    Email Address which alerts should be sent to
.PARAMETER MWStartTime
    Time that the maintenance window should begin
.PARAMETER MWDurationHours
    Duration in hours of the maintenance window
.PARAMETER MWStartDay
    Day of the week which the maintenance window should start
.PARAMETER TestCheckRate
    Frequency with which the URL should be checked
.PARAMETER SSLCheckrate
    Frequency with which the SSL certificate of the URL should be checked
.PARAMETER PageSpeedCheckrate
    Frequency in minutes with which the page speed test should be run
.PARAMETER PageSpeedRegion
    StatusCake region the page speed test is run from. Valid values:  AU, CA, DE, FR, IN, JP, NL, SG, UK, US, USW
.PARAMETER PageSpeedAlertSlower
    Time in ms, will alert to Contact Groups if actual time is slower
.PARAMETER URL
    HTTPS URL to create the checks against
.EXAMPLE
    C:\PS>New-StatusCakeChecks.ps1 -Credential $StatusCakeAPIKey -URL https://www.example.org
    Create the test, SSL, page speed checks for https://www.example.org

.NOTES
Author: Oliver Li
#>
[CmdletBinding()]
param (
    [ValidateNotNullOrEmpty()]
    [securestring] $StatusCakeAPIKey = (Read-Host -AsSecureString -Prompt "Please enter the API key"),

    [Parameter(Mandatory = $true)]
    [ValidatePattern('^((https):\/\/)([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)')]
    [string]$URL,

    [ValidatePattern('^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')]
    [string]$EmailAddress,

    [ValidateRange(0,24000)]
    [int]$TestCheckRate=300,

    [ValidateSet("300","600","1800","3600","86400","2073600")]
    [int]$SSLCheckrate=86400,

    [ValidateSet("1","5","10","15","30","60","1440")]
    [int]$PageSpeedCheckrate=30,

    [ValidateSet("AU","CA","DE","FR","IN","JP","NL","SG","UK","US","USW")]
    [string]$PageSpeedRegion="UK",

    [int]$PageSpeedAlertSlower = 5000,

    [datetime]$MWStartTime = (Get-Date "20:00"),

    [int]$MWDurationHours = 4,

    [string]$MWStartDay = "Saturday"
)

# Setup the StatusCake credentials
# The API key must come from the primary account which hosts the tests and not a subaccount which was given access
$null = Set-StatusCakeHelperAPIAuth -APIKey $StatusCakeAPIKey -Session

$URL -match '(?<DomainName>([a-zA-Z0-9\-]{2,}\.[a-zA-Z\-]{2,})(\.[a-zA-Z\-]{2,})?(\.[a-zA-Z\-]{2,})?)' | Out-Null
$domainName = $matches.DomainName

$contactGroup= New-StatusCakeHelperContactGroup -Name "$domainName monitoring" -Email $EmailAddress

#Create uptime test to check the site every 5 minutes
$uptimeTest = New-StatusCakeHelperUptimeTest -Name $domainName -WebsiteURL $URL -CheckRate $TestCheckRate -Type HTTP -ContactID $contactGroup.id

#Create SSL test to check SSL certificate every day
$sslTest = New-StatusCakeHelperSSLTest -Domain $URL -Checkrate $SSLCheckrate -ContactID @($contactGroup.ContactID)

#Create Page Speed Test to monitor page speed every 30 minutes from the UK and alert the contact group when the page takes more than 5000ms to load
$pageSpeedCheckName = "$domainName UK speed check"
$pageSpeedTest = New-StatusCakeHelperPageSpeedTest -Name $pageSpeedCheckName -WebsiteURL $URL -Checkrate $PageSpeedCheckrate -Region $PageSpeedRegion -AlertSlower $PageSpeedAlertSlower

#Setup a date object to start next on the specified day at the desired start time for required duration
$startMWWeeklyTime = $MWStartTime
while ($startMWWeeklyTime.DayOfWeek -ne $MWStartDay)
{
    $startMWWeeklyTime = $startMWWeeklyTime.AddDays(1)
}
$endMWWeeklyTime = $startMWWeeklyTime.AddHours($MWDurationHours)

$mwParams = @{
    Timezone = "UTC"
    UptimeID = @($uptimeTest.id)
}

#Create the weekly reoccurring maintenance window
$maintenanceWindow = New-StatusCakeHelperMaintenanceWindow -Name "$domainName Weekly MW" -StartDate $startMWWeeklyTime -EndDate $endMWWeeklyTime @mwParams -RepeatInterval 1w

$result = [PSCustomObject]@{
    ContactGroup = $contactGroup
    Test = $uptimeTest
    MaintenanceWindow = $maintenanceWindow
    PageSpeed = $pageSpeedTest
    ReportPage = $publicReportingPage
    SSL = $sslTest
}
$result