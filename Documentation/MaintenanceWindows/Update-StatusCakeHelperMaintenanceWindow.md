# Update-StatusCakeHelperMaintenanceWindow

## SYNOPSIS
Updates a StatusCake Maintenance Window

## SYNTAX

### SetByID
```
Update-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] -ID <String> [-StartDate <DateTime>]
 [-EndDate <DateTime>] [-Timezone <String>] [-TestIDs <Int32[]>] [-TestTags <String[]>] [-RecurEvery <Int32>]
 [-FollowDST <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SetByName
```
Update-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] -Name <String> [-StartDate <DateTime>]
 [-EndDate <DateTime>] [-Timezone <String>] [-TestIDs <Int32[]>] [-TestTags <String[]>] [-RecurEvery <Int32>]
 [-FollowDST <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the configuration of StatusCake Maintenance Window using the supplied parameters.
You can only update a window which is in a pending state.

## EXAMPLES

### EXAMPLE 1
```
Update-StatusCakeHelperMaintenanceWindow -ID 123456 -RecurEvery 30
```

Modify the maintenance window with ID 123456 to recur every 30 days

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
Parameter Sets: SetByID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
A descriptive name for the maintenance window

```yaml
Type: String
Parameter Sets: SetByName
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
Aliases: end_unix, end_date

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

### -TestIDs
Individual tests that should be included

```yaml
Type: Int32[]
Parameter Sets: (All)
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
Parameter Sets: (All)
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
