# SSL Tests

The following are examples for the functions which work against the StatusCake SSL Tests API

### Get-StatusCakeHelperAllSSLTests
This cmdlet retrieves all SSL Tests

```powershell
Get-StatusCakeHelperAllSSLTests @StatusCakeAuth
```

### Get-StatusCakeHelperSSLTest
This cmdlet retrieves a specific StatusCake SSL Test by id or domain

```powershell
Get-StatusCakeHelperSSLTest @StatusCakeAuth -id 89571
```
![new-statuscakehelpertest](https://user-images.githubusercontent.com/30263630/32247953-fb53194c-be7b-11e7-99df-490f892de6c1.png)

### New-StatusCakeHelperSSLTest
This cmdlet creates a new SSL Test. The cmdlet tests to see if the domain to be monitored already being checked before creating the SSL Test. A SSL test is created by default to have all reminders enabled at 60, 30 and 7 days intervals. Mandatory parameters are illustrated in the example below:

```powershell
New-StatusCakeHelperSSLTest @StatusCakeAuth -Domain "https://www.example.com" -checkrate 3600
```

### Copy-StatusCakeHelperSSLTest
This cmdlet copies a SSL Test. The cmdlet tests to see if the domain to be monitored already being checked before creating the SSL Test. The check rate is not returned when retrieving the details of a SSL test and defaults to checking once a day.

```powershell
Copy-StatusCakeHelperSSLTest @StatusCakeAuth -Domain "https://www.example.org" -NewDomain "https://www.example.com"
```

### Set-StatusCakeHelperSSLTest
This cmdlet sets the configuration of a specific SSL Test. If a id or a domain with setByDomain flag set is not supplied then a new test will be created

```powershell
Set-StatusCakeHelperSSLTest @StatusCakeAuth -id 89571 -checkrate 3600 -Alert_At @("14","90","120") 
```
A SSL Test can be updated by domain if there are no duplicates as follows:
```powershell
Set-StatusCakeHelperSSLTest @StatusCakeAuth -Domain "https://www.example.com" -checkrate 3600 -Alert_At @("14","90","120") -SetByDomain
```
A new SSL Test can be created via the cmdlet with the following parameters:
```powershell
Set-StatusCakeHelperSSLTest @StatusCakeAuth -domain https://www.google.com -CheckRate "3600" -contact_groups "0" -alert_expiry 0 -alert_reminder 0 -alert_broken 0 -Alert_At @("14","90","120")
```

### Remove-StatusCakeHelperSSLTest
This cmdlet removes a SSL Test via either id or domain of the SSL Test

```powershell
Remove-StatusCakeHelperSSLTest @StatusCakeAuth -id 89571
```
To remove by domain specify the domain parameter
```powershell
Remove-StatusCakeHelperSSLTest @StatusCakeAuth -Domain "https://www.example.com"
```

# Authors
- Oliver Li