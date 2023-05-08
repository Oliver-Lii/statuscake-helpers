# Get-StatusCakeHelperUptimePeriod

## SYNOPSIS
Returns a list of uptime check periods for a uptime test

## SYNTAX

### ID
```
Get-StatusCakeHelperUptimePeriod [-APICredential <PSCredential>] [-ID <Int32>] [-Before <DateTime>]
 [-After <DateTime>] [-Limit <Int32>] [<CommonParameters>]
```

### name
```
Get-StatusCakeHelperUptimePeriod [-APICredential <PSCredential>] [-Name <String>] [-Before <DateTime>]
 [-After <DateTime>] [-Limit <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns a list of uptime check periods for a given id or name, detailing the creation time of the period, when it ended and the duration.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperUptimePeriod -TestID 123456 -Before "2017-08-19 13:29:49"
```

Return all the alerts sent for test ID 123456 since the 19th August 2017 13:29:49

### EXAMPLE 2
```
Get-StatusCakeHelperUptimePeriod -ID 123456 -After "2018-01-01 00:00:00" -Before "2019-01-01 00:00:00"
```

Return all the uptime check periods for test ID 123456 created after the 1st January 2018 but before 1st January 2019

### EXAMPLE 3
```
Get-StatusCakeHelperUptimePeriod -ID 123456 -Limit 100
```

Return the last 100 uptime check periods sent for test ID 123456

### EXAMPLE 4
```
Get-StatusCakeHelperUptimePeriod -ID 123456 -Limit 1
```

Return the most recent uptime check period sent for test ID 123456

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

### -ID
ID of the Test to retrieve the uptime check periods for

```yaml
Type: Int32
Parameter Sets: ID
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the Test to retrieve the uptime check periods for

```yaml
Type: String
Parameter Sets: name
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Before
Return only check periods created before this date

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -After
Return only check periods created after this date

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Limit
The maximum of number of results to return

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Returns an object with the details of the uptime check periods
## NOTES

## RELATED LINKS

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Uptime/Property/Get-StatusCakeHelperUptimePeriod.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Uptime/Property/Get-StatusCakeHelperUptimePeriod.md)

[https://www.statuscake.com/api/v1/#tag/uptime/operation/list-uptime-test-periods](https://www.statuscake.com/api/v1/#tag/uptime/operation/list-uptime-test-periods)

