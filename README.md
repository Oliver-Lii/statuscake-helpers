# StatusCake-Helpers [![Build status](https://ci.appveyor.com/api/projects/status/9m3gk7n9ywuj3do6/branch/master?svg=true)](https://ci.appveyor.com/project/Oliver-Lii/statuscake-helpers/branch/master)


This module was written to support interaction with the Statuscake API via Powershell. Additional functionality may be added later and I will use this as a generic module to house Powershell functions specific to interacting with the Statuscake API.



# Usage
This module can be installed from the PowerShell Gallery using the command below.
```
Install-Module StatusCake-Helpers -Repository PSGallery
```

# Alerts

### Get-StatusCakeHelperSentAlerts
This cmdlet retrieves a list of alerts that have been sent. A test ID can be supplied to limit alerts from a single test. Use the "Since" parameter to include results only since that time.

```
Get-StatusCakeHelperSentAlerts -Username "Username" -ApiKey "APIKEY" -TestID 123456 -since "2017-08-19 13:29:49"
```

# Contact Groups

### Get-StatusCakeHelperAllContactGroups
This cmdlet retrieves all contact groups.

```
Get-StatusCakeHelperAllContactGroups -Username "Username" -ApiKey "APIKEY"
```
![image](https://user-images.githubusercontent.com/30263630/32748088-07d72942-c8b3-11e7-97b1-01481830ba97.png)

### Get-StatusCakeHelperContactGroup
This cmdlet retrieves a specific contact group.

```
Get-StatusCakeHelperContactGroup -Username "Username" -ApiKey "APIKEY" -ContactID "81384"
```
![image](https://user-images.githubusercontent.com/30263630/32747914-5457be2c-c8b2-11e7-83ab-2fa46becd733.png)

### New-StatusCakeHelperContactGroup
This cmdlet creates a new contact group. If a mobile number is supplied this is validated to confirm that it meets E.164 number formatting.

```
New-StatusCakeHelperContactGroup -Username "Username" -ApiKey "APIKEY" -GroupName "Example" -email @(test@example.com) -mobile "+14155552671"
```
![image](https://user-images.githubusercontent.com/30263630/32748186-61bda10c-c8b3-11e7-9dc3-e88d01548db0.png)

### Remove-StatusCakeHelperContactGroup
This cmdlet removes a contact group. If the contact group is in use by any tests then the -force switch must be supplied to remove the contact group.


```
Remove-StatusCakeHelperContactGroup -Username "Username" -ApiKey "APIKEY" -ContactID "123456"
```
A Contact Group can be removed by group name using the GroupName parameter. Specify the -PassThru flag if you want the details of a successful removed returned.
```
Remove-StatusCakeHelperContactGroup -Username "Username" -ApiKey "APIKEY" -GroupName "Example.com" -verbose -PassThru
```
![image](https://user-images.githubusercontent.com/30263630/32748337-e72bb5b8-c8b3-11e7-966e-47bfd168c3d8.png)

### Set-StatusCakeHelperContactGroup
This cmdlet sets the configuration of a contact group to the specified values. If a contactID is not supplied then a new contact will be created

```
Set-StatusCakeHelperContactGroup @StatusCakeAuth -ContactID "123456" -Email @("test8@example.com")
```
A Contact Group can be updated by group name if there are no duplicates as follows:
```
Set-StatusCakeHelperContactGroup @StatusCakeAuth -GroupName "API Test Contact Group" -Email @("test4@example.com") -verbose -SetByGroupName
```
![image](https://user-images.githubusercontent.com/30263630/32748562-8a457c84-c8b4-11e7-9990-bda7e519c70e.png)

# Page Speed

### Get-StatusCakeHelperAllPageSpeedTests
This cmdlet retrieves all the page speed tests

```
Get-StatusCakeHelperAllPageSpeedTests -Username "Username" -ApiKey "APIKEY"
```
![image](https://user-images.githubusercontent.com/30263630/32909663-0aadd942-caff-11e7-9b72-3a24ae6e426a.png)

### Get-StatusCakeHelperPageSpeedTest
This cmdlet retrieves a specific page speed test by name or id

```
Get-StatusCakeHelperPageSpeedTest -Username "Username" -ApiKey "APIKEY" -id 123456
```
![image](https://user-images.githubusercontent.com/30263630/32909708-2290d6f4-caff-11e7-8470-42d591ed146e.png)


### Get-StatusCakeHelperPageSpeedTestHistory
This cmdlet retrieves the history of a page speed test by name or id

```
Get-StatusCakeHelperPageSpeedTestHistory -Username "Username" -ApiKey "APIKEY" -id 123456
```
![image](https://user-images.githubusercontent.com/30263630/32909743-3b697f6e-caff-11e7-868a-6ea7c48cfe76.png)

### New-StatusCakeHelperPageSpeedTest
This cmdlet creates a new page speed test. The following are the minimum required parameters to create a test.

```
New-StatusCakeHelperPageSpeedTest -Username "Username" -ApiKey "APIKEY" -Name "Example website" -website_url "https://www.example.com" -checkrate 30 -location_iso UK
```

### Remove-StatusCakeHelperPageSpeedTest
This cmdlet retrieves the history of a page speed test by name or id

```
Remove-StatusCakeHelperPageSpeedTest -Username "Username" -ApiKey "APIKEY" -ID 123456
```
To remove by name specify the name parameter
```
Remove-StatusCakeHelperSSLTest -Username "Username" -ApiKey "APIKEY" -Name "Example Website"
```

### Set-StatusCakeHelperPageSpeedTest
This cmdlet sets the configuration of a specific PageSpeed Test. If a id or a name with setByName flag set is not supplied then a new test will be created

```
Set-StatusCakeHelperPageSpeedTest -Username "Username" -ApiKey "APIKEY" -ID 123456
```
A PageSpeed Test can be updated by name if there are no duplicates as follows:
```
Set-StatusCakeHelperPageSpeedTest -Username "Username" -ApiKey "APIKEY" -ID 123456 -SetByName -name "Example website" -website_url "https://www.example.com" -location_iso UK -checkrate 60 -Verbose 
```
A new PageSpeed Test can be created via the cmdlet with the following parameters:
```
Set-StatusCakeHelperPageSpeedTest -Username "Username" -ApiKey "APIKEY" -ID 123456 -Name "Example website" -website_url "https://www.example.com" -checkrate 30 -location_iso UK
```

# Period Data

### Get-StatusCakeHelperPeriodOfData
This cmdlet retrieves a list of periods of data for a specified test. A period of data is two time stamps in which status has remained the same - such as a period of downtime or uptime.

```
Get-StatusCakeHelperPeriodOfData -Username "Username" -ApiKey "APIKEY" -TestID "123456"
```

# Probes

### Get-StatusCakeHelperProbes
The cmdlet retrieves the details of the probes from the StatusCake API. City and Country information is extracted from the Probe Title and added as separate properties. The probe data is returned sorted by Title.

```
Get-StatusCakeHelperProbes
```
![get-statuscakehelperprobes](https://user-images.githubusercontent.com/30263630/29495809-890e0d42-85be-11e7-8acf-3af7eeeac98a.PNG)

### Get-StatusCakeHelperRegionProbes
The cmdlet retrieves the probes nearest to a specific AWS Region

```
Get-StatusCakeHelperRegionProbes -AWSRegion "eu-west-1"
```
![get-statuscakehelperregionprobes](https://user-images.githubusercontent.com/30263630/29495858-922a5d3a-85bf-11e7-9526-d14a66eb8ee5.png)

# SSL Tests

### Get-StatusCakeHelperAllSSLTests
This cmdlet retrieves all SSL Tests

```
Get-StatusCakeHelperAllSSLTests -Username "Username" -ApiKey "APIKEY"
```

### Get-StatusCakeHelperSSLTest
This cmdlet retrieves a specific StatusCake SSL Test by id or domain

```
Get-StatusCakeHelperSSLTest -Username "Username" -ApiKey "APIKEY" -id 89571
```
![new-statuscakehelpertest](https://user-images.githubusercontent.com/30263630/32247953-fb53194c-be7b-11e7-99df-490f892de6c1.png)

### New-StatusCakeHelperSSLTest
This cmdlet creates a new SSL Test. The cmdlet tests to see if the domain to be monitored already being checked before creating the SSL Test. A SSL test is created by default to have all reminders enabled at 60, 30 and 7 days intervals. Mandatory parameters are illustrated in the example below:

```
New-StatusCakeHelperSSLTest -Username "Username" -ApiKey "APIKEY" -Domain "https://www.example.com" -checkrate 3600
```

### Set-StatusCakeHelperSSLTest
This cmdlet sets the configuration of a specific SSL Test. If a id or a domain with setByDomain flag set is not supplied then a new test will be created

```
Set-StatusCakeHelperSSLTest -Username "Username" -ApiKey "APIKEY" -id 89571 -checkrate 3600 -Alert_At @("14","90","120") 
```
A SSL Test can be updated by domain if there are no duplicates as follows:
```
Set-StatusCakeHelperSSLTest -Username "Username" -ApiKey "APIKEY" -Domain "https://www.example.com" -checkrate 3600 -Alert_At @("14","90","120") -SetByDomain
```
A new SSL Test can be created via the cmdlet with the following parameters:
```
Set-StatusCakeHelperSSLTest @StatusCakeAuth -domain https://www.google.com -CheckRate "3600" -contact_groups "0" -alert_expiry 0 -alert_reminder 0 -alert_broken 0 -Alert_At @("14","90","120")
```

### Remove-StatusCakeHelperSSLTest
This cmdlet removes a SSL Test via either id or domain of the SSL Test

```
Remove-StatusCakeHelperSSLTest -Username "Username" -ApiKey "APIKEY" -id 89571
```
To remove by domain specify the domain parameter
```
Remove-StatusCakeHelperSSLTest -Username "Username" -ApiKey "APIKEY" -Domain "https://www.example.com"
```

# Tests

### Get-StatusCakeHelperAllTests
The cmdlet retrieves all the tests that the user has permission for.

```
Get-StatusCakeHelperAllTests -Username "Username" -ApiKey "APIKEY"
```
![get-statuscakehelperalltests](https://user-images.githubusercontent.com/30263630/29495718-ad4af0d2-85bc-11e7-92c4-320f2c9bebca.PNG)

### Get-StatusCakeHelperDetailedTestData
The cmdlet retrieves detailed test data for a specific test via the Test Name or Test ID

```
Get-StatusCakeHelperDetailedTestData -Username "Username" -ApiKey "APIKEY" -TestName "Yahoo DNS"
```
![get-statuscakehelperdetailedtestdata](https://user-images.githubusercontent.com/30263630/29495774-d094e24a-85bd-11e7-8ff4-0a7e263e8cd3.PNG)

### Get-StatusCakeHelperTest
The cmdlet retrieves basic test data for a specific test via the Test Name or Test ID

```
Get-StatusCakeHelperTest -Username "Username" -ApiKey "APIKEY" -TestName "Yahoo DNS"
```
![get-statuscakehelpertest](https://user-images.githubusercontent.com/30263630/29495889-fe88432a-85bf-11e7-8ea5-08cc99fc5883.PNG)

### Get-StatusCakeHelperPausedTests
This cmdlet retrieves all tests paused longer than the specified time. If no additional parameters specified it returns all tests paused longer than 1 day. Granularity of time can specified down to the minute.

```
Get-StatusCakeHelperPausedTests -Username "Username" -ApiKey "APIKEY"
```

### Remove-StatusCakeHelperTest
The cmdlet removes a specific test via the Test Name or Test ID. No output is return unless the PassThru switch is supplied or an error encountered

```
Remove-StatusCakeHelperTest -Username "Username" -ApiKey "APIKEY" -TestName "Yahoo DNS" -PassThru
```
![remove-statuscakehelpertest](https://user-images.githubusercontent.com/30263630/29495953-c29d1d1c-85c0-11e7-941e-fb100c060ae9.PNG)

### Set-StatusCakeHelperTest
The cmdlet sets a specific test configuration via the Test ID. The example illustrated below pauses the specified check. Any values supplied overwrites existing configuration.

```
Set-StatusCakeHelperTest -Username "Username" -ApiKey "APIKEY" -TestID "2425217" -Paused 1
```
![set-statuscakehelpertest](https://user-images.githubusercontent.com/30263630/29495985-4b5557be-85c1-11e7-81db-1cf63c95af06.PNG)

### New-StatusCakeHelperTest
The cmdlet creates a new Status Cake Test. Parameters shown below are the minimum parameters to create a test. The cmdlet checks to see if a test with the same name already exists before the test is created.

```
New-StatusCakeHelperTest -Username "Username" -ApiKey "APIKEY" -TestName "Example" -TestURL "https://www.example.com" -CheckRate 300 -TestType HTTP
```
![new-statuscakehelpertest](https://user-images.githubusercontent.com/30263630/29495757-4adfce26-85bd-11e7-8a68-1f8253a91068.PNG)

### Add-StatusCakeHelperTestNodeLocations
This cmdlet add a Test Node location to a Status Cake Test. The cmdlet checks to see if a test node location is valid by verifying it against the list of server codes retrieved from the StatusCake API before adding it to the test.

```
Add-StatusCakeHelperTestNodeLocations -Username "Username" -ApiKey "APIKEY" -TestID "123456" -NodeLocations @("EU1","EU2")
```

### Add-StatusCakeHelperTestStatusCodes
This cmdlet add a HTTP Status code to a Status Cake Test. The cmdlet checks to see if a HTTP Status Code is valid before adding it to the test.

```
Add-StatusCakeHelperTestStatusCodes -Username "Username" -ApiKey "APIKEY" -TestID "123456" -StatusCodes @("206","207")
```

### Add-StatusCakeHelperTestTags
This cmdlet adds an additional tag to a Status Cake Test.

```
Add-StatusCakeHelperTestTags -Username "Username" -ApiKey "APIKEY" -TestID "123456" -TestTags @("Tag1","Tag2")
```

### Remove-StatusCakeHelperTestNodeLocations
This cmdlet removes a Test Node location from a Status Cake Test. The cmdlet checks to see if a test node location is valid by verifying it against the list of server codes retrieved from the StatusCake API before removing it from the test.

```
Add-StatusCakeHelperTestNodeLocations -Username "Username" -ApiKey "APIKEY" -TestID "123456" -NodeLocations @("EU1","EU2")
```

### Remove-StatusCakeHelperTestStatusCodes
This cmdlet removes a HTTP Status code from a Status Cake Test. The cmdlet checks to see if a HTTP Status Code is valid before removing it from the test.

```
Remove-StatusCakeHelperTestStatusCodes -Username "Username" -ApiKey "APIKEY" -TestID "123456" -StatusCodes @("206","207")
```

### Remove-StatusCakeHelperTestTags
This cmdlet removes a tag from a Status Cake Test.

```
Remove-StatusCakeHelperTestTags -Username "Username" -ApiKey "APIKEY" -TestID "123456" -TestTags @("Tag1","Tag2")
```


# Authors
- Oliver Li
