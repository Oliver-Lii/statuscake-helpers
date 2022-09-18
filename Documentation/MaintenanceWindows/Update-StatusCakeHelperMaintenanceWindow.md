# Update-StatusCakeHelperMaintenanceWindow

## SYNOPSIS
Updates a StatusCake Maintenance Window

## SYNTAX

### ID
```
Update-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] [-ID <String>] [-StartDate <DateTime>]
 [-EndDate <DateTime>] [-Timezone <String>] [-UptimeID <Int32[]>] [-UptimeTag <String[]>]
 [-RepeatInterval <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Name
```
Update-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] [-Name <String>]
 [-StartDate <DateTime>] [-EndDate <DateTime>] [-Timezone <String>] [-UptimeID <Int32[]>]
 [-UptimeTag <String[]>] [-RepeatInterval <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the configuration of StatusCake Maintenance Window using the supplied parameters.
You can only update a window which is in a pending state.

## EXAMPLES

### EXAMPLE 1
```
Update-StatusCakeHelperMaintenanceWindow -ID 123456 -RepeatInterval 1m
```

Modify the maintenance window with ID 123456 to recur every month

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
The maintenance window ID

```yaml
Type: String
Parameter Sets: ID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
A descriptive name for the maintenance window

```yaml
Type: String
Parameter Sets: Name
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartDate
Start date of your window.
Can be slightly in the past

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: start_at, start_date, start_unix

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndDate
End time of your window.
Must be in the future

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: end_at, end_date, end_unix

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Timezone
Must be a valid timezone, or UTC

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

### -UptimeID
Array of uptime test IDs that should be included

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: tests, raw_tests, TestIDs

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UptimeTag
Array of uptime test tags with these tags will be included

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: tags, raw_tags, TestTags

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RepeatInterval
How often in days this window should occur

```yaml
Type: String
Parameter Sets: (All)
Aliases: repeat_interval

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

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/MaintenanceWindows/Update-StatusCakeHelperMaintenanceWindow.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/MaintenanceWindows/Update-StatusCakeHelperMaintenanceWindow.md)

[https://www.statuscake.com/api/v1/#tag/maintenance-windows/operation/update-maintenance-window](https://www.statuscake.com/api/v1/#tag/maintenance-windows/operation/update-maintenance-window)

