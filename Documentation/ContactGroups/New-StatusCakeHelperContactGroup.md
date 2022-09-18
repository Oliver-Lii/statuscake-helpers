# New-StatusCakeHelperContactGroup

## SYNOPSIS
Create a StatusCake ContactGroup

## SYNTAX

```
New-StatusCakeHelperContactGroup [-APICredential <PSCredential>] -Name <String> [-Email <String[]>]
 [-IntegrationID <Int32[]>] [-PingURL <String>] [-Mobile <String[]>] [-Force] [-PassThru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a new StatusCake ContactGroup using the supplied parameters.
The name of the contact group must be unique for the contact group to be created.

## EXAMPLES

### EXAMPLE 1
```
New-StatusCakeHelperContactGroup -GroupName "Example" -email @(test@example.com)
```

Create contact group called "Example" using email address "test@example.com"

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
Name of the Contact Group to be created

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
URL or IP address of an endpoint to push uptime events.
Currently this only supports HTTP GET endpoints

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
Array of mobile numbers in International Format E.164 notation

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

### -Force
Force creation of the contact group even if a window with the same name already exists

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
Return the contact group details instead of the contact id

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

## NOTES

## RELATED LINKS

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/New-StatusCakeHelperContactGroup.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/ContactGroups/New-StatusCakeHelperContactGroup.md)

[https://www.statuscake.com/api/v1/#tag/contact-groups/operation/create-contact-group](https://www.statuscake.com/api/v1/#tag/contact-groups/operation/create-contact-group)

