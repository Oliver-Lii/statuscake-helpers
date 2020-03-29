# Suspend-StatusCakeHelperTest

## SYNOPSIS
Pauses a StatusCake test check

## SYNTAX

### PauseById
```
Suspend-StatusCakeHelperTest [-APICredential <PSCredential>] -TestID <Int32> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### PauseByName
```
Suspend-StatusCakeHelperTest [-APICredential <PSCredential>] -TestName <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Pauses a test.

## EXAMPLES

### EXAMPLE 1
```
Suspend-StatusCakeHelperTest -TestName "Example"
```

Pauses the test called "Example"

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
ID of the Test to be removed from StatusCake

```yaml
Type: Int32
Parameter Sets: PauseById
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestName
Name of the Test to be removed from StatusCake

```yaml
Type: String
Parameter Sets: PauseByName
Aliases:

Required: True
Position: Named
Default value: None
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

## NOTES

## RELATED LINKS
