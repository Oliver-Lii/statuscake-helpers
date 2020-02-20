# Period Data

The following are examples for the functions which work against the StatusCake Period Data API

### Get-StatusCakeHelperPeriodOfData
This cmdlet retrieves a list of periods of data for a specified test. A period of data is two time stamps in which status has remained the same - such as a period of downtime or uptime.

```powershell
Get-StatusCakeHelperPeriodOfData -TestID "123456"
Status     : Up
StatusID   : 2160191626
Start      : 2020-01-01 00:00:00
End        : 2020-01-02 00:00:00
Start_Unix : 1577836800
End_Unix   : 1577923200
Period     : 1 Days 0 Hours
```

# Authors
- Oliver Li