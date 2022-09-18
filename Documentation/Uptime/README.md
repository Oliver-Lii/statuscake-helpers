# Uptime Tests

The following are examples for the functions which work against the StatusCake Uptime API.

### Copy-StatusCakeHelperUptimeTest
The cmdlet copies a Status Cake Test. The cmdlet checks to see if a test with the same name already exists before a copy is created. Supply the WebsiteURL or Paused parameter to override the original values in the source test. Not all values can be copied as some values are not returned when retrieving a test. E.g. BasicUser and BasicPass are not returned when retrieving detailed data on a test. The ID of the copied test is returned.

```powershell
Copy-StatusCakeHelperUptimeTest -TestName "www.example.com Website" -NewTestName "Example - Copy"
123456
```

### Get-StatusCakeHelperUptimeTest
The cmdlet retrieves test data for a specific test via the Test Name or Test ID. If no test name or ID is specified this will return a summary of all tests.

```powershell
Get-StatusCakeHelperUptimeTest
id             : 1234567
paused         : False
name           : www.example.com Website
website_url    : https://www.example.com
test_type      : HTTP
check_rate     : 300
contact_groups : {}
status         : up
tags           : {Example}
uptime         : 100
```
If the name or id of the test is specified the complete test details will be returned

```powershell
Get-StatusCakeHelperUptimeTest -Name "www.example.com Website"
id               : 1234567
paused           : False
name             : www.example.com Website
test_type        : HTTP
website_url      : https://www.example.com
check_rate       : 300
confirmation     : 2
contact_groups   : {123456}
do_not_find      : False
enable_ssl_alert : False
follow_redirects : False
include_header   : False
servers          : {}
processing       : False
status           : up
tags             : {Example}
timeout          : 30
trigger_rate     : 5
uptime           : 100
use_jar          : False
last_tested_at   : 2022-01-01T00:00:00+00:00
next_location    : UNSET
status_codes     : {204, 205, 206, 303...}
```

### Get-StatusCakeHelperUptimeAlert
This cmdlet retrieves all alerts sent. The most recent alerts are returned first and the number of alerts returned can be controlled using the `Limit` argument. The `Before` argument can be used to filter results from before a specific time.

```powershell
Get-StatusCakeHelperUptimeAlert -ID 123456

id      status status_code triggered_at
--      ------ ----------- ------------
123456 up             200 2022-01-02T14:34:16+00:00
123456 down             0 2022-01-02T14:19:10+00:00
123456 up             200 2022-01-01T15:48:07+00:00
...
```

The `Limit` argument can be used to restrict the number of results returned

```powershell
Get-StatusCakeHelperUptimeAlert -ID 123456 - Limit 2

id      status status_code triggered_at
--      ------ ----------- ------------
123456 up             200 2022-01-02T14:34:16+00:00
123456 down             0 2022-01-02T14:19:10+00:00
```
The `Before` argument can be used to return results before a certain date.

```powershell
Get-StatusCakeHelperUptimeAlert -ID 123456 -Before "2022-01-02"

id      status status_code triggered_at
--      ------ ----------- ------------
123456 up             200 2022-01-01T15:48:07+00:00
```

### Get-StatusCakeHelperUptimeHistory
This cmdlet retrieves the history of all uptime checks. The most recent history results are returned first and the number results returned can be controlled using the `Limit` argument. The `Before` argument can be used to filter results from before a specific time.

```powershell
Get-StatusCakeHelperUptimeHistory -ID 123456

created_at                status_code location performance
----------                ----------- -------- -----------
2022-01-01T14:08:39+00:00         200 AU4              676
2022-01-01T14:02:10+00:00         200 jp4              452
2022-01-01T13:57:06+00:00         200 USDA5             64
...
```

The `Limit` argument can be used to restrict the number of results returned

```powershell
Get-StatusCakeHelperUptimeHistory -ID 123456 - Limit 2

created_at                status_code location performance
----------                ----------- -------- -----------
2022-01-01T14:08:39+00:00         200 AU4              676
2022-01-01T14:02:10+00:00         200 jp4              452
```
The `Before` argument can be used to return results before a certain date.

```powershell
Get-StatusCakeHelperUptimeHistory -ID 123456 -Before "2022-01-01T14:00:00"

created_at                status_code location performance
----------                ----------- -------- -----------
2022-01-01T13:57:06+00:00         200 USDA5             64
```

### Get-StatusCakeHelperUptimePeriod
This cmdlet retrieves all the uptime check periods for a uptime test. The most recent check periods are returned first and the number of results returned can be controlled using the `Limit` argument. The `Before` argument can be used to filter results from before a specific time.

```powershell
Get-StatusCakeHelperUptimePeriod -ID 123456

status created_at
------ ----------
up     2022-02-13T00:01:28+00:00
down   2022-02-12T23:56:20+00:00
up     2022-02-12T00:36:21+00:00
...
```

The `Limit` argument can be used to restrict the number of results returned

```powershell
Get-StatusCakeHelperUptimePeriod -ID 123456 - Limit 2

status created_at
------ ----------
up     2022-02-13T00:01:28+00:00
down   2022-02-12T23:56:20+00:00
```
The `Before` argument can be used to return results before a certain date.

```powershell
Get-StatusCakeHelperUptimePeriod -ID 123456 -Before "2022-02-12T23:00:00"

status created_at
------ ----------
up     2022-02-12T00:36:21+00:00
```

### Get-StatusCakeHelperUptimePausedTest
This cmdlet retrieves all tests paused longer than the specified time. If no additional parameters specified it returns all tests paused longer than 1 day.
Granularity of time can specified down to the minute. This function will be slow if there are large numbers of paused tests as detailed test data has to be retrieved for each paused test to determine the length of time it has been paused.

```powershell
Get-StatusCakeHelperUptimePausedTest

id               : 1234567
paused           : True
name             : www.example.com Website
test_type        : HTTP
website_url      : https://www.example.com
check_rate       : 300
confirmation     : 2
contact_groups   : {123456}
do_not_find      : False
enable_ssl_alert : False
follow_redirects : False
include_header   : False
servers          : {}
processing       : False
status           : up
tags             : {Example}
timeout          : 30
trigger_rate     : 5
uptime           : 100
use_jar          : False
last_tested_at   : 2022-01-01T00:00:00+00:00
next_location    : UNSET
status_codes     : {204, 205, 206, 303...}
```

### Remove-StatusCakeHelperUptimeTest
The cmdlet removes a specific test via the Test Name or Test ID.

```powershell
Remove-StatusCakeHelperUptimeTest -Name "www.example.com Website"
```

### Update-StatusCakeHelperUptimeTest
The cmdlet sets a specific test configuration via the Test ID. The example illustrated changes the checkrate to 600 seconds. Any values supplied overwrites existing configuration.

```powershell
Update-StatusCakeHelperUptimeTest -TestID "123456" -CheckRate 600
```


### New-StatusCakeHelperUptimeTest
The cmdlet creates a new Status Cake Test. Parameters shown below are the minimum parameters to create a test. The cmdlet checks to see if a test with the same name already exists before the test is created.

```powershell
New-StatusCakeHelperUptimeTest -Name "Example" -WebsiteURL "https://www.example.com" -CheckRate 300 -TestType HTTP -PassThru
id               : 1234567
paused           : False
name             : www.example.com Website
test_type        : HTTP
website_url      : https://www.example.com
check_rate       : 300
confirmation     : 2
contact_groups   : {123456}
do_not_find      : False
enable_ssl_alert : False
follow_redirects : False
include_header   : False
servers          : {}
processing       : False
status           : up
tags             : {Example}
timeout          : 30
trigger_rate     : 5
uptime           : 100
use_jar          : False
last_tested_at   : 2022-01-01T00:00:00+00:00
next_location    : UNSET
status_codes     : {204, 205, 206, 303...}
```
### Suspend-StatusCakeHelperUptimeTest
This cmdlet pauses a Status Cake Test.

```powershell
Suspend-StatusCakeHelperUptimeTest -TestID "123456"
```
### Resume-StatusCakeHelperUptimeTest
This cmdlet resumes a Status Cake Test.

```powershell
Resume-StatusCakeHelperUptimeTest -TestID "123456"
```

# Authors
- Oliver Li