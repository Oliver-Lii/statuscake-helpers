# Get-StatusCakeHelperPerformanceData

## SYNOPSIS
Retrieves the tests that have been carried out on a given check

## SYNTAX

```
Get-StatusCakeHelperPerformanceData [-APICredential <PSCredential>] [-TestID <Int32>] [-TestName <String>]
 [-Start <DateTime>] [-Fields <String[]>] [-Limit <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Retrieves the performance details of a test that have been carried out for a uptime test.
At any one time this will return a days worth of results and you are able to cycle through each of the results using the start parameter.
The latest tests are shown first.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperPerformanceData -TestID 123456 -Start "2018-01-07 10:14:00"
```

Retrieve test performance data for test id 123456 from the 7th January 2018 10:14:00

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

### -TestID
ID of the Test to retrieve the performance data for

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

### -TestName
Name of the Test to retrieve the performance data for

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Start
Supply to include results only since the specified date

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

### -Fields
Array of additional fields, these additional fields will give you more data about each check

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: @("status","location","human","time","headers","performance")
Accept pipeline input: False
Accept wildcard characters: False
```

### -Limit
Limits to a subset of results - maximum of 1000

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Returns an object with the details on the tests that have been carried out on a given check
## NOTES

## RELATED LINKS
