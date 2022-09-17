# Resume-StatusCakeHelperUptimeTest

## SYNOPSIS
Resumes a StatusCake test check

## SYNTAX

### ResumeById
```
Resume-StatusCakeHelperUptimeTest [-APICredential <PSCredential>] -ID <Int32> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ResumeByName
```
Resume-StatusCakeHelperUptimeTest [-APICredential <PSCredential>] -Name <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Resumes a test

## EXAMPLES

### EXAMPLE 1
```
Resume-StatusCakeHelperUptimeTest -Name "Example"
```

Unpause the test called "Example"

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
ID of the Test to be removed from StatusCake

```yaml
Type: Int32
Parameter Sets: ResumeById
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the Test to be removed from StatusCake

```yaml
Type: String
Parameter Sets: ResumeByName
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
