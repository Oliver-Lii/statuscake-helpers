# Contact Groups

The following are examples for the functions which work against the StatusCake Contact Groups API

### Get-StatusCakeHelperAllContactGroups
This cmdlet retrieves all contact groups.

```powershell
Get-StatusCakeHelperAllContactGroups @StatusCakeAuth
```
![image](https://user-images.githubusercontent.com/30263630/32748088-07d72942-c8b3-11e7-97b1-01481830ba97.png)

### Get-StatusCakeHelperContactGroup
This cmdlet retrieves a specific contact group.

```powershell
Get-StatusCakeHelperContactGroup @StatusCakeAuth -ContactID "81384"
```
![image](https://user-images.githubusercontent.com/30263630/32747914-5457be2c-c8b2-11e7-83ab-2fa46becd733.png)

### New-StatusCakeHelperContactGroup
This cmdlet creates a new contact group. If a mobile number is supplied this is validated to confirm that it meets E.164 number formatting.

```powershell
New-StatusCakeHelperContactGroup @StatusCakeAuth -GroupName "Example" -email @("test@example.com") -mobile "+14155552671"
```
![image](https://user-images.githubusercontent.com/30263630/32748186-61bda10c-c8b3-11e7-9dc3-e88d01548db0.png)

### Copy-StatusCakeHelperContactGroup
The cmdlet copies a Status Cake ContactGroup. The cmdlet checks to see if a test with the same name already exists before a copy is created.

```powershell
Copy-StatusCakeHelperContactGroup @StatusCakeAuth -GroupName "Example" -NewGroupName "Example - Copy" 
```

### Remove-StatusCakeHelperContactGroup
This cmdlet removes a contact group. If the contact group is in use by any tests then the -force switch must be supplied to remove the contact group.

```powershell
Remove-StatusCakeHelperContactGroup @StatusCakeAuth -ContactID "123456"
```
A Contact Group can be removed by group name using the GroupName parameter. Specify the -PassThru flag if you want the details of a successful removed returned.
```powershell
Remove-StatusCakeHelperContactGroup @StatusCakeAuth -GroupName "Example.com" -verbose -PassThru
```
![image](https://user-images.githubusercontent.com/30263630/32748337-e72bb5b8-c8b3-11e7-966e-47bfd168c3d8.png)

### Set-StatusCakeHelperContactGroup
This cmdlet sets the configuration of a contact group to the specified values. If a contactID is not supplied then a new contact will be created

```powershell
Set-StatusCakeHelperContactGroup @StatusCakeAuth -ContactID "123456" -Email @("test8@example.com")
```
A Contact Group can be updated by group name if there are no duplicates as follows:
```powershell
Set-StatusCakeHelperContactGroup @StatusCakeAuth -GroupName "API Test Contact Group" -Email @("test4@example.com") -verbose -SetByGroupName
```
![image](https://user-images.githubusercontent.com/30263630/32748562-8a457c84-c8b4-11e7-9990-bda7e519c70e.png)

# Authors
- Oliver Li