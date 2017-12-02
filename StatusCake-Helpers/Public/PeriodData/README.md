# Period Data

The following are examples for the functions which work against the StatusCake Period Data API

### Get-StatusCakeHelperPeriodOfData
This cmdlet retrieves a list of periods of data for a specified test. A period of data is two time stamps in which status has remained the same - such as a period of downtime or uptime.

```powershell
Get-StatusCakeHelperPeriodOfData @StatusCakeAuth -TestID "123456"
```

# Authors
- Oliver Li