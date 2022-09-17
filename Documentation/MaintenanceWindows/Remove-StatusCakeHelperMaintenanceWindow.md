# Remove-StatusCakeHelperMaintenanceWindow

## SYNOPSIS
Remove a StatusCake Maintenance Window

## SYNTAX

### ID
```
Remove-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] [-ID <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### name
```
Remove-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] [-Name <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Deletes a StatusCake Maintenance Window using the supplied ID or name.

## EXAMPLES

### EXAMPLE 1
```
Remove-StatusCakeHelperMaintenanceWindow -ID 123456
```

Remove the maintenance window with id 123456

### EXAMPLE 2
```
Remove-StatusCakeHelperMaintenanceWindow -ID 123456 -Name "Example Maintenance Window"
```

Remove the maintenance window with name "Example Maintenance Window"

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
Type: Int32
Parameter Sets: ID
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the maintenance window to remove

```yaml
Type: String
Parameter Sets: name
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/MaintenanceWindows/Remove-StatusCakeHelperMaintenanceWindow.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/MaintenanceWindows/Remove-StatusCakeHelperMaintenanceWindow.md)

[https://www.statuscake.com/api/v1/#tag/maintenance-windows/operation/delete-maintenance-window](https://www.statuscake.com/api/v1/#tag/maintenance-windows/operation/delete-maintenance-window)

