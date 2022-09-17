# Locations

The following are examples for the functions which work against the StatusCake Locations API

### Get-StatusCakeHelperLocation
This cmdlet returns all StatusCake uptime locations by default.

```powershell
Get-StatusCakeHelperLocation

description : Australia, Sydney - 1
region      : Australia / Sydney
region_code : sydney
status      : up
ipv4        : 45.76.123.211
```

Specify the type as "PageSpeed-Locations" to retrieve all the locations page speed tests are run from.

```powershell
Get-StatusCakeHelperLocation -Type "PageSpeed-Locations"

description : Australia, Sydney - 1
region      : Australia / Sydney
region_code : sydney
status      : up
ipv4        : 45.76.123.211
```

Thes best argument can used to retrieve all the locations which have the fewest number of tests.

```powershell
Get-StatusCakeHelperLocation -Best $true

description : Australia, Sydney - 1
region      : Australia / Sydney
region_code : sydney
status      : up
ipv4        : 45.76.123.211
```

# Authors
- Oliver Li