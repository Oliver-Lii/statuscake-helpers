# Tests

The following are examples for the functions which work against the StatusCake Tests API

### Get-StatusCakeHelperTest
The cmdlet retrieves test data for a specific test via the Test Name or Test ID. If no test name or ID is specified this will return a list of all tests.

```powershell
Get-StatusCakeHelperTest -TestName "www.example.com Website"
TestID             : 123456
Paused             : False
TestType           : HTTP
WebsiteName        : www.example.com Website
WebsiteURL         : https://www.example.com
CheckRate          : 300
ContactGroup       : {}
Public             : 0
Status             : Up
TestTags           : {Example}
WebsiteHost        :
NormalisedResponse : 0
Uptime             : 100
```
### Get-StatusCakeHelperTestDetail
The cmdlet retrieves test data for a specific test via the Test ID.

```powershell
Get-StatusCakeHelperTestDetail -TestName "www.example.com Website"
Method           : GET
TestID           : 123456
TestType         : HTTP
Paused           : False
WebsiteName      : www.example.com Website
URI              : https://www.example.com
ContactGroup     : Contact Group
ContactID        : 12345
ContactGroups    : {@{ID=12345; Name=Contact Group; Email=email@example.com}}
Status           : Up
Tags             : {Example}
Uptime           : 100
CheckRate        : 300
Timeout          : 30
LogoImage        :
Confirmation     : 2
FinalEndpoint    :
WebsiteHost      :
NodeLocations    : {}
FindString       :
DoNotFind        : False
LastTested       : 2020-01-01 00:00:00
NextLocation     : UNSET
Processing       : False
ProcessingState  : Complete
ProcessingOn     :
DownTimes        : 0
TriggerRate      : 5
Sensitive        : False
EnableSSLWarning : False
FollowRedirect   : False
DNSIP            :
DNSServer        :
CustomHeader     :
PostRaw          :
UseJar           : 0
StatusCodes      : {204, 205, 206, 303...}
```

### Get-StatusCakeHelperPausedTest
This cmdlet retrieves all tests paused longer than the specified time. If no additional parameters specified it returns all tests paused longer than 1 day.
Granularity of time can specified down to the minute. This function will be slow if there are large numbers of paused tests as detailed test data has to be
retrieved for each paused test to determine the length of time it has been paused.

```powershell
Get-StatusCakeHelperPausedTest
```

### Remove-StatusCakeHelperTest
The cmdlet removes a specific test via the Test Name or Test ID. No output is return unless the PassThru switch is supplied or an error encountered

```powershell
Remove-StatusCakeHelperTest -TestName "www.example.com Website" -PassThru
Method           : GET
TestID           : 123456
TestType         : HTTP
Paused           : False
WebsiteName      : www.example.com Website
URI              : https://www.example.com
ContactGroup     : Contact Group
ContactID        : 12345
ContactGroups    : {@{ID=12345; Name=Contact Group; Email=email@example.com}}
Status           : Up
Tags             : {Example}
Uptime           : 100
CheckRate        : 300
Timeout          : 30
LogoImage        :
Confirmation     : 2
FinalEndpoint    :
WebsiteHost      :
NodeLocations    : {}
FindString       :
DoNotFind        : False
LastTested       : 2020-01-01 00:00:00
NextLocation     : UNSET
Processing       : False
ProcessingState  : Complete
ProcessingOn     :
DownTimes        : 0
TriggerRate      : 5
Sensitive        : False
EnableSSLWarning : False
FollowRedirect   : False
DNSIP            :
DNSServer        :
CustomHeader     :
PostRaw          :
UseJar           : 0
StatusCodes      : {204, 205, 206, 303...}
```

### Set-StatusCakeHelperTest
The cmdlet sets a specific test configuration via the Test ID. The example illustrated changes the checkrate to 600 seconds. Any values supplied overwrites existing configuration.

```powershell
Set-StatusCakeHelperTest -TestID "123456" -CheckRate 600
Method           : GET
TestID           : 123456
TestType         : HTTP
Paused           : False
WebsiteName      : www.example.com Website
URI              : https://www.example.com
ContactGroup     : Contact Group
ContactID        : 12345
ContactGroups    : {@{ID=12345; Name=Contact Group; Email=email@example.com}}
Status           : Up
Tags             : {Example}
Uptime           : 100
CheckRate        : 600
Timeout          : 30
LogoImage        :
Confirmation     : 2
FinalEndpoint    :
WebsiteHost      :
NodeLocations    : {}
FindString       :
DoNotFind        : False
LastTested       : 2020-01-01 00:00:00
NextLocation     : UNSET
Processing       : False
ProcessingState  : Complete
ProcessingOn     :
DownTimes        : 0
TriggerRate      : 5
Sensitive        : False
EnableSSLWarning : False
FollowRedirect   : False
DNSIP            :
DNSServer        :
CustomHeader     :
PostRaw          :
UseJar           : 0
StatusCodes      : {204, 205, 206, 303...}
```


### New-StatusCakeHelperTest
The cmdlet creates a new Status Cake Test. Parameters shown below are the minimum parameters to create a test. The cmdlet checks to see if a test with the same name already exists before the test is created.

```powershell
New-StatusCakeHelperTest -TestName "Example" -TestURL "https://www.example.com" -CheckRate 300 -TestType HTTP
Method           : GET
TestID           : 123456
TestType         : HTTP
Paused           : False
WebsiteName      : www.example.com Website
URI              : https://www.example.com
ContactGroup     : Contact Group
ContactID        : 12345
ContactGroups    : {@{ID=12345; Name=Contact Group; Email=email@example.com}}
Status           : Up
Tags             : {Example}
Uptime           : 100
CheckRate        : 300
Timeout          : 30
LogoImage        :
Confirmation     : 2
FinalEndpoint    :
WebsiteHost      :
NodeLocations    : {}
FindString       :
DoNotFind        : False
LastTested       : 2020-01-01 00:00:00
NextLocation     : UNSET
Processing       : False
ProcessingState  : Complete
ProcessingOn     :
DownTimes        : 0
TriggerRate      : 5
Sensitive        : False
EnableSSLWarning : False
FollowRedirect   : False
DNSIP            :
DNSServer        :
CustomHeader     :
PostRaw          :
UseJar           : 0
StatusCodes      : {204, 205, 206, 303...}
```


### Copy-StatusCakeHelperTest
The cmdlet copies a Status Cake Test. The cmdlet checks to see if a test with the same name already exists before a copy is created. Supply the TestURL or Paused parameter to override the original values in the source test. Not all values can be copied as some values are not returned when retrieving a test. E.g. BasicUser and BasicPass are not returned when retrieving detailed data on a test.

```powershell
Copy-StatusCakeHelperTest -TestName "www.example.com Website" -NewTestName "Example - Copy"
Method           : GET
TestID           : 123456
TestType         : HTTP
Paused           : False
WebsiteName      : Example - Copy
URI              : https://www.example.com
ContactGroup     : Contact Group
ContactID        : 12345
ContactGroups    : {@{ID=12345; Name=Contact Group; Email=email@example.com}}
Status           : Up
Tags             : {Example}
Uptime           : 100
CheckRate        : 300
Timeout          : 30
LogoImage        :
Confirmation     : 2
FinalEndpoint    :
WebsiteHost      :
NodeLocations    : {}
FindString       :
DoNotFind        : False
LastTested       : 2020-01-01 00:00:00
NextLocation     : UNSET
Processing       : False
ProcessingState  : Complete
ProcessingOn     :
DownTimes        : 0
TriggerRate      : 5
Sensitive        : False
EnableSSLWarning : False
FollowRedirect   : False
DNSIP            :
DNSServer        :
CustomHeader     :
PostRaw          :
UseJar           : 0
StatusCodes      : {204, 205, 206, 303...}
```

### Add-StatusCakeHelperTestNodeLocation
This cmdlet add a Test Node location to a Status Cake Test. The cmdlet checks to see if a test node location is valid by verifying it against the list of server codes retrieved from the StatusCake API before adding it to the test.

```powershell
Add-StatusCakeHelperTestNodeLocations -TestID "123456" -NodeLocations @("EU1","EU2")
```

### Add-StatusCakeHelperTestStatusCode
This cmdlet add a HTTP Status code to a Status Cake Test. The cmdlet checks to see if a HTTP Status Code is valid before adding it to the test.

```powershell
Add-StatusCakeHelperTestStatusCodes -TestID "123456" -StatusCodes @("206","207")
```

### Add-StatusCakeHelperTestTag
This cmdlet adds an additional tag to a Status Cake Test.

```powershell
Add-StatusCakeHelperTestTag -TestID "123456" -TestTags @("Tag1","Tag2")
```

### Remove-StatusCakeHelperTestNodeLocation
This cmdlet removes a Test Node location from a Status Cake Test. The cmdlet checks to see if a test node location is valid by verifying it against the list of server codes retrieved from the StatusCake API before removing it from the test.

```powershell
Add-StatusCakeHelperTestNodeLocation -TestID "123456" -NodeLocations @("EU1","EU2")
```

### Remove-StatusCakeHelperTestStatusCode
This cmdlet removes a HTTP Status code from a Status Cake Test. The cmdlet checks to see if a HTTP Status Code is valid before removing it from the test.

```powershell
Remove-StatusCakeHelperTestStatusCode -TestID "123456" -StatusCodes @("206","207")
```

### Remove-StatusCakeHelperTestTag
This cmdlet removes a tag from a Status Cake Test.

```powershell
Remove-StatusCakeHelperTestTag -TestID "123456" -TestTags @("Tag1","Tag2")
```
### Suspend-StatusCakeHelperTest
This cmdlet pauses a Status Cake Test.

```powershell
Suspend-StatusCakeHelperTest -TestID "123456"
```
### Resume-StatusCakeHelperTest
This cmdlet resumes a Status Cake Test.

```powershell
Resume-StatusCakeHelperTest -TestID "123456"
```

# Authors
- Oliver Li