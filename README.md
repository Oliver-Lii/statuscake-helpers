# StatusCake-Helpers [![Build status](https://ci.appveyor.com/api/projects/status/9m3gk7n9ywuj3do6/branch/master?svg=true)](https://ci.appveyor.com/project/Oliver-Lii/statuscake-helpers/branch/master) [![GitHub license](https://img.shields.io/github/license/Oliver-Lii/StatusCake-Helpers.svg)](LICENSE) [![PowerShell Gallery](https://img.shields.io/powershellgallery/v/StatusCake-Helpers.svg)]()


This module was written to support interaction with the Statuscake API via Powershell. Additional functionality may be added later and I will use this as a generic module to house Powershell functions specific to interacting with the Statuscake API.

**DISCLAIMER:** Neither this module, nor its creator are in any way affiliated with StatusCake.


# Usage
This module can be installed from the PowerShell Gallery using the command below.
```powershell
Install-Module StatusCake-Helpers -Repository PSGallery
```

## Example

 The following illustrates how to create uptime, SSL, and Page Speed Tests along with daily and weekly maintenance windows and two contacts

```powershell
# Setup the StatusCake credentials
# The API credentials must come from the primary account which hosts the tests and not a subaccount which was given access
$scAPIKey = ConvertTo-SecureString "apikey" -AsPlainText -Force
$scCredentials = New-Object System.Management.Automation.PSCredential ("username", $scAPIKey)
Set-StatusCakeHelperAPIAuth -Credentials $scCredentials

$URL = "https://www.example.com"
$team1Emails = @("alerts@example.com","alerts1@example.com")

$team1Contact= New-StatusCakeHelperContactGroup -GroupName "Team 1 monitoring" -email $team1Emails -mobile "+14155552671"
$team2Contact= New-StatusCakeHelperContactGroup -GroupName "Team 2 monitoring" -email "alerts2@example.com"

#Create uptime test to check the site every 5 minutes
$uptimeTest = New-StatusCakeHelperTest -TestName "Example" -TestURL $URL -CheckRate 300 -TestType HTTP -ContactGroup $team1Contact.InsertID

#Create SSL test to check SSL certificate every day
$sslTest = New-StatusCakeHelperSSLTest -Domain $URL -checkrate 2073600 -contact_groups @($team1Contact.InsertID,$team2Contact.InsertID)

#Create Page Speed Test to monitor page speed every 30 minutes from the UK
$pageSpeedCheckName = "Example site UK speed check"
$pageSpeedTest = New-StatusCakeHelperPageSpeedTest -name $pageSpeedCheckName -website_url $URL -checkrate 30 -location_iso UK

#Set the page speed test using the name of the test to alert team 2 when the page takes more than 5000ms to load
$result = Set-StatusCakeHelperPageSpeedTest -name $pageSpeedCheckName -SetByName -contact_groups @($team2Contact.InsertID) -alert_slower 5000

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
    timezone = "Europe/London"
    raw_tests = @($uptimeTest.InsertID)
}

#Create the daily reoccurring maintenance window
$result = New-StatusCakeHelperMaintenanceWindow -name "Example Daily MW" -start_date $startMWDailyTime -end_date $endMWDailyTime @mwParams -recur_every 1

#Create the weekly reoccurring maintenance window
$result = New-StatusCakeHelperMaintenanceWindow -name "Example Weekly MW" -start_date $startMWWeeklyTime -end_date $endMWWeeklyTime @mwParams -recur_every 7

```

## Functions

Below is a list of the available functions and features of the StatusCake API that are supported. Further details of each function can be found in the links below:

[Alerts](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/StatusCake-Helpers/Public/Alerts "StatusCake Alerts")
*  Get-StatusCakeHelperSentAlerts

[Authentication](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/StatusCake-Helpers/Public/Authentication "StatusCake API Authentication")
*  Remove-StatusCakeHelperAPIAuth
*  Set-StatusCakeHelperAPIAuth
*  Test-StatusCakeHelperAPIAuthSet

[ContactGroups](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/StatusCake-Helpers/Public/ContactGroups "StatusCake Contact Groups")
*  Get-StatusCakeHelperAllContactGroups
*  Get-StatusCakeHelperContactGroup
*  New-StatusCakeHelperContactGroup
*  Remove-StatusCakeHelperContactGroup
*  Set-StatusCakeHelperContactGroup

[MaintenanceWindows](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/StatusCake-Helpers/Public/MaintenanceWindows "StatusCake Maintenance Windows")
*  Get-StatusCakeHelperAllMaintenanceWindows
*  Get-StatusCakeHelperMaintenanceWindow
*  New-StatusCakeHelperMaintenanceWindow
*  Remove-StatusCakeHelperMaintenanceWindows
*  Update-StatusCakeHelperMaintenanceWindows

[PageSpeed](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/StatusCake-Helpers/Public/PageSpeed "StatusCake PageSpeed Tests")
*  Get-StatusCakeHelperAllPageSpeedTests
*  Get-StatusCakeHelperPageSpeedTest
*  Get-StatusCakeHelperPageSpeedTestHistory
*  New-StatusCakeHelperPageSpeedTest
*  Remove-StatusCakeHelperPageSpeedTest
*  Set-StatusCakeHelperPageSpeedTest

[PerformanceData](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/StatusCake-Helpers/Public/PerformanceData "StatusCake Performance Data")
*  Get-StatusCakeHelperPerformanceData

[PeriodData](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/StatusCake-Helpers/Public/PeriodData "StatusCake Period of Data")
*  Get-StatusCakeHelperPeriodOfData

[Probes](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/StatusCake-Helpers/Public/Probes "StatusCake Probe Locations")
*  Get-StatusCakeHelperProbes
*  Get-StatusCakeHelperRegionProbes

[SSL](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/StatusCake-Helpers/Public/SSL "StatusCake SSL Tests") 
*  Get-StatusCakeHelperAllSSLTests
*  Get-StatusCakeHelperSSLTest
*  New-StatusCakeHelperSSLTest
*  Remove-StatusCakeHelperSSLTest
*  Set-StatusCakeHelperSSLTest

[Tests](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/StatusCake-Helpers/Public/Tests "StatusCake Tests")
*  Add-StatusCakeHelperTestNodeLocations
*  Add-StatusCakeHelperTestStatusCodes
*  Add-StatusCakeHelperTestTags
*  Get-StatusCakeHelperAllTests
*  Get-StatusCakeHelperDetailedTestData
*  Get-StatusCakeHelperPausedTests
*  Get-StatusCakeHelperTest
*  New-StatusCakeHelperTest
*  Remove-StatusCakeHelperTest
*  Remove-StatusCakeHelperTestNodeLocations
*  Remove-StatusCakeHelperTestStatusCodes
*  Remove-StatusCakeHelperTestTags
*  Set-StatusCakeHelperTest

## Tests

This module comes with [Pester](https://github.com/pester/Pester/) tests for unit testing. The tests cover the StatusCake features available under the [Community plan](https://www.statuscake.com/pricing/).


# Authors
- Oliver Li