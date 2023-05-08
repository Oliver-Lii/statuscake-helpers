# Get-StatusCakeHelperUptimeAlert

## SYNOPSIS
Returns a list of uptime check alerts for a test

## SYNTAX

### name
```
Get-StatusCakeHelperUptimeAlert [-APICredential <PSCredential>] [-Name <String>] [-Before <DateTime>]
 [-After <DateTime>] [-Limit <Int32>] [<CommonParameters>]
```

### ID
```
Get-StatusCakeHelperUptimeAlert [-APICredential <PSCredential>] [-ID <Int32>] [-Before <DateTime>]
 [-After <DateTime>] [-Limit <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns all alerts that have been triggered for a test by its name or id.
The return order is newest alerts are shown first.
Alerts to be returned can be filtered by date using the After/Before parameters.
The number of alerts returned can be controlled
using the Limit argument.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperUptimeAlert -ID 123456 -Before "2017-08-19 13:29:49"
```

Return all the alerts triggered for test ID 123456 since the 19th August 2017 13:29:49

### EXAMPLE 2
```
Get-StatusCakeHelperUptimeAlert -ID 123456 -After "2018-01-01 00:00:00" -Before "2019-01-01 00:00:00"
```

Return all the alerts triggered for test ID 123456 after the 1st January 2018 but before 1st January 2019

### EXAMPLE 3
```
Get-StatusCakeHelperUptimeAlert -ID 123456 -Limit 100
```

Return the last 100 alerts triggered for test ID 123456

### EXAMPLE 4
```
Get-StatusCakeHelperUptimeAlert -ID 123456 -Limit 1
```

Return the most recent alert triggered for test ID 123456

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

### -Name
Name of the Test to retrieve the triggered alerts for

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

### -ID
ID of the Test to retrieve the triggered alerts for

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

### -Before
Return only alerts triggered before this date

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
Return only alerts triggered after this date

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

### Returns an object with the details on the alerts triggered
## NOTES

## RELATED LINKS

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Uptime/Base/Get-StatusCakeHelperUptimeAlert.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Uptime/Base/Get-StatusCakeHelperUptimeAlert.md)

[https://www.statuscake.com/api/v1/#tag/uptime/operation/list-uptime-test-alerts](https://www.statuscake.com/api/v1/#tag/uptime/operation/list-uptime-test-alerts)

