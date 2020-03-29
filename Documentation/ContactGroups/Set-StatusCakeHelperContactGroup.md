# Set-StatusCakeHelperContactGroup

## SYNOPSIS
Sets the configuration of a StatusCake ContactGroup

## SYNTAX

### SetByContactID
```
Set-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [-ContactID <Int32>] [-GroupName <String>]
 [-DesktopAlert <Boolean>] [-Email <String[]>] [-PingURL <String>] [-Boxcar <String>] [-Pushover <String>]
 [-Mobile <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SetByGroupName
```
Set-StatusCakeHelperContactGroup [-APICredential <PSCredential>] [-SetByGroupName] -GroupName <String>
 [-DesktopAlert <Boolean>] [-Email <String[]>] [-PingURL <String>] [-Boxcar <String>] [-Pushover <String>]
 [-Mobile <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets a StatusCake ContactGroup using the supplied parameters.
Values supplied overwrite existing values.

## EXAMPLES

### EXAMPLE 1
```
Set-StatusCakeHelperContactGroup -GroupName "Example" -email @(test@example.com)
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

### -ContactID
ID of the contact group to set

```yaml
Type: Int32
Parameter Sets: SetByContactID
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SetByGroupName
Flag to set to allow Contact Group to be set by Group Name

```yaml
Type: SwitchParameter
Parameter Sets: SetByGroupName
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -GroupName
Name of the Contact Group to be created

```yaml
Type: String
Parameter Sets: SetByContactID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: SetByGroupName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DesktopAlert
Set to 1 To Enable Desktop Alerts

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Email
Array of email addresses to sent alerts to.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

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
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Boxcar
Boxcar API Key

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Pushover
Pushover Account Key

```yaml
Type: String
Parameter Sets: (All)
Aliases:

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
