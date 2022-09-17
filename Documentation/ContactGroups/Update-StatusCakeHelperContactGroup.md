# Update-StatusCakeHelperContactGroup

## SYNOPSIS
Updates the configuration of a StatusCake ContactGroup

## SYNTAX

### ID
```
Update-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [-ID <Int32>] [-Email <String[]>]
 [-IntegrationID <Int32[]>] [-PingURL <String>] [-Mobile <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Name
```
Update-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [-Name <String>] [-Email <String[]>]
 [-IntegrationID <Int32[]>] [-PingURL <String>] [-Mobile <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a StatusCake ContactGroup using the supplied parameters.
Values supplied overwrite existing values.

## EXAMPLES

### EXAMPLE 1
```
Update-StatusCakeHelperContactGroup -Name "Example" -email @(test@example.com)
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
ID of the contact group to set

```yaml
Type: Int32
Parameter Sets: ID
Aliases: group_id, GroupID, ContactID

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the Contact Group to be created

```yaml
Type: String
Parameter Sets: Name
Aliases: GroupName

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Email
Array of email addresses to sent alerts to.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: email_addresses

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IntegrationID
List of integration IDs to link with this contact group

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: integrations

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PingURL
URL To Send a POST alert

```yaml
Type: String
Parameter Sets: (All)
Aliases: ping_url

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Mobile
Array of mobile number in International Format E.164 notation

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: mobile_numbers

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

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Update-StatusCakeHelperContactGroup.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/Update-StatusCakeHelperContactGroup.md)

[https://www.statuscake.com/api/v1/#tag/contact-groups/operation/update-contact-group](https://www.statuscake.com/api/v1/#tag/contact-groups/operation/update-contact-group)

