# Public Reporting Pages

The following are examples for the functions which work against the StatusCake Public Reporting API

### Get-StatusCakeHelperPublicReportingPage
This cmdlet retrieves all Public Reporting Pages if no id or title supplied

```powershell
Get-StatusCakeHelperPublicReportingPage @StatusCakeAuth
```

### New-StatusCakeHelperPublicReportingPage
This cmdlet creates a new public reporting page. The cmdlet tests to see if a page with the title to be monitored already exists before creating the public reporting page. 

```powershell
New-StatusCakeHelperPublicReportingPage @StatusCakeAuth -title "Example Public Reporting Page" -tests_or_tags @("12345","23456")
```

### Copy-StatusCakeHelperPublicReportingPage
This cmdlet copies a public reporting page. The cmdlet tests to see if a page with the title to be monitored already exists before creating the public reporting page. 

```powershell
Copy-StatusCakeHelperPublicReportingPage @StatusCakeAuth -title "Example Public Reporting Page" -NewTitle "Example Public Reporting Page - Copy"
```

### Set-StatusCakeHelperPublicReportingPage
This cmdlet sets the configuration of a public reporting page. If a id or a title with setByTitle flag set is not supplied then a new public reporting page will be created.

```powershell
Set-StatusCakeHelperPublicReportingPage @StatusCakeAuth -id "1a2b3c4d5" -display_orbs $false
```
A public reporting page can be updated by title if there are no duplicates as follows:
```powershell
Set-StatusCakeHelperPublicReportingPage @StatusCakeAuth -title "Example Public Reporting Page" -display_orbs $false -SetByTitle
```

### Remove-StatusCakeHelperPublicReportingPage
This cmdlet removes a Public Reporting page via either id or title of the public reporting page

```powershell
Remove-StatusCakeHelperPublicReportingPage @StatusCakeAuth -id "1a2b3c4d5"
```
To remove by title specify the title parameter
```powershell
Remove-StatusCakeHelperPublicReportingPage @StatusCakeAuth -title "Example Public Reporting Page"
```

# Authors
- Oliver Li