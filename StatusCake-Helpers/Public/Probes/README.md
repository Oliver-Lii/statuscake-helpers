# Probes

The following are examples for the functions which work against the StatusCake Get Locations XML API

### Get-StatusCakeHelperProbes
The cmdlet retrieves the details of the probes from the StatusCake API. City and Country information is extracted from the Probe Title and added as separate properties. The probe data is returned sorted by Title.

```powershell
Get-StatusCakeHelperProbes
```
![get-statuscakehelperprobes](https://user-images.githubusercontent.com/30263630/29495809-890e0d42-85be-11e7-8acf-3af7eeeac98a.PNG)

### Get-StatusCakeHelperRegionProbes
The cmdlet retrieves the probes nearest to a specific AWS Region

```powershell
Get-StatusCakeHelperRegionProbes -AWSRegion "eu-west-1"
```
![get-statuscakehelperregionprobes](https://user-images.githubusercontent.com/30263630/29495858-922a5d3a-85bf-11e7-9526-d14a66eb8ee5.png)

# Authors
- Oliver Li