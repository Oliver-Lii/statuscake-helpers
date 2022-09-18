# Copy-StatusCakeHelperSSLTest

## SYNOPSIS
Copies the settings of a StatusCake SSL Test

## SYNTAX

### CopyById
```
Copy-StatusCakeHelperSSLTest [-APICredential <PSCredential>] -ID <Int32> -NewWebsiteURL <String> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### CopyByName
```
Copy-StatusCakeHelperSSLTest [-APICredential <PSCredential>] -WebsiteURL <String> -NewWebsiteURL <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a copy of a SSL Test.

## EXAMPLES

### EXAMPLE 1
```
Copy-StatusCakeHelperSSLTest -WebsiteURL "https://www.example.com" -NewWebsiteURL "https://www.example.org"
```

Create a copy of the SSL test with URL "https://www.example.com" for URL "https://www.example.org"

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
ID of the SSL Test to be copied

```yaml
Type: Int32
Parameter Sets: CopyById
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -WebsiteURL
Website URL of the SSL Test to be copied

```yaml
Type: String
Parameter Sets: CopyByName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewWebsiteURL
Website URL of the new SSL Test

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

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/SSL/Copy-StatusCakeHelperSSLTest.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/SSL/Copy-StatusCakeHelperSSLTest.md)

