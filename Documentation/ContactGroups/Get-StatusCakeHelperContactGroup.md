# Get-StatusCakeHelperContactGroup

## SYNOPSIS
Retrieves a StatusCake Contact Group with a specific name or Test ID

## SYNTAX

### all (Default)
```
Get-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [<CommonParameters>]
```

### Group Name
```
Get-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [-Name <String>] [<CommonParameters>]
```

### Contact ID
```
Get-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [-ID <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves a StatusCake contact group via the name or ID.
If no name or id supplied all contact groups will be returned.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperContactGroup
```

Retrieve all contact groups

### EXAMPLE 2
```
Get-StatusCakeHelperContactGroup -ContactID 123456
```

Retrieve contact group with ID 123456

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

### -Name
Name of the Contact Group

```yaml
Type: String
Parameter Sets: Group Name
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
ID of the Contact Group to be retrieved

```yaml
Type: Int32
Parameter Sets: Contact ID
Aliases: GroupID, ContactID

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Returns the contact group(s)
###     id              : 123456
###     name            : Test Contact Group
###     email_addresses : {test@example.com}
###     mobile_numbers  : {}
###     integrations    : {}
## NOTES

## RELATED LINKS

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Get-StatusCakeHelperContactGroup.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Get-StatusCakeHelperContactGroup.md)

[https://www.statuscake.com/api/v1/#tag/contact-groups/operation/list-contact-groups](https://www.statuscake.com/api/v1/#tag/contact-groups/operation/list-contact-groups)

[https://www.statuscake.com/api/v1/#tag/contact-groups/operation/get-contact-group](https://www.statuscake.com/api/v1/#tag/contact-groups/operation/get-contact-group)

