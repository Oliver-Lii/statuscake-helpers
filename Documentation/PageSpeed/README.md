# Page Speed

The following are examples for the functions which work against the StatusCake Page Speed API

### Get-StatusCakeHelperPageSpeedTest
This cmdlet retrieves a page speed test by name or id. If no id or name is supplied all page speed tests will be returned.

```powershell
Get-StatusCakeHelperPageSpeedTest -ID 123456
ID            : 123456
Title         : Example website
URL           : https://www.example.com
Location      : USW3.PAGESPEED.STATUSCAKE.NET
Location_ISO  : USW
ContactGroups : {}
LatestStats   : @{Loadtime_ms=293; Filesize_kb=1.227; Requests=1}
```

### Get-StatusCakeHelperPageSpeedTestDetail
This cmdlet retrieves detailed page speed test information by id.

```powershell
Get-StatusCakeHelperPageSpeedTestDetail -ID 123456
id             : 123456
name           : Example website
website_url    : https://www.example.com
location       : USW3.PAGESPEED.STATUSCAKE.NET
location_iso   : USW
checkrate      : 1440
contact_groups : {}
alert_smaller  : 0
alert_bigger   : 0
alert_slower   : 0
latest_stats   : @{Loadtime_ms=293; Filesize_kb=1.227; Requests=1; has_issue=False; latest_issue=}
```

### Get-StatusCakeHelperPageSpeedTestHistory
This cmdlet retrieves the history of a page speed test by name or id

```powershell
Get-StatusCakeHelperPageSpeedTestHistory -ID 123456
aggregated                                          results
----------                                          -------
@{loadtime_ms=; requests=; filesize_kb=; results=1} @{1581870651=}
```

### New-StatusCakeHelperPageSpeedTest
This cmdlet creates a new page speed test. The following are the minimum required parameters to create a test.

```powershell
New-StatusCakeHelperPageSpeedTest -Name "Example website" -WebsiteURL "https://www.example.com" -Checkrate 30 -LocationISO UK
id             : 123456
name           : Example website
website_url    : https://www.example.com
location       : UK8.PAGESPEED.STATUSCAKE.NET
location_iso   : UK
checkrate      : 30
contact_groups : {}
alert_smaller  : 0
alert_bigger   : 0
alert_slower   : 0
latest_stats   : @{Loadtime_ms=293; Filesize_kb=1.227; Requests=1; has_issue=False; latest_issue=}

```

### Copy-StatusCakeHelperPageSpeedTest
This cmdlet copies a page speed test. Supply the website_url parameter to override the source website URL

```powershell
Copy-StatusCakeHelperPageSpeedTest -Name "Example Website" -NewName "Example Website - Copy"
id             : 123456
name           : Example Website - Copy
website_url    : https://www.example.com
location       : UK8.PAGESPEED.STATUSCAKE.NET
location_iso   : UK
checkrate      : 30
contact_groups : {}
alert_smaller  : 0
alert_bigger   : 0
alert_slower   : 0
latest_stats   : @{Loadtime_ms=; Filesize_kb=; Requests=; has_issue=; latest_issue=}
```

### Remove-StatusCakeHelperPageSpeedTest
This cmdlet retrieves the history of a page speed test by name or id

```powershell
Remove-StatusCakeHelperPageSpeedTest -ID 123456
```
To remove by name specify the name parameter
```powershell
Remove-StatusCakeHelperPageSpeedTest -Name "Example Website" -Passthru
id             : 123456
name           : Example website
website_url    : https://www.example.com
location       : UK8.PAGESPEED.STATUSCAKE.NET
location_iso   : UK
checkrate      : 30
contact_groups : {}
alert_smaller  : 0
alert_bigger   : 0
alert_slower   : 0
latest_stats   : @{Loadtime_ms=293; Filesize_kb=1.227; Requests=1; has_issue=False; latest_issue=}
```

### Set-StatusCakeHelperPageSpeedTest
This cmdlet sets the configuration of a specific PageSpeed Test. If a id or a name with setByName flag set is not supplied then a new test will be created

A PageSpeed Test can be updated by name if there are no duplicates as follows:
```powershell
Set-StatusCakeHelperPageSpeedTest -ID 123456 -SetByName -Name "Example website" -WebsiteURL "https://www.example.com" -LocationISO UK -Checkrate 60
id             : 123456
name           : Example Website
website_url    : https://www.example.com
location       : UK8.PAGESPEED.STATUSCAKE.NET
location_iso   : UK
checkrate      : 60
contact_groups : {}
alert_smaller  : 0
alert_bigger   : 0
alert_slower   : 0
latest_stats   : @{Loadtime_ms=; Filesize_kb=; Requests=; has_issue=; latest_issue=}
```
A new PageSpeed Test can be created via the cmdlet with the following parameters:
```powershell
Set-StatusCakeHelperPageSpeedTest -ID 123456 -Name "Example website" -WebsiteURL "https://www.example.com" -Checkrate 30 -LocationISO UK
id             : 123456
name           : Example Website
website_url    : https://www.example.com
location       : UK8.PAGESPEED.STATUSCAKE.NET
location_iso   : UK
checkrate      : 30
contact_groups : {}
alert_smaller  : 0
alert_bigger   : 0
alert_slower   : 0
latest_stats   : @{Loadtime_ms=; Filesize_kb=; Requests=; has_issue=; latest_issue=}
```

# Authors
- Oliver Li