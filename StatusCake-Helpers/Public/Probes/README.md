# Probes

The following are examples for the functions which work against the StatusCake Get Locations XML API

### Get-StatusCakeHelperProbe
The cmdlet retrieves the details of the probes from the StatusCake API. City and Country information is extracted from the Probe Title and added as separate properties. The probe data is returned sorted by Title.

```powershell
Get-StatusCakeHelperProbe
Title      : United States, Texas - 4
GUID       : Location_94
ip         : 144.168.43.155/32
servercode : WADA3
Country    : United States
CountryISO : USA
City       : Texas
Status     : Up
```

### Get-StatusCakeHelperRegionProbe
The cmdlet retrieves the probes nearest to a specific AWS Region

```powershell
Get-StatusCakeHelperRegionProbe -AWSRegion "eu-west-1"
Title      : Ireland, Dublin - 2
GUID       : Location_325
ip         : 217.78.0.171/32
servercode : DUB2
Country    : Ireland
CountryISO : IRL
City       : Dublin
Status     : Up
```

# Authors
- Oliver Li