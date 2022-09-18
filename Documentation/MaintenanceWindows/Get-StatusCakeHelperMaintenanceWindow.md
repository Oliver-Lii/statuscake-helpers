# Get-StatusCakeHelperMaintenanceWindow

## SYNOPSIS
Gets a StatusCake Maintenance Window

## SYNTAX

### all (Default)
```
Get-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] [-State <String>] [<CommonParameters>]
```

### Name
```
Get-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] [-Name <String>] [<CommonParameters>]
```

### ID
```
Get-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] [-ID <Int32>] [<CommonParameters>]
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
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-StatusCakeHelperAPIAuth)
Accept pipeline input: False
Accept wildcard characters: False
```

### -State
Filter results based on state.
Valid options are pending, active, and paused

```yaml
Type: String
Parameter Sets: all
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Returns StatusCake Maintenance Windows as an object
## NOTES

## RELATED LINKS

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/MaintenanceWindows/Get-StatusCakeHelperMaintenanceWindow.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/MaintenanceWindows/Get-StatusCakeHelperMaintenanceWindow.md)

[https://www.statuscake.com/api/v1/#operation/list-maintenance-windows](https://www.statuscake.com/api/v1/#operation/list-maintenance-windows)

[https://www.statuscake.com/api/v1/#operation/get-maintenance-window](https://www.statuscake.com/api/v1/#operation/get-maintenance-window)

