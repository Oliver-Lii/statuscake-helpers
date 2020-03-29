# Get-StatusCakeHelperPageSpeedTestHistory

## SYNOPSIS
Gets the history of a StatusCake PageSpeed Test

## SYNTAX

### name
```
Get-StatusCakeHelperPageSpeedTestHistory [-APICredential <PSCredential>] [-Name <String>] [-Days <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ID
```
Get-StatusCakeHelperPageSpeedTestHistory [-APICredential <PSCredential>] [-ID <Int32>] [-Days <Int32>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
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
Get-StatusCakeHelperPageSpeedTestHistory -ID 123456 -Days 14
```

Retrieve 14 days page speed test history for page speed test with id 123456

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

### -Days
Amount of days to look up

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

### Returns a StatusCake PageSpeed Tests History as an object
## NOTES

## RELATED LINKS
