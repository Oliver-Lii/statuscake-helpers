# Get-StatusCakeHelperPageSpeedTestHistory

## SYNOPSIS
Gets the history of a StatusCake PageSpeed Test

## SYNTAX

### ID
```
Get-StatusCakeHelperPageSpeedTestHistory [-APICredential <PSCredential>] [-ID <Int32>] [-Before <DateTime>]
 [-Limit <Int32>] [<CommonParameters>]
```

### name
```
Get-StatusCakeHelperPageSpeedTestHistory [-APICredential <PSCredential>] [-Name <String>] [-Before <DateTime>]
 [-Limit <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves the history for a StatusCake PageSpeed Test.
Use the Days parameter to specify the number of days which should be retrieved.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperPageSpeedTestHistory -ID 123456
```

Retrieve the page speed test history for page speed test with id 123456

### EXAMPLE 2
```
Get-StatusCakeHelperPageSpeedTestHistory -ID 123456 -Before 2022-01-01
```

Retrieve all page speed test history before the 1st January 2022

### EXAMPLE 3
```
Get-StatusCakeHelperPageSpeedTestHistory -ID 123456 -Limit 1
```

Retrieve the history of the most recent page speed test

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
ID of the PageSpeed Test

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
Name of the PageSpeed test

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

### Returns a StatusCake PageSpeed Tests History as an object
## NOTES

## RELATED LINKS

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/PageSpeed/Get-StatusCakeHelperPageSpeedTestHistory.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/PageSpeed/Get-StatusCakeHelperPageSpeedTestHistory.md)

[https://www.statuscake.com/api/v1/#tag/pagespeed/operation/list-pagespeed-test-history](https://www.statuscake.com/api/v1/#tag/pagespeed/operation/list-pagespeed-test-history)

