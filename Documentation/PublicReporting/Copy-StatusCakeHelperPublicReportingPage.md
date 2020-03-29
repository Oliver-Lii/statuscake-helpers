# Copy-StatusCakeHelperPublicReportingPage

## SYNOPSIS
Copies the settings of a StatusCake Public Reporting Page

## SYNTAX

### CopyById
```
Copy-StatusCakeHelperPublicReportingPage [-APICredential <PSCredential>] -Id <String> -NewTitle <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CopyByTitle
```
Copy-StatusCakeHelperPublicReportingPage [-APICredential <PSCredential>] -Title <String> -NewTitle <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a copy of a Public Reporting Page.

## EXAMPLES

### EXAMPLE 1
```
Copy-StatusCakeHelperPublicReportingPage -Name "Example" -NewTitle "Example - Copy"
```

Creates a copy of a public reporting page called "Example" with name "Example - Copy"

### EXAMPLE 2
```
Copy-StatusCakeHelperPublicReportingPage -ID a1B2c3D4e5 -NewTitle "Example - Copy"
```

Creates a copy of a public reporting page with ID a1B2c3D4e5 with name "Example - Copy"

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

### -Id
ID of the Public Reporting Page to be copied

```yaml
Type: String
Parameter Sets: CopyById
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Name of the Public Reporting Page to be copied

```yaml
Type: String
Parameter Sets: CopyByTitle
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewTitle
Name of the new Public Reporting Page

```yaml
Type: String
Parameter Sets: (All)
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
