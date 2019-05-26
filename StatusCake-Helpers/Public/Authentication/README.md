# Alerts

The following are the functions which work against the StatusCake Alerts API  

### Remove-StatusCakeHelperAPIAuth
This cmdlet removes the StatusCake API Authentication credentials returning true or false based on the result of removal operation.

```powershell
Remove-StatusCakeHelperAPIAuth
```

### Set-StatusCakeHelperAPIAuth
This cmdlet sets the StatusCake API Authentication credentials for use by the other cmdlets

```powershell
$scUser = Read-Host "Enter the StatusCake Username"
$scAPIKey = Read-Host "Enter the StatusCake API key" -AsSecureString
$scCredentials = New-Object System.Management.Automation.PSCredential ($scUser, $scAPIKey)
Set-StatusCakeHelperAPIAuth -Credentials $scCredentials
```
### Test-StatusCakeHelperAPIAuth
This cmdlet tests for the presence of StatusCake API Authentication credentials

```powershell
Test-StatusCakeHelperAPIAuthSet
```

# Authors
- Oliver Li