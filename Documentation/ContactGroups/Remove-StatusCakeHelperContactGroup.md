# Remove-StatusCakeHelperContactGroup

## SYNOPSIS
Removes the specified StatusCake contact group

## SYNTAX

### ContactID
```
Remove-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [-ID <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### GroupName
```
Remove-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [-Name <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Removes the StatusCake contact group via its ID or Name.

## EXAMPLES

### EXAMPLE 1
```
Remove-StatusCakeHelperContactGroup -ContactID 123456
```

Remove contact group with ID 123456

## PARAMETERS

### -APICredential
Username and APIKey Credentials to access StatusCake API

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
ID of the contact group to be removed

```yaml
Type: Int32
Parameter Sets: ContactID
Aliases: group_id, GroupID, ContactID

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the Contact Group to be removed

```yaml
Type: String
Parameter Sets: GroupName
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

### Returns the result of the contact group removal as an object
## NOTES

## RELATED LINKS

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Remove-StatusCakeHelperContactGroup.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Remove-StatusCakeHelperContactGroup.md)

[https://www.statuscake.com/api/v1/#tag/contact-groups/operation/delete-contact-group](https://www.statuscake.com/api/v1/#tag/contact-groups/operation/delete-contact-group)

