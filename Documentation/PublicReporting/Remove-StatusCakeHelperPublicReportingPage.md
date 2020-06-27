# Remove-StatusCakeHelperPublicReportingPage

## SYNOPSIS
Remove a StatusCake Public Reporting Page

## SYNTAX

### ID
```
Remove-StatusCakeHelperPublicReportingPage [-APICredential <PSCredential>] [-ID <String>] [-PassThru] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Title
```
Remove-StatusCakeHelperPublicReportingPage [-APICredential <PSCredential>] [-Title <String>] [-PassThru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a StatusCake Public Reporting page using the supplied ID.

## EXAMPLES

### EXAMPLE 1
```
Remove-StatusCakeHelperPublicReportingPage -ID a1B2c3D4e5
```

Delete the public reporting page with ID a1B2c3D4e5

### EXAMPLE 2
```
Remove-StatusCakeHelperPublicReportingPage -Title "Example.com Public Reporting Page"
```

Delete the public reporting page called "Example.com Public Reporting Page"

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
ID of the public reporting page

```yaml
Type: String
Parameter Sets: ID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Title of the public reporting page

```yaml
Type: String
Parameter Sets: Title
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Return the object to be deleted

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
