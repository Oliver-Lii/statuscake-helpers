# Get-StatusCakeHelperUptimeHistory

## SYNOPSIS
Returns uptime check history results for tests

## SYNTAX

### name
```
Get-StatusCakeHelperUptimeHistory [-APICredential <PSCredential>] [-Name <String>] [-Before <DateTime>]
 [-Limit <Int32>] [<CommonParameters>]
```

### ID
```
Get-StatusCakeHelperUptimeHistory [-APICredential <PSCredential>] [-ID <Int32>] [-Before <DateTime>]
 [-Limit <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Returns uptime check history results for tests detailing the runs performed on the StatusCake testing infrastructure.
The return order is newest alerts are shown first.
Alerts to be returned can be filtered by date using the Before parameter.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperUptimeHistory -ID 123456 -Before "2017-08-19 13:29:49"
```

Return all the uptime history for test ID 123456 since the 19th August 2017 13:29:49

### EXAMPLE 2
```
Get-StatusCakeHelperUptimeAlert -ID 123456 -Limit 100
```

Return the last 100 alerts sent for test ID 123456

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
Name of the Test to retrieve the sent alerts for

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
ID of the Test to retrieve the sent alerts for

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
Return only results from before this date

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

### Returns an object with the details on the Alerts Sent
## NOTES

## RELATED LINKS

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Uptime/Base/Get-StatusCakeHelperUptimeAlert.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Uptime/Base/Get-StatusCakeHelperUptimeAlert.md)

[https://www.statuscake.com/api/v1/#tag/uptime/operation/list-uptime-test-history](https://www.statuscake.com/api/v1/#tag/uptime/operation/list-uptime-test-history)

