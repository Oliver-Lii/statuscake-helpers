# Tests

The following are examples for the functions which work against the StatusCake Tests API

### Get-StatusCakeHelperAllTests
The cmdlet retrieves all the tests that the user has permission for.

```powershell
Get-StatusCakeHelperAllTests @StatusCakeAuth
```
![get-statuscakehelperalltests](https://user-images.githubusercontent.com/30263630/29495718-ad4af0d2-85bc-11e7-92c4-320f2c9bebca.PNG)

### Get-StatusCakeHelperDetailedTestData
The cmdlet retrieves detailed test data for a specific test via the Test Name or Test ID

```powershell
Get-StatusCakeHelperDetailedTestData @StatusCakeAuth -TestName "Yahoo DNS"
```
![get-statuscakehelperdetailedtestdata](https://user-images.githubusercontent.com/30263630/29495774-d094e24a-85bd-11e7-8ff4-0a7e263e8cd3.PNG)

### Get-StatusCakeHelperTest
The cmdlet retrieves basic test data for a specific test via the Test Name or Test ID

```powershell
Get-StatusCakeHelperTest @StatusCakeAuth -TestName "Yahoo DNS"
```
![get-statuscakehelpertest](https://user-images.githubusercontent.com/30263630/29495889-fe88432a-85bf-11e7-8ea5-08cc99fc5883.PNG)

### Get-StatusCakeHelperPausedTests
This cmdlet retrieves all tests paused longer than the specified time. If no additional parameters specified it returns all tests paused longer than 1 day. 
Granularity of time can specified down to the minute. This function will be slow if there are large numbers of paused tests as detailed test data has to be
retrieved for each paused test to determine the length of time it has been paused.

```powershell
Get-StatusCakeHelperPausedTests @StatusCakeAuth
```

### Remove-StatusCakeHelperTest
The cmdlet removes a specific test via the Test Name or Test ID. No output is return unless the PassThru switch is supplied or an error encountered

```powershell
Remove-StatusCakeHelperTest @StatusCakeAuth -TestName "Yahoo DNS" -PassThru
```
![remove-statuscakehelpertest](https://user-images.githubusercontent.com/30263630/29495953-c29d1d1c-85c0-11e7-941e-fb100c060ae9.PNG)

### Set-StatusCakeHelperTest
The cmdlet sets a specific test configuration via the Test ID. The example illustrated below pauses the specified check. Any values supplied overwrites existing configuration.

```powershell
Set-StatusCakeHelperTest @StatusCakeAuth -TestID "2425217" -Paused 1
```
![set-statuscakehelpertest](https://user-images.githubusercontent.com/30263630/29495985-4b5557be-85c1-11e7-81db-1cf63c95af06.PNG)

### New-StatusCakeHelperTest
The cmdlet creates a new Status Cake Test. Parameters shown below are the minimum parameters to create a test. The cmdlet checks to see if a test with the same name already exists before the test is created.

```powershell
New-StatusCakeHelperTest @StatusCakeAuth -TestName "Example" -TestURL "https://www.example.com" -CheckRate 300 -TestType HTTP
```
![new-statuscakehelpertest](https://user-images.githubusercontent.com/30263630/29495757-4adfce26-85bd-11e7-8a68-1f8253a91068.PNG)

### Add-StatusCakeHelperTestNodeLocations
This cmdlet add a Test Node location to a Status Cake Test. The cmdlet checks to see if a test node location is valid by verifying it against the list of server codes retrieved from the StatusCake API before adding it to the test.

```powershell
Add-StatusCakeHelperTestNodeLocations @StatusCakeAuth -TestID "123456" -NodeLocations @("EU1","EU2")
```

### Add-StatusCakeHelperTestStatusCodes
This cmdlet add a HTTP Status code to a Status Cake Test. The cmdlet checks to see if a HTTP Status Code is valid before adding it to the test.

```powershell
Add-StatusCakeHelperTestStatusCodes @StatusCakeAuth -TestID "123456" -StatusCodes @("206","207")
```

### Add-StatusCakeHelperTestTags
This cmdlet adds an additional tag to a Status Cake Test.

```powershell
Add-StatusCakeHelperTestTags @StatusCakeAuth -TestID "123456" -TestTags @("Tag1","Tag2")
```

### Remove-StatusCakeHelperTestNodeLocations
This cmdlet removes a Test Node location from a Status Cake Test. The cmdlet checks to see if a test node location is valid by verifying it against the list of server codes retrieved from the StatusCake API before removing it from the test.

```powershell
Add-StatusCakeHelperTestNodeLocations @StatusCakeAuth -TestID "123456" -NodeLocations @("EU1","EU2")
```

### Remove-StatusCakeHelperTestStatusCodes
This cmdlet removes a HTTP Status code from a Status Cake Test. The cmdlet checks to see if a HTTP Status Code is valid before removing it from the test.

```powershell
Remove-StatusCakeHelperTestStatusCodes @StatusCakeAuth -TestID "123456" -StatusCodes @("206","207")
```

### Remove-StatusCakeHelperTestTags
This cmdlet removes a tag from a Status Cake Test.

```powershell
Remove-StatusCakeHelperTestTags @StatusCakeAuth -TestID "123456" -TestTags @("Tag1","Tag2")
```


# Authors
- Oliver Li