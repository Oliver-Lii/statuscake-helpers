# Remove-StatusCakeHelperAPIAuth

## SYNOPSIS
Removes the StatusCake Authentication Username and API Key

## SYNTAX

```
Remove-StatusCakeHelperAPIAuth [-Session] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes the StatusCake Authentication Username and API Key credential file used by the module.
If session switch is used this will remove the credentials added for the session.

## EXAMPLES

### EXAMPLE 1
```
Remove-StatusCakeHelperAPIAuth
```

Remove the StatusCake Authentication credential file

### EXAMPLE 2
```
Remove-StatusCakeHelperAPIAuth -Session
```

Remove the StatusCake Authentication credential configured for the session

## PARAMETERS

### -Session
Switch to remove credentials configured for the session

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

### Returns a Boolean value on whether authentication removal operation was successful
## NOTES

## RELATED LINKS
