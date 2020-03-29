# Performance Data

The following are the functions which work against the StatusCake API

### Get-StatusCakeHelperPerformanceData
This cmdlet retrieves a list of tests that have been carried out for a given uptime test.

```powershell
Get-StatusCakeHelperPerformanceData -TestID 123456 -Limit 5 -Start "2020-01-01 00:00:00"
TestID      : 123456
Time        : 1577836800
Status      : 200
Location    : FREE2
Human       : 2020-01-01T00:00:00+00:00
Headers     :
Performance : 5626

```

# Authors
- Oliver Li