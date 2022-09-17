# Remove-StatusCakeHelperPageSpeedTest

## SYNOPSIS
Remove a StatusCake PageSpeed Test

## SYNTAX

### ID
```
Remove-StatusCakeHelperPageSpeedTest [-APICredential <PSCredential>] [-ID <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Name
```
Remove-StatusCakeHelperPageSpeedTest [-APICredential <PSCredential>] [-Name <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Deletes a StatusCake PageSpeed Test using the supplied ID or name.

## EXAMPLES

### EXAMPLE 1
```
Remove-StatusCakeHelperPageSpeedTest -ID 123456
```

Remove page speed test with id 123456

### EXAMPLE 2
```
Remove-StatusCakeHelperPageSpeedTest -Name "Example PageSpeed Test"
```

Remove page speed test with name "Example PageSpeed Test"

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
ID of the PageSpeed Test to remove

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
Name for PageSpeed test

```yaml
Type: String
Parameter Sets: Name
Aliases:

Required: False
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

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/PageSpeed/Remove-StatusCakeHelperPageSpeedTest.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/PageSpeed/Remove-StatusCakeHelperPageSpeedTest.md)

[https://www.statuscake.com/api/v1/#tag/pagespeed/operation/delete-pagespeed-test](https://www.statuscake.com/api/v1/#tag/pagespeed/operation/delete-pagespeed-test)

