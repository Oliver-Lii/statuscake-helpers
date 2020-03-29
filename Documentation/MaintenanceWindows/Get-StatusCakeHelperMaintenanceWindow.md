# Get-StatusCakeHelperMaintenanceWindow

## SYNOPSIS
Gets a StatusCake Maintenance Window

## SYNTAX

### all (Default)
```
Get-StatusCakeHelperMaintenanceWindow [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ID
```
Get-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] [-State <String>] [-ID <Int32>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### Name
```
Get-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] [-State <String>] [-Name <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Retrieves StatusCake Maintenance Windows.
If no id or name is supplied all maintenance windows are returned.
Results can be filtered by maintenance window state.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperMaintenanceWindow
```

Get all maintenance windows

### EXAMPLE 2
```
Get-StatusCakeHelperMaintenanceWindow -State PND
```

Get all maintenance windows in a pending state

## PARAMETERS

### -APICredential
Credentials to access StatusCake API

```yaml
Type: PSCredential
Parameter Sets: ID, Name
Aliases:

Required: False
Position: Named
Default value: (Get-StatusCakeHelperAPIAuth)
Accept pipeline input: False
Accept wildcard characters: False
```

### -State
Filter results based on state.
PND - Pending, ACT - Active, END - Ended, CNC - Cancelled

```yaml
Type: String
Parameter Sets: ID, Name
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the maintenance window to retrieve

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

### -ID
ID of the maintenance window to retrieve

```yaml
Type: Int32
Parameter Sets: ID
Aliases:

Required: False
Position: Named
Default value: 0
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

### Returns StatusCake Maintenance Windows as an object
## NOTES

## RELATED LINKS
