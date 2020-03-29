# Get-StatusCakeHelperPeriodOfData

## SYNOPSIS
Retrieves a list of each period of data.

## SYNTAX

### Test ID
```
Get-StatusCakeHelperPeriodOfData [-APICredential <PSCredential>] [-TestID <Int32>] [-Additional] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Test Name
```
Get-StatusCakeHelperPeriodOfData [-APICredential <PSCredential>] [-TestName <String>] [-Additional] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Retrieves a list of each period of data.
A period of data is two time stamps in which status has remained the same, such as a period of downtime or uptime.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperPeriodOfData -TestID 123456
```

Retrieve period of data for uptime test 123456

### EXAMPLE 2
```
Get-StatusCakeHelperPeriodOfData -TestID 123456 -Additional
```

Retrieve period of data for uptime test 123456 including information about the downtime.

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
ID of the Test to retrieve the period of data for

```yaml
Type: Int32
Parameter Sets: Test ID
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestName
Name of the Test to retrieve the period of data for

```yaml
Type: String
Parameter Sets: Test Name
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Additional
Flag to set to return information about the downtime.
NOTE: This will slow down the query considerably.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

### Returns an object with the details the periods of data
## NOTES

## RELATED LINKS
