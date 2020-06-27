# Set-StatusCakeHelperSSLTest

## SYNOPSIS
Updates a StatusCake SSL Test

## SYNTAX

### NewSSLTest
```
Set-StatusCakeHelperSSLTest [-APICredential <PSCredential>] -Domain <String> -ContactIDs <Int32[]>
 -Checkrate <Int32> -AlertAt <Int32[]> -AlertExpiry <Boolean> -AlertReminder <Boolean> -AlertBroken <Boolean>
 -AlertMixed <Boolean> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SetByDomain
```
Set-StatusCakeHelperSSLTest [-APICredential <PSCredential>] [-SetByDomain] [-Domain <String>]
 [-ContactIDs <Int32[]>] [-Checkrate <Int32>] [-AlertAt <Int32[]>] [-AlertExpiry <Boolean>]
 [-AlertReminder <Boolean>] [-AlertBroken <Boolean>] [-AlertMixed <Boolean>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### SetByID
```
Set-StatusCakeHelperSSLTest [-APICredential <PSCredential>] -ID <Int32> [-ContactIDs <Int32[]>]
 [-Checkrate <Int32>] [-AlertAt <Int32[]>] [-AlertExpiry <Boolean>] [-AlertReminder <Boolean>]
 [-AlertBroken <Boolean>] [-AlertMixed <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the configuration of a StatusCake SSL Test using the supplied parameters.

## EXAMPLES

### EXAMPLE 1
```
Set-StatusCakeHelperSSLTest -id 123456 -checkrate 3600
```

Change the checkrate of test with ID 123456 to 3600 seconds

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
Test ID to retrieve

```yaml
Type: Int32
Parameter Sets: SetByID
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SetByDomain
Switch to update SSL test by domain name

```yaml
Type: SwitchParameter
Parameter Sets: SetByDomain
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Domain
URL domain to update

```yaml
Type: String
Parameter Sets: NewSSLTest
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: SetByDomain
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContactIDs
Array containing contact IDs to alert.

```yaml
Type: Int32[]
Parameter Sets: NewSSLTest
Aliases: contact_groups

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Int32[]
Parameter Sets: SetByDomain, SetByID
Aliases: contact_groups

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Checkrate
Checkrate in seconds.
Options are 300 (5 minutes), 600 (10 minutes), 1800 (30 minutes), 3600 (1 hour), 86400 (1 day), 2073600 (24 days)

```yaml
Type: Int32
Parameter Sets: NewSSLTest
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Int32
Parameter Sets: SetByDomain, SetByID
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertAt
Number of days before expiration when reminders will be sent.
Must be 3 numeric values.

```yaml
Type: Int32[]
Parameter Sets: NewSSLTest
Aliases: alert_at

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Int32[]
Parameter Sets: SetByDomain, SetByID
Aliases: alert_at

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertExpiry
Set to true to enable expiration alerts.
False to disable

```yaml
Type: Boolean
Parameter Sets: NewSSLTest
Aliases: alert_expiry

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Boolean
Parameter Sets: SetByDomain, SetByID
Aliases: alert_expiry

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertReminder
Set to true to enable reminder alerts.
False to disable

```yaml
Type: Boolean
Parameter Sets: NewSSLTest
Aliases: alert_reminder

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Boolean
Parameter Sets: SetByDomain, SetByID
Aliases: alert_reminder

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertBroken
Set to true to enable broken alerts.
False to disable

```yaml
Type: Boolean
Parameter Sets: NewSSLTest
Aliases: alert_broken

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Boolean
Parameter Sets: SetByDomain, SetByID
Aliases: alert_broken

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertMixed
Set to true to enable mixed content alerts.
False to disable

```yaml
Type: Boolean
Parameter Sets: NewSSLTest
Aliases: alert_mixed

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Boolean
Parameter Sets: SetByDomain, SetByID
Aliases: alert_mixed

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
