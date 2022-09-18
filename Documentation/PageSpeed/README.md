# Page Speed

The following are examples for the functions which work against the StatusCake Page Speed API

### Get-StatusCakeHelperPageSpeedTest
This cmdlet retrieves a page speed test by name or id. If no id or name is supplied all page speed tests will be returned.

```powershell
Get-StatusCakeHelperPageSpeedTest -ID 123456
id             : 123456
paused         : False
name           : Example.com
website_url    : https://www.example.com
check_rate     : 86400
location       : USW3.PAGESPEED.STATUSCAKE.NET
contact_groups : {}
alert_smaller  : 0
alert_bigger   : 0
alert_slower   : 0
latest_stats   : @{loadtime=240; filesize=1.227; requests=1; has_issue=False}
```

### Get-StatusCakeHelperPageSpeedTestHistory
This cmdlet retrieves the histories of a page speed test by name or id. The most recent results are returned first and the number of results returned can be controlled using the `Limit` argument. The `Before` argument can be used to filter results from before a specific time.

```powershell
Get-StatusCakeHelperPageSpeedTestHistory -ID 123456
created_at   : 2022-01-15T05:10:30+00:00
loadtime     : 240
requests     : 1
filesize     : 1.227
throttling   : NONE
har_location :

created_at   : 2022-01-14T04:15:15+00:00
loadtime     : 242
requests     : 1
filesize     : 1.227
throttling   : NONE
har_location :

created_at   : 2022-01-13T03:07:30+00:00
loadtime     : 266
requests     : 1
filesize     : 1.227
throttling   : NONE
har_location :
```

The `Limit` argument can be used to restrict the number of results returned

```powershell
Get-StatusCakeHelperPageSpeedTestHistory -ID 123456 -Limit 1
created_at   : 2022-01-15T05:10:30+00:00
loadtime     : 240
requests     : 1
filesize     : 1.227
throttling   : NONE
har_location :
```

The `Before` argument can be used to return results before a certain date.

```powershell
Get-StatusCakeHelperPageSpeedTestHistory -ID 123456 -Before 2022-01-15
created_at   : 2022-01-14T04:15:15+00:00
loadtime     : 242
requests     : 1
filesize     : 1.227
throttling   : NONE
har_location :

created_at   : 2022-01-13T03:07:30+00:00
loadtime     : 266
requests     : 1
filesize     : 1.227
throttling   : NONE
har_location :
```

### New-StatusCakeHelperPageSpeedTest
This cmdlet creates a new page speed test. The following are the minimum required parameters to create a test. Only the ID of the page speed test is returned and to return the page speed test specify the PassThru switch.

```powershell
New-StatusCakeHelperPageSpeedTest -Name "Example website" -WebsiteURL "https://www.example.com" -Checkrate 30 -LocationISO UK -PassThru
id             : 123456
paused         : False
name           : Example.com
website_url    : https://www.example.com
check_rate     : 86400
location       : USW3.PAGESPEED.STATUSCAKE.NET
contact_groups : {}
alert_smaller  : 0
alert_bigger   : 0
alert_slower   : 0
latest_stats   : @{loadtime=240; filesize=1.227; requests=1; has_issue=False}

```

### Copy-StatusCakeHelperPageSpeedTest
This cmdlet copies a page speed test. Supply the website_url parameter to override the source website URL. The ID of the copied test is returned.

```powershell
Copy-StatusCakeHelperPageSpeedTest -Name "Example Website" -NewName "Example Website - Copy" -Region UK
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

### Update-StatusCakeHelperPageSpeedTest
This cmdlet updates the configuration of a specific page speed Test.

A PageSpeed Test can be updated by name if there are no duplicates as follows:
```powershell
Update-StatusCakeHelperPageSpeedTest -Name "Example website" -WebsiteURL "https://www.example.com" -Region UK -Checkrate 60
```

# Authors
- Oliver Li