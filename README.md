# StatusCake-Helpers
[![Build status](https://dev.azure.com/oliverli0875/Helpers/_apis/build/status/Oliver-Lii.statuscake-helpers?branchName=master)](https://dev.azure.com/oliverli0875/Helpers/_build?definitionId=1&_a=summary&repositoryFilter=1&branchFilter=2) [![Test Results](https://img.shields.io/azure-devops/tests/oliverli0875/Helpers/1.svg)](https://dev.azure.com/oliverli0875/Helpers/_build?definitionId=1&_a=summary&view=ms.vss-pipelineanalytics-web.new-build-definition-pipeline-analytics-view-cardmetrics) [![GitHub license](https://img.shields.io/github/license/Oliver-Lii/StatusCake-Helpers.svg)](LICENSE) [![PowerShell Gallery](https://img.shields.io/powershellgallery/v/StatusCake-Helpers.svg)]()


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
# Setup the StatusCake API key
# The API credentials must come from the primary account which hosts the tests and not a subaccount which was given access
$scAPIKey = Read-Host -AsSecureString -Prompt "Please enter the API key"
Set-StatusCakeHelperAPIAuth -APIKey $scAPIKey

$URL = "https://www.example.com"
$team1Emails = @("alerts@example.com","alerts1@example.com")

$team1Contact= New-StatusCakeHelperContactGroup -Name "Team 1 monitoring" -Email $team1Emails -Mobile "+14155552671" -Passthru
$team2Contact= New-StatusCakeHelperContactGroup -Name "Team 2 monitoring" -Email "alerts2@example.com" -Passthru

#Create a uptime test to check the site every 5 minutes
$uptimeTest = New-StatusCakeHelperUptimeTest -Name "Example" -TestURL $URL -CheckRate 300 -TestType HTTP -ContactGroup $team1Contact.id

#Create SSL test to check SSL certificate every day
$sslTest = New-StatusCakeHelperSSLTest -Domain $URL -Checkrate 2073600 -ContactID @($team1Contact.id,$team2Contact.id)

#Create Page Speed Test to monitor page speed every 30 minutes from the UK
$pageSpeedCheckName = "Example site UK speed check"
$pageSpeedTest = New-StatusCakeHelperPageSpeedTest -Name $pageSpeedCheckName -WebsiteURL $URL -Checkrate 1800 -Region UK

#Update the page speed test using the name of the test to alert team 2 when the page takes more than 5000ms to load
$result = Update-StatusCakeHelperPageSpeedTest -Name $pageSpeedCheckName -ContactID @($team2Contact.id) -AlertSlower 5000

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
    UptimeID = @($uptimeTest.id)
}

#Create the daily reoccurring maintenance window
$result = New-StatusCakeHelperMaintenanceWindow -Name "Example Daily MW" -StartDate $startMWDailyTime -EndDate $endMWDailyTime @mwParams -RepeatInterval 1d

#Create the weekly reoccurring maintenance window
$result = New-StatusCakeHelperMaintenanceWindow -Name "Example Weekly MW" -StartDate $startMWWeeklyTime -EndDate $endMWWeeklyTime @mwParams -RepeatInterval 1w

```

## Functions

Below is a list of the available functions and features of the StatusCake API that are supported. Further details of each function can be found in the links below:

[Authentication](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/Authentication "StatusCake API Authentication")
*  Remove-StatusCakeHelperAPIAuth
*  Update-StatusCakeHelperAPIAuth
*  Test-StatusCakeHelperAPIAuthSet

[ContactGroups](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/ContactGroups "StatusCake Contact Groups")
*  Copy-StatusCakeHelperContactGroup
*  Get-StatusCakeHelperContactGroup
*  New-StatusCakeHelperContactGroup
*  Remove-StatusCakeHelperContactGroup
*  Update-StatusCakeHelperContactGroup

[Locations](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/Locations "StatusCake Locations")
*  Get-StatusCakeHelperLocation

[MaintenanceWindows](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/MaintenanceWindows "StatusCake Maintenance Windows")
*  Get-StatusCakeHelperMaintenanceWindow
*  New-StatusCakeHelperMaintenanceWindow
*  Remove-StatusCakeHelperMaintenanceWindow
*  Update-StatusCakeHelperMaintenanceWindow

[PageSpeed](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/PageSpeed "StatusCake PageSpeed Tests")
*  Copy-StatusCakeHelperPageSpeedTest
*  Get-StatusCakeHelperPageSpeedTest
*  Get-StatusCakeHelperPageSpeedTestHistory
*  New-StatusCakeHelperPageSpeedTest
*  Remove-StatusCakeHelperPageSpeedTest
*  Update-StatusCakeHelperPageSpeedTest

[SSL](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/SSL "StatusCake SSL Tests")
*  Copy-StatusCakeHelperSSLTest
*  Get-StatusCakeHelperSSLTest
*  New-StatusCakeHelperSSLTest
*  Remove-StatusCakeHelperSSLTest
*  Update-StatusCakeHelperSSLTest

[Uptime](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/Documentation/Uptime "StatusCake Tests")
*  Copy-StatusCakeHelperUptimeTest
*  Get-StatusCakeHelperUptimeAlert
*  Get-StatusCakeHelperUptimeHistory
*  Get-StatusCakeHelperUptimePeriod
*  Get-StatusCakeHelperUptimeTest
*  Get-StatusCakeHelperUptimePausedTest
*  New-StatusCakeHelperUptimeTest
*  Remove-StatusCakeHelperUptimeTest
*  Resume-StatusCakeHelperUptimeTest
*  Update-StatusCakeHelperUptimeTest
*  Suspend-StatusCakeHelperUptimeTest

## Tests

This module comes with [Pester](https://github.com/pester/Pester/) tests for unit testing. The tests cover the StatusCake features available under the [Business plan](https://www.statuscake.com/pricing/).


# Authors
- Oliver Li