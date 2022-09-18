# New-StatusCakeHelperSSLTest

## SYNOPSIS
Create a StatusCake SSL Test

## SYNTAX

```
New-StatusCakeHelperSSLTest [-APICredential <PSCredential>] -WebsiteURL <String> [-Checkrate <Int32>]
 [-AlertAt <Int32[]>] [-AlertBroken <Boolean>] [-AlertExpiry <Boolean>] [-AlertMixed <Boolean>]
 [-AlertReminder <Boolean>] [-ContactID <Int32[]>] [-FollowRedirects <Boolean>] [-Hostname <String>]
 [-Paused <Boolean>] [-UserAgent <String>] [-Force] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new StatusCake SSL Test using the supplied parameters.
Default settings for a SSL test will check a URL every day with alerts sent at 7, 14 and 30 days.

## EXAMPLES

### EXAMPLE 1
```
New-StatusCakeHelperSSLTest -WebsiteURL "https://www.example.com"
```

Create a new SSL Test to check https://www.example.com every day

### EXAMPLE 2
```
New-StatusCakeHelperSSLTest -WebsiteURL "https://www.example.com" -AlertAt ("14","30","60")
```

Create a new SSL Test to check https://www.example.com every day with alerts sent at 14, 30 and 60 days.

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

### -WebsiteURL
URL to check

```yaml
Type: String
Parameter Sets: (All)
Aliases: website_url, Domain

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Checkrate
Checkrate in seconds.
Default is 86400 seconds (1 day).
Options are 300 (5 minutes), 600 (10 minutes), 1800 (30 minutes), 3600 (1 hour), 86400 (1 day), 2073600 (24 days)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: check_rate

Required: False
Position: Named
Default value: 86400
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertAt
Number of days before expiration when reminders will be sent.
Defaults to reminders at 30, 14 and 7 days.
Must be 3 numeric values.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: alert_at

Required: False
Position: Named
Default value: @("7","14","30")
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertBroken
Set to true to enable broken alerts.
False to disable

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: alert_broken

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertExpiry
Set to true to enable expiration alerts.
False to disable

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: alert_expiry

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertMixed
Set to true to enable mixed content alerts.
False to disable

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: alert_mixed

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
Parameter Sets: (All)
Aliases: alert_reminder

Required: False
Position: Named
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContactID
Array containing contact IDs to alert.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: contact_groups

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FollowRedirects
Whether to follow redirects when testing.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: follow_redirects

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Hostname
Hostname of the server under test

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

### -Paused
Whether the test should be run.

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

### -UserAgent
Custom user agent string set when testing

```yaml
Type: String
Parameter Sets: (All)
Aliases: user_agent

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Create an SSL test even if one with the same website URL already exists

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
Return the SSL test details instead of the SSL test id

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

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/SSL/New-StatusCakeHelperSSLTest.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/SSL/New-StatusCakeHelperSSLTest.md)

[https://www.statuscake.com/api/v1/#tag/ssl/operation/create-ssl-test](https://www.statuscake.com/api/v1/#tag/ssl/operation/create-ssl-test)

