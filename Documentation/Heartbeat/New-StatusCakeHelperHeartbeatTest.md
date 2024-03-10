# New-StatusCakeHelperHeartbeatTest

## SYNOPSIS
Create a StatusCake Heartbeat Test

## SYNTAX

```
New-StatusCakeHelperHeartbeatTest [-APICredential <PSCredential>] -Name <String> [-Period <Int32>]
 [-ContactID <Int32[]>] [-HostingProvider <String>] [-Paused <Boolean>] [-Tags <String[]>] [-Force] [-PassThru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new StatusCake Heartbeat Test using the supplied parameters.

## EXAMPLES

### EXAMPLE 1
```
New-StatusCakeHelperHeartbeatTest -Name "Example Heartbeat test"
```

Create a new Heartbeat check called "Example Heartbeat test"

### EXAMPLE 2
```
New-StatusCakeHelperHeartbeatTest -Name "Example Heartbeat test" -Period 30
```

Create a new Heartbeat check called "Example Heartbeat test" to be considered down if a ping is not received every 30 seconds

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
Name of the check

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

### -Period
Number of seconds since last ping before the check is considered down

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 1800
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

### -HostingProvider
Name of the hosting provider

```yaml
Type: String
Parameter Sets: (All)
Aliases: host

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Paused
Whether the check should be run.

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

### -Tags
Array of tags to apply to the test

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

### -Force
Create an Heartbeat test even if one with the same name already exists

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
Return the Heartbeat test details instead of the Heartbeat test id

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

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Heartbeat/New-StatusCakeHelperHeartbeatTest.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Heartbeat/New-StatusCakeHelperHeartbeatTest.md)

[https://www.statuscake.com/api/v1/#tag/heartbeat/operation/create-heartbeat-test](https://www.statuscake.com/api/v1/#tag/heartbeat/operation/create-heartbeat-test)

