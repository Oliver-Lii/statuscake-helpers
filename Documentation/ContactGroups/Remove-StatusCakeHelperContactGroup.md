# Remove-StatusCakeHelperContactGroup

## SYNOPSIS
Removes the specified StatusCake ContactGroup

## SYNTAX

### ContactID
```
Remove-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [-ContactID <Int32>] [-Force] [-PassThru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### GroupName
```
Remove-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [-GroupName <String>] [-Force] [-PassThru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes the StatusCake ContactGroup via it's ContactID or GroupName.

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

### -ContactID
ID of the ContactGroup to be removed

```yaml
Type: Int32
Parameter Sets: ContactID
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupName
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

### -Force
Delete the contact group if it is in use

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

### Returns the result of the ContactGroup removal as an object
## NOTES

## RELATED LINKS

[https://www.statuscake.com/api/Contact%20Groups/Delete%20Contact%20Group.md](https://www.statuscake.com/api/Contact%20Groups/Delete%20Contact%20Group.md)

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Remove-StatusCakeHelperContactGroup.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Remove-StatusCakeHelperContactGroup.md)

