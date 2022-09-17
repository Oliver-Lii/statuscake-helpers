# Remove-StatusCakeHelperSSLTest

## SYNOPSIS
Remove a StatusCake SSL Test

## SYNTAX

### ID
```
Remove-StatusCakeHelperSSLTest [-APICredential <PSCredential>] [-ID <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Domain
```
Remove-StatusCakeHelperSSLTest [-APICredential <PSCredential>] [-WebsiteURL <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Deletes a StatusCake SSL Test using the supplied ID.

## EXAMPLES

### EXAMPLE 1
```
Remove-StatusCakeHelperSSLTest -ID 123456
```

Remove the SSL Test with ID 123456

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
Test ID to delete

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

### -WebsiteURL
WebsiteURL SSL test to remove

```yaml
Type: String
Parameter Sets: Domain
Aliases: website_url, Domain

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

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/SSL/Remove-StatusCakeHelperSSLTest.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/SSL/Remove-StatusCakeHelperSSLTest.md)

[https://www.statuscake.com/api/v1/#tag/ssl/operation/delete-ssl-test](https://www.statuscake.com/api/v1/#tag/ssl/operation/delete-ssl-test)

