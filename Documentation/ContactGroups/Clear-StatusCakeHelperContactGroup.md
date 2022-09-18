# Clear-StatusCakeHelperContactGroup

## SYNOPSIS
Clears a property of a StatusCake contact group

## SYNTAX

### ByID
```
Clear-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [-ID <Int32>] [-Email] [-PingURL] [-Mobile]
 [-Integration] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByName
```
Clear-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [-Name <String>] [-Email] [-PingURL]
 [-Mobile] [-Integration] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Clears the property of a StatusCake contact group using the supplied parameters.

## EXAMPLES

### EXAMPLE 1
```
Clear-StatusCakeHelperContactGroup -Name "Example" -email
```

Set the contact group name "Example" with email address "test@example.com"

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
ID of the contact group to clear the property on

```yaml
Type: Int32
Parameter Sets: ByID
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the Contact Group on which to clear the property

```yaml
Type: String
Parameter Sets: ByName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Email
Flag to clear all email addresses from contact group

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: email_addresses

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PingURL
Flag to clear ping URL from contact group

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

### -Mobile
Flag to clear all mobile numbers from contact group

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: mobile_numbers

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Integration
Flag to clear all integration IDs from contact group

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: integrations

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

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Clear-StatusCakeHelperContactGroup.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Clear-StatusCakeHelperContactGroup.md)

