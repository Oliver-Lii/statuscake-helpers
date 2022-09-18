# Alerts

The following are the functions for managing the API credentials used by this module

### Remove-StatusCakeHelperAPIAuth
This cmdlet removes the StatusCake API Authentication credentials returning true or false based on the result of removal operation.

```powershell
Remove-StatusCakeHelperAPIAuth
```

### Set-StatusCakeHelperAPIAuth
This cmdlet sets the StatusCake API Authentication credentials for use by the other cmdlets.

```powershell
Set-StatusCakeHelperAPIAuth -APIKey (Read-Host -AsSecureString -Prompt "Please enter the API key")
```
Use the session switch if credentials do not need to be stored on disk and persisted.
```powershell
Set-StatusCakeHelperAPIAuth -APIKey (Read-Host -AsSecureString -Prompt "Please enter the API key") -session
```
### Test-StatusCakeHelperAPIAuth
This cmdlet tests for the presence of StatusCake API Authentication credentials

```powershell
Test-StatusCakeHelperAPIAuthSet
```

# Authors
- Oliver Li