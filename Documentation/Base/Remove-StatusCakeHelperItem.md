# Remove-StatusCakeHelperItem

## SYNOPSIS
Remove a StatusCake Contact Group, Maintenance Window, PageSpeed, SSL or Uptime item

## SYNTAX

```
Remove-StatusCakeHelperItem [-APICredential <PSCredential>] [-ID <Int32>] -Type <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Remove a StatusCake Contact Group, Maintenance Window, PageSpeed, SSL or Uptime item

## EXAMPLES

### EXAMPLE 1
```
Remove-StatusCakeHelperItem -Type "PageSpeed" -Name "Example Page Speed Test"
```

Remove a pagespeed test with name "Example Page Speed Test"

### EXAMPLE 2
```
Remove-StatusCakeHelperItem -Type "SSL" -ID 1234
```

Remove a ssl speed test with ID 1234

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
ID of the test

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

### -Type
Type of test to remove

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
