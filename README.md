# StatusCake-Helpers [![Build status](https://ci.appveyor.com/api/projects/status/9m3gk7n9ywuj3do6/branch/master?svg=true)](https://ci.appveyor.com/project/Oliver-Lii/statuscake-helpers/branch/master) [![GitHub license](https://img.shields.io/github/license/Oliver-Lii/StatusCake-Helpers.svg)](LICENSE) [![PowerShell Gallery](https://img.shields.io/powershellgallery/v/StatusCake-Helpers.svg)]()


This module was written to support interaction with the Statuscake API via Powershell. Additional functionality may be added later and I will use this as a generic module to house Powershell functions specific to interacting with the Statuscake API.

**DISCLAIMER:** Neither this module, nor its creator are in any way affiliated with StatusCake.


# Usage
This module can be installed from the PowerShell Gallery using the command below.
```powershell
Install-Module StatusCake-Helpers -Repository PSGallery
```

## Example

 The following illustrates how to create two contacts and uptime test, SSL and Page Speed Tests

```powershell
# Setup the StatusCake credentials
# The API credentials must come from the primary account which hosts the tests and not a subaccount which was given access
$StatusCakeAuth = @{
    Username = "username"
    ApiKey = "apikey"
}

$URL = "https://www.example.com"
$team1Emails = @("alerts@example.com","alerts1@example.com")

$team1Contact= New-StatusCakeHelperContactGroup @StatusCakeAuth -GroupName "Team 1 monitoring" -email $team1Emails -mobile "+14155552671"
$team2Contact= New-StatusCakeHelperContactGroup @StatusCakeAuth -GroupName "Team 2 monitoring" -email "alerts2@example.com"

#Create uptime test to check the site every 5 minutes
$uptimeTest = New-StatusCakeHelperTest @StatusCakeAuth -TestName "Example" -TestURL $URL -CheckRate 300 -TestType HTTP -ContactGroup $team1Contact.InsertID

#Create SSL test to check SSL certificate every day
$sslTest = New-StatusCakeHelperSSLTest @StatusCakeAuth -Domain $URL -checkrate 2073600 -contact_groups @($team1Contact.InsertID,$team2Contact.InsertID)

#Create Page Speed Test to monitor page speed every 30 minutes from the UK
$pageSpeedCheckName = "Example site UK speed check"
$pageSpeedTest = New-StatusCakeHelperPageSpeedTest @StatusCakeAuth -name $pageSpeedCheckName -website_url $URL -checkrate 30 -location_iso UK

#Set the page speed test using the name of the test to alert team 2 when the page takes more than 5000ms to load
$result = Set-StatusCakeHelperPageSpeedTest @StatusCakeAuth -name $pageSpeedCheckName -SetByName -contact_groups @($team2Contact.InsertID) -alert_slower 5000

```

## Functions

Below is a list of the available functions and features of the StatusCake API that are supported. Further details of each function can be found in the links below:

[Alerts](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/StatusCake-Helpers/Public/Alerts "StatusCake Alerts")
*  Get-StatusCakeHelperSentAlerts

[ContactGroups](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/StatusCake-Helpers/Public/ContactGroups "StatusCake Contact Groups")
*  Get-StatusCakeHelperAllContactGroups
*  Get-StatusCakeHelperContactGroup
*  New-StatusCakeHelperContactGroup
*  Remove-StatusCakeHelperContactGroup
*  Set-StatusCakeHelperContactGroup

[PageSpeed](https://github.com/Oliver-Lii/statuscake-helpers/tree/master/StatusCake-Helpers/Public/PageSpeed "StatusCake PageSpeed Tests")
*  Get-StatusCakeHelperAllPageSpeedTests
*  Get-StatusCakeHelperPageSpeedTest
*  Get-StatusCakeHelperPageSpeedTestHistory
*  New-StatusCakeHelperPageSpeedTest
*  Remove-StatusCakeHelperPageSpeedTest
*  Set-StatusCakeHelperPageSpeedTest

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