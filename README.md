# StatusCake-Helpers 
This module was written to support interaction with the Statuscake API via Powershell. Additional functionality may be added later and I will use this as a generic module to house Powershell functions specific to interacting with the Statuscake API.



# Usage
This module can be installed from the PowerShell Gallery using the command below.
```
Install-Module StatusCake-Helpers -Repository PSGallery
```
## Get-StatusCakeHelperAllTests
The cmdlet retrieves all the tests that the user has permission for.

```
Get-StatusCakeHelperAllTests -Username "Username" -ApiKey "APIKEY"
```
![get-statuscakehelperalltests](https://user-images.githubusercontent.com/30263630/29495718-ad4af0d2-85bc-11e7-92c4-320f2c9bebca.PNG)

## Get-StatusCakeHelperDetailedTestData
The cmdlet retrieves detailed test data for a specific test via the Test Name or Test ID

```
Get-StatusCakeHelperDetailedTestData -Username "Username" -ApiKey "APIKEY" -TestName "Yahoo DNS"
```
![get-statuscakehelperdetailedtestdata](https://user-images.githubusercontent.com/30263630/29495774-d094e24a-85bd-11e7-8ff4-0a7e263e8cd3.PNG)

## Get-StatusCakeHelperProbes
The cmdlet retrieves the details of the probes from the StatusCake API. City and Country information is extracted from the Probe Title and added as separate properties. The probe data is returned sorted by Title.

```
Get-StatusCakeHelperProbes
```
![get-statuscakehelperprobes](https://user-images.githubusercontent.com/30263630/29495809-890e0d42-85be-11e7-8acf-3af7eeeac98a.PNG)

## Get-StatusCakeHelperRegionProbes
The cmdlet retrieves the probes nearest to a specific AWS Region

```
Get-StatusCakeHelperRegionProbes -AWSRegion "eu-west-1"
```
![get-statuscakehelperregionprobes](https://user-images.githubusercontent.com/30263630/29495858-922a5d3a-85bf-11e7-9526-d14a66eb8ee5.png)

## Get-StatusCakeHelperTest
The cmdlet retrieves basic test data for a specific test via the Test Name or Test ID

```
Get-StatusCakeHelperTest -Username "Username" -ApiKey "APIKEY" -TestName "Yahoo DNS"
```
![get-statuscakehelpertest](https://user-images.githubusercontent.com/30263630/29495889-fe88432a-85bf-11e7-8ea5-08cc99fc5883.PNG)

## Remove-StatusCakeHelperTest
The cmdlet removes a specific test via the Test Name or Test ID. No output is return unless the PassThru switch is supplied or an error encountered

```
Remove-StatusCakeHelperTest -Username "Username" -ApiKey "APIKEY" -TestName "Yahoo DNS" -PassThru
```
![remove-statuscakehelpertest](https://user-images.githubusercontent.com/30263630/29495953-c29d1d1c-85c0-11e7-941e-fb100c060ae9.PNG)

## Set-StatusCakeHelperTest
The cmdlet sets a specific test configuration via the Test ID. The example illustrated below pauses the specified check. Any values supplied overwrites existing configuration.

```
Set-StatusCakeHelperTest -Username "Username" -ApiKey "APIKEY" -TestID "2425217" -Paused 1
```
![set-statuscakehelpertest](https://user-images.githubusercontent.com/30263630/29495985-4b5557be-85c1-11e7-81db-1cf63c95af06.PNG)

## New-StatusCakeHelperTest
The cmdlet creates a new Status Cake Test. Parameters shown below are the minimum parameters to create a test. The cmdlet checks to see if a test with the same name already exists before the test is created.

```
New-StatusCakeHelperTest -Username "Username" -ApiKey "APIKEY" -TestName "Example" -TestURL "https://www.example.com" -CheckRate 300 -TestType HTTP
```
![new-statuscakehelpertest](https://user-images.githubusercontent.com/30263630/29495757-4adfce26-85bd-11e7-8a68-1f8253a91068.PNG)


# Authors
- Oliver Li
