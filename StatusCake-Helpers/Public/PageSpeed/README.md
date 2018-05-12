# Page Speed

The following are examples for the functions which work against the StatusCake Page Speed API

### Get-StatusCakeHelperAllPageSpeedTests
This cmdlet retrieves all the page speed tests

```powershell
Get-StatusCakeHelperAllPageSpeedTests @StatusCakeAuth
```
![image](https://user-images.githubusercontent.com/30263630/32909663-0aadd942-caff-11e7-9b72-3a24ae6e426a.png)

### Get-StatusCakeHelperPageSpeedTest
This cmdlet retrieves a specific page speed test by name or id

```powershell
Get-StatusCakeHelperPageSpeedTest @StatusCakeAuth -id 123456
```
![image](https://user-images.githubusercontent.com/30263630/32909708-2290d6f4-caff-11e7-8470-42d591ed146e.png)


### Get-StatusCakeHelperPageSpeedTestHistory
This cmdlet retrieves the history of a page speed test by name or id

```powershell
Get-StatusCakeHelperPageSpeedTestHistory @StatusCakeAuth -id 123456
```
![image](https://user-images.githubusercontent.com/30263630/32909743-3b697f6e-caff-11e7-868a-6ea7c48cfe76.png)

### New-StatusCakeHelperPageSpeedTest
This cmdlet creates a new page speed test. The following are the minimum required parameters to create a test.

```powershell
New-StatusCakeHelperPageSpeedTest @StatusCakeAuth -Name "Example website" -website_url "https://www.example.com" -checkrate 30 -location_iso UK
```

### Copy-StatusCakeHelperPageSpeedTest
This cmdlet copies a page speed test. Supply the website_url parameter to override the source website URL

```powershell
Copy-StatusCakeHelperPageSpeedTest -Name "Example Website" -NewName "Example Website - Copy"
```

### Remove-StatusCakeHelperPageSpeedTest
This cmdlet retrieves the history of a page speed test by name or id

```powershell
Remove-StatusCakeHelperPageSpeedTest @StatusCakeAuth -ID 123456
```
To remove by name specify the name parameter
```powershell
Remove-StatusCakeHelperSSLTest @StatusCakeAuth -Name "Example Website"
```

### Set-StatusCakeHelperPageSpeedTest
This cmdlet sets the configuration of a specific PageSpeed Test. If a id or a name with setByName flag set is not supplied then a new test will be created

```powershell
Set-StatusCakeHelperPageSpeedTest @StatusCakeAuth -ID 123456
```
A PageSpeed Test can be updated by name if there are no duplicates as follows:
```powershell
Set-StatusCakeHelperPageSpeedTest @StatusCakeAuth -ID 123456 -SetByName -name "Example website" -website_url "https://www.example.com" -location_iso UK -checkrate 60 -Verbose 
```
A new PageSpeed Test can be created via the cmdlet with the following parameters:
```powershell
Set-StatusCakeHelperPageSpeedTest @StatusCakeAuth -ID 123456 -Name "Example website" -website_url "https://www.example.com" -checkrate 30 -location_iso UK
```

# Authors
- Oliver Li