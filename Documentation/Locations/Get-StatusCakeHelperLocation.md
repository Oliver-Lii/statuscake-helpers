# Get-StatusCakeHelperLocation

## SYNOPSIS
Retrieve the details of the StatusCake locations from StatusCake

## SYNTAX

```
Get-StatusCakeHelperLocation [-APICredential <PSCredential>] [-RegionCode <String>] [-Type <String>]
 [-Best <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves details of StatusCake locations from StatusCake

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperLocation -Type Uptime-Locations
```

Retrieve all StatusCake uptime locations

### EXAMPLE 2
```
Get-StatusCakeHelperLocation -Type Uptime-Locations -Location GBR -Best
```

Retrieve all StatusCake uptime locations in Great Britian with the least number of checks

### EXAMPLE 3
```
Get-StatusCakeHelperLocation -Type PageSpeed-Locations
```

Retrieve all StatusCake pagespeed locations

## PARAMETERS

### -APICredential
Credentials to access StatusCake API

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-StatusCakeHelperAPIAuth)
Accept pipeline input: False
Accept wildcard characters: False
```

### -RegionCode
The StatusCake region code to return locations for.
All locations returned if no region code supplied.

```yaml
Type: String
Parameter Sets: (All)
Aliases: region_code

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
The type of test to retrieve locations for.
Options are Uptime or Pagespeed.
Default is Uptime

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Uptime-Locations
Accept pipeline input: False
Accept wildcard characters: False
```

### -Best
Return only locations with the least number of tests.
Default is false.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### StatusCakeLocations - Object containing details of StatusCake Locations
###    description : Australia, Sydney - 1
###    region      : Australia / Sydney
###    region_code : sydney
###    status      : up
###    ipv4        : 45.76.123.211
## NOTES

## RELATED LINKS

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Locations/Get-StatusCakeHelperLocation.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Locations/Get-StatusCakeHelperLocation.md)

[https://www.statuscake.com/api/v1/#tag/locations](https://www.statuscake.com/api/v1/#tag/locations)

