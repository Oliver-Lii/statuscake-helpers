# Contact Groups

The following are examples for the functions which work against the StatusCake Contact Groups API

### Get-StatusCakeHelperContactGroup
This cmdlet returns all contact groups unless a group name or contact ID is specified.

```powershell
Get-StatusCakeHelperContactGroup -ContactID "123456"

id              : 123456
name            : Test Contact Group
email_addresses : {test@example.com}
mobile_numbers  : {}
integrations    : {}
```

### New-StatusCakeHelperContactGroup
This cmdlet creates a new contact group. If a mobile number is supplied this is validated to confirm that it meets E.164 number formatting. Only the ID of the contact group is returned and to return the contact group specify the PassThru switch.

```powershell
New-StatusCakeHelperContactGroup -GroupName "Example" -email @("test@example.com") -mobile "+14155552671" -PassThru

id              : 123456
name            : Test Contact Group
email_addresses : {test@example.com}
mobile_numbers  : {}
integrations    : {}
```

### Copy-StatusCakeHelperContactGroup
The cmdlet copies a Status Cake ContactGroup. The cmdlet checks to see if a test with the same name already exists before a copy is created and returns the ID of the copy.

```powershell
Copy-StatusCakeHelperContactGroup -Name "Example" -NewName "Example - Copy"
234567
```

### Remove-StatusCakeHelperContactGroup
This cmdlet removes a contact group.

```powershell
Remove-StatusCakeHelperContactGroup -ID "123456"
```
A Contact Group can be removed by group name using the GroupName parameter.
```powershell
Remove-StatusCakeHelperContactGroup -Name "Example"
```

### Update-StatusCakeHelperContactGroup
This cmdlet sets the configuration of a contact group to the specified values.

```powershell
Set-StatusCakeHelperContactGroup -ContactID "123456" -Email @("test8@example.com")
```
A Contact Group can be updated by group name if there are no duplicates as follows:
```powershell
Set-StatusCakeHelperContactGroup -GroupName "Example" -Email @("test4@example.com") -SetByGroupName
```

# Authors
- Oliver Li