# Copy-StatusCakeHelperContactGroup

## SYNOPSIS
Copies the settings of a StatusCake ContactGroup

## SYNTAX

### CopyById
```
Copy-StatusCakeHelperContactGroup [-APICredential <PSCredential>] -ContactID <Int32> -NewGroupName <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CopyByName
```
Copy-StatusCakeHelperContactGroup [-APICredential <PSCredential>] -GroupName <String> -NewGroupName <String>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a copy of a contact group which can be specified by name or id.
The new name of the contact group must not already exist for the command to be successful

## EXAMPLES

### EXAMPLE 1
```
Copy-StatusCakeHelperContactGroup -GroupName "Example" -NewGroupName "Example - Copy"
```

Create a copy of a contact group called "Example" with name "Example - Copy"

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

### -ContactID
ID of the Contact Group to be copied

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

### -GroupName
Name of the Contact Group to be copied

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

### -NewGroupName
Name of the Contact Group copy

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

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Copy-StatusCakeHelperContactGroup.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Copy-StatusCakeHelperContactGroup.md)

