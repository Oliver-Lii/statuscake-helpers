# Alerts

The following are the functions which work against the StatusCake Alerts API  

### Get-StatusCakeHelperSentAlerts
This cmdlet retrieves a list of alerts that have been sent. A test ID can be supplied to limit alerts from a single test. Use the "Since" parameter to include results only since that time.

```powershell
Get-StatusCakeHelperSentAlerts @StatusCakeAuth -TestID 123456 -since "2017-08-19 13:29:49"
```

# Authors
- Oliver Li