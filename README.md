# StatusCake-Helpers [![Build status](https://dev.azure.com/oliverli0875/Helpers/_apis/build/status/Oliver-Lii.statuscake-helpers?branchName=master)](https://dev.azure.com/oliverli0875/Helpers/_build?definitionId=1&_a=summary&repositoryFilter=1&branchFilter=2) [![Test Results](https://img.shields.io/azure-devops/tests/oliverli0875/Helpers/1.svg)](https://dev.azure.com/oliverli0875/Helpers/_build?definitionId=1&_a=summary&view=ms.vss-pipelineanalytics-web.new-build-definition-pipeline-analytics-view-cardmetrics) [![GitHub license](https://img.shields.io/github/license/Oliver-Lii/StatusCake-Helpers.svg)](LICENSE) [![PowerShell Gallery](https://img.shields.io/powershellgallery/v/StatusCake-Helpers.svg)]()


This module was written to support interaction with the Statuscake API via Powershell. Additional functionality may be added later and I will use this as a generic module to house Powershell functions specific to interacting with the Statuscake API.

**DISCLAIMER:** Neither this module, nor its creator are in any way affiliated with StatusCake.


# Usage
This module can be installed from the PowerShell Gallery using the command below.
```powershell
Install-Module StatusCake-Helpers -Repository PSGallery
```

## Example

 The following illustrates how to create uptime, SSL, Page Speed Tests and a Public Reporting page along with daily and weekly maintenance windows and two contacts

```powershell
# Setup the StatusCake credentials
# The API credentials must come from the primary account which hosts the tests and not a subaccount which was given access
$scCredentials = Get-Credential
Set-StatusCakeHelperAPIAuth -Credential $scCredentials

$URL = "https://www.example.com"
$team1Emails = @("alerts@example.com","alerts1@example.com")

$team1Contact= New-StatusCakeHelperContactGroup -GroupName "Team 1 monitoring" -Email $team1Emails -Mobile "+14155552671"
$team2Contact= New-StatusCakeHelperContactGroup -GroupName "Team 2 monitoring" -Email "alerts2@example.com"

#Create uptime test to check the site every 5 minutes
$uptimeTest = New-StatusCakeHelperTest -TestName "Example" -TestURL $URL -CheckRate 300 -TestType HTTP -ContactGroup $team1Contact.ContactID

#Create SSL test to check SSL certificate every day
$sslTest = New-StatusCakeHelperSSLTest -Domain $URL -Checkrate 2073600 -ContactIDs @($team1Contact.ContactID,$team2Contact.ContactID)

#Create Page Speed Test to monitor page speed every 30 minutes from the UK
$pageSpeedCheckName = "Example site UK speed check"
$pageSpeedTest = New-StatusCakeHelperPageSpeedTest -Name $pageSpeedCheckName -WebsiteURL $URL -Checkrate 30 -LocationISO UK

#Set the page speed test using the name of the test to alert team 2 when the page takes more than 5000ms to load
$result = Set-StatusCakeHelperPageSpeedTest -Name $pageSpeedCheckName -SetByName -ContactIDs @($team2Contact.ContactID) -AlertSlower 5000

#Create a public reporting page for the test
$publicReportingPage = New-StatusCakeHelperPublicReportingPage -Title "Example.com Public Reporting Page" -TestIDs @($uptimeTest.TestID)

#Create a date object to start today at 20:00 and finish in an hour
$startMWDailyTime = Get-Date "20:00"
$endMWDailyTime = $startMWDailyTime.AddHours(1)

#Setup a date object to start next Saturday at 20:00 and finish in four hours time
$startMWWeeklyTime = $startMWDailyTime
while ($startMWWeeklyTime.DayOfWeek -ne "Saturday")
{
    $startMWWeeklyTime = $startMWWeeklyTime.AddDays(1)
}
$endMWWeeklyTime = $startMWWeeklyTime.AddHours(4)

$mwParams = @{
    Timezone = "Europe/London"
    TestIDs = @($uptimeTest.TestID)
}

#Create the daily reoccurring maintenance window
$result = New-StatusCakeHelperMaintenanceWindow -Name "Example Daily MW" -StartDate $startMWDailyTime -EndDate $endMWDailyTime @mwParams -RecurEvery 1

#Create the weekly reoccurring maintenance window
$result = New-StatusCakeHelperMaintenanceWindow -Name "Example Weekly MW" -StartDate $startMWWeeklyTime -EndDate $endMWWeeklyTime @mwParams -RecurEvery 7

```

## Functions

Below is a list of the available functions and features of the StatusCake API that are supported. Further details of each function can be found in the links below:

[Alerts](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/Alerts "StatusCake Alerts")
*  Get-StatusCakeHelperSentAlert

[Authentication](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/Authentication "StatusCake API Authentication")
*  Remove-StatusCakeHelperAPIAuth
*  Set-StatusCakeHelperAPIAuth
*  Test-StatusCakeHelperAPIAuthSet

[ContactGroups](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/ContactGroups "StatusCake Contact Groups")
*  Copy-StatusCakeHelperContactGroup
*  Get-StatusCakeHelperContactGroup
*  New-StatusCakeHelperContactGroup
*  Remove-StatusCakeHelperContactGroup
*  Set-StatusCakeHelperContactGroup

[MaintenanceWindows](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/MaintenanceWindows "StatusCake Maintenance Windows")
*  Clear-StatusCakeHelperMaintenanceWindow
*  Get-StatusCakeHelperMaintenanceWindow
*  New-StatusCakeHelperMaintenanceWindow
*  Remove-StatusCakeHelperMaintenanceWindows
*  Update-StatusCakeHelperMaintenanceWindows

[PageSpeed](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/PageSpeed "StatusCake PageSpeed Tests")
*  Copy-StatusCakeHelperPageSpeedTest
*  Get-StatusCakeHelperPageSpeedTest
*  Get-StatusCakeHelperPageSpeedTestDetail
*  Get-StatusCakeHelperPageSpeedTestHistory
*  New-StatusCakeHelperPageSpeedTest
*  Remove-StatusCakeHelperPageSpeedTest
*  Set-StatusCakeHelperPageSpeedTest

[PerformanceData](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/PerformanceData "StatusCake Performance Data")
*  Get-StatusCakeHelperPerformanceData

[PeriodData](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/PeriodData "StatusCake Period of Data")
*  Get-StatusCakeHelperPeriodOfData

[Probes](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/Probes "StatusCake Probe Locations")
*  Get-StatusCakeHelperProbe
*  Get-StatusCakeHelperRegionProbe

[PublicReporting](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/PublicReporting "StatusCake Public Reporting Pages")
*  Copy-StatusCakeHelperPublicReportingPage
*  Get-StatusCakeHelperPublicReportingPage
*  Get-StatusCakeHelperPublicReportingPageDetail
*  New-StatusCakeHelperPublicReportingPage
*  Remove-StatusCakeHelperPublicReportingPage
*  Set-StatusCakeHelperPublicReportingPage

[SSL](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/SSL "StatusCake SSL Tests")
*  Copy-StatusCakeHelperSSLTest
*  Get-StatusCakeHelperSSLTest
*  New-StatusCakeHelperSSLTest
*  Remove-StatusCakeHelperSSLTest
*  Set-StatusCakeHelperSSLTest

[Tests](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/Tests "StatusCake Tests")
*  Add-StatusCakeHelperTestNodeLocation
*  Add-StatusCakeHelperTestStatusCode
*  Add-StatusCakeHelperTestTag
*  Copy-StatusCakeHelperTest
*  Get-StatusCakeHelperTest
*  Get-StatusCakeHelperTestDetail
*  Get-StatusCakeHelperPausedTest
*  New-StatusCakeHelperTest
*  Remove-StatusCakeHelperTest
*  Remove-StatusCakeHelperTestNodeLocation
*  Remove-StatusCakeHelperTestStatusCode
*  Remove-StatusCakeHelperTestTag
*  Resume-StatusCakeHelperTest
*  Set-StatusCakeHelperTest
*  Suspend-StatusCakeHelperTest

## Tests

This module comes with [Pester](https://github.com/pester/Pester/) tests for unit testing. The tests cover the StatusCake features available under the [Business plan](https://www.statuscake.com/pricing/).


# Authors
- Oliver Li