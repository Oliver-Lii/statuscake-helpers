# Set-StatusCakeHelperAPIAuth

## SYNOPSIS
Sets the StatusCake API Username and API Key

## SYNTAX

```
Set-StatusCakeHelperAPIAuth -Credential <PSCredential> [-Session] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the StatusCake API Username and API Key used by the module.
Credential file will be stored in the user's profile folder under .StatusCake-Helpers folder.
If the credential file already exists then the existing credential file will be overwritten otherwise a credential file will be created.
To avoid persisting credentials to disk the session switch can be used.

## EXAMPLES

### EXAMPLE 1
```
Set-StatusCakeHelperAPIAuth -Credential $StatusCakeAPICredential
```

Set the StatusCake Authentication credential file

### EXAMPLE 2
```
Set-StatusCakeHelperAPIAuth -Credential $StatusCakeAPICredential -Session
```

Set the StatusCake Authentication credential for the session

## PARAMETERS

### -Credential
Credential object containing the username and API Key

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: Credentials

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Session
Switch to configure the credential for the session only and avoid writing them to disk

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

### Credential - Credential object containing the username and API Key
## OUTPUTS

### Returns a Boolean value on whether the authentication credential was successfully set
## NOTES

## RELATED LINKS

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Authentication/Set-StatusCakeHelperAPIAuth.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Authentication/Set-StatusCakeHelperAPIAuth.md)

