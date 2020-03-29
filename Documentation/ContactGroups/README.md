# Contact Groups

The following are examples for the functions which work against the StatusCake Contact Groups API

### Get-StatusCakeHelperContactGroup
This cmdlet returns all contact groups unless a group name or contact ID is specified.

```powershell
Get-StatusCakeHelperContactGroup -ContactID "123456"

GroupName    : Contact Group
Emails       : {}
Mobiles      :
Boxcar       :
Pushover     :
ContactID    : 123456
DesktopAlert :
PingURL      :
```

### New-StatusCakeHelperContactGroup
This cmdlet creates a new contact group. If a mobile number is supplied this is validated to confirm that it meets E.164 number formatting.

```powershell
New-StatusCakeHelperContactGroup -GroupName "Example" -email @("test@example.com") -mobile "+14155552671"

GroupName    : Example
Emails       : {test@example.com}
Mobiles      : {+14155552671}
Boxcar       :
Pushover     :
ContactID    : 123456
DesktopAlert :
PingURL      :
```


### Copy-StatusCakeHelperContactGroup
The cmdlet copies a Status Cake ContactGroup. The cmdlet checks to see if a test with the same name already exists before a copy is created.

```powershell
Copy-StatusCakeHelperContactGroup -GroupName "Example" -NewGroupName "Example - Copy"
GroupName    : Example - Copy
Emails       : {test@example.com}
Mobiles      : {+14155552671}
Boxcar       :
Pushover     :
ContactID    : 123456
DesktopAlert :
PingURL      :
```

### Remove-StatusCakeHelperContactGroup
This cmdlet removes a contact group. If the contact group is in use by any tests then the -force switch must be supplied to remove the contact group.

```powershell
Remove-StatusCakeHelperContactGroup -ContactID "123456"
```
A Contact Group can be removed by group name using the GroupName parameter. Specify the -PassThru flag if you want the details of the removed object returned.
```powershell
Remove-StatusCakeHelperContactGroup -GroupName "Example" -PassThru
GroupName    : Example
Emails       : {test@example.com}
Mobiles      : {+14155552671}
Boxcar       :
Pushover     :
ContactID    : 123456
DesktopAlert :
PingURL      :
```

### Set-StatusCakeHelperContactGroup
This cmdlet sets the configuration of a contact group to the specified values. If a contactID is not supplied then a new contact will be created

```powershell
Set-StatusCakeHelperContactGroup -ContactID "123456" -Email @("test8@example.com")
GroupName    : Example
Emails       : {test8@example.com}
Mobiles      : {+14155552671}
Boxcar       :
Pushover     :
ContactID    : 123456
DesktopAlert :
PingURL      :
```
A Contact Group can be updated by group name if there are no duplicates as follows:
```powershell
Set-StatusCakeHelperContactGroup -GroupName "Example" -Email @("test4@example.com") -SetByGroupName
GroupName    : Example
Emails       : {test4@example.com}
Mobiles      : {+14155552671}
Boxcar       :
Pushover     :
ContactID    : 123456
DesktopAlert :
PingURL      :
```

# Authors
- Oliver Li