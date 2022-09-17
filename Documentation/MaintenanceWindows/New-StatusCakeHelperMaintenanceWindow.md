# New-StatusCakeHelperMaintenanceWindow

## SYNOPSIS
Create a StatusCake Maintenance Window

## SYNTAX

```
New-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] -Name <String> -StartDate <DateTime>
 -EndDate <DateTime> -Timezone <String> [-UptimeID <Int32[]>] [-UptimeTag <String[]>]
 [-RepeatInterval <String>] [-Force] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new StatusCake Maintenance Window using the supplied parameters.
Tests can be included in the maintenance window by either supplying the uptime test IDs or uptime test tags.

## EXAMPLES

### EXAMPLE 1
```
New-StatusCakeHelperMaintenanceWindow -Name "Example Maintenance Window" -StartDate $(Get-Date) -EndDate $((Get-Date).AddHours(1)) -Timezone "Europe/London" -TestIDs @("123456")
```

Create a maintenance window called "Example Maintenance Window" starting today and ending in one hour in the Europe/London timezone for test ID 123456

### EXAMPLE 2
```
New-StatusCakeHelperMaintenanceWindow -Name "Example Maintenance Window" -StartDate $(Get-Date) -EndDate $((Get-Date).AddHours(1)) -Timezone "Europe/London" -TestTags @("Tag1","Tag2")
```

Create a maintenance window called "Example Maintenance Window" starting today and ending in one hour in the Europe/London timezone including tests which have tags "Tag1" and "Tag2"

### EXAMPLE 3
```
New-StatusCakeHelperMaintenanceWindow -Name "Example Maintenance Window" -StartDate $(Get-Date) -EndDate $((Get-Date).AddHours(1)) -Timezone "Europe/London" -TestIDs @("123456") -RecurEvery 7
```

Create a maintenance window called "Example Maintenance Window" starting today and ending in one hour in the Europe/London timezone for test ID 123456 recurring every 7 day

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
A descriptive name for the maintenance window

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

### -StartDate
Start date of the maintenance window.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: start_at, start_date, start_unix

Required: True
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

Required: True
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

Required: True
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
How often this window should occur

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

### -Force
Force creation of the maintenance window even if a window with the same name already exists

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
Return the maintenance window details instead of the maintenance window id

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

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/MaintenanceWindows/New-StatusCakeHelperMaintenanceWindow.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/MaintenanceWindows/New-StatusCakeHelperMaintenanceWindow.md)

[https://www.statuscake.com/api/v1/#tag/maintenance-windows/operation/create-maintenance-window](https://www.statuscake.com/api/v1/#tag/maintenance-windows/operation/create-maintenance-window)

