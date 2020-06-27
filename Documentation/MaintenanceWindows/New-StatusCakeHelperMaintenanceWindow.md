# New-StatusCakeHelperMaintenanceWindow

## SYNOPSIS
Create a StatusCake Maintenance Window

## SYNTAX

### SetByTestIDs
```
New-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] -Name <String> -StartDate <DateTime>
 -EndDate <DateTime> -Timezone <String> [-TestIDs <Int32[]>] [-RecurEvery <Int32>] [-FollowDST <Boolean>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SetByTestTags
```
New-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] -Name <String> -StartDate <DateTime>
 -EndDate <DateTime> -Timezone <String> [-TestTags <String[]>] [-RecurEvery <Int32>] [-FollowDST <Boolean>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new StatusCake Maintenance Window using the supplied parameters.
Tests can be included in the maintenance window by either supplying the test IDs or test tags.

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

Create a maintenance window called "Example Maintenance Window" starting today and ending in one hour in the Europe/London timezone for test ID 123456 recurring every 7 days

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
Start date of your window.
Can be slightly in the past

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases: start_unix, start_date

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
Aliases: end_unix, end_date

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

### -TestIDs
Individual tests that should be included

```yaml
Type: Int32[]
Parameter Sets: SetByTestIDs
Aliases: raw_tests

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestTags
Tests with these tags will be included

```yaml
Type: String[]
Parameter Sets: SetByTestTags
Aliases: raw_tags

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecurEvery
How often in days this window should recur.
0 disables this

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: recur_every

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -FollowDST
Whether DST should be followed or not

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: follow_dst

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
