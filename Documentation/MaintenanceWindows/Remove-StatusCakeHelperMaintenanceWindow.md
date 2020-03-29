# Remove-StatusCakeHelperMaintenanceWindow

## SYNOPSIS
Remove a StatusCake Maintenance Window

## SYNTAX

### ID
```
Remove-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] [-ID <Int32>] [-Series] [-PassThru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### name
```
Remove-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] [-Name <String>] -State <String>
 [-Series] [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a StatusCake Maintenance Window using the supplied ID or name.
If the series switch is not provided then the next window scheduled under the ID will be removed.
The entire series of windows can be removed if the series switch is provided.

## EXAMPLES

### EXAMPLE 1
```
Remove-StatusCakeHelperMaintenanceWindow -ID 123456
```

Remove the next pending maintenance window under id 123456

### EXAMPLE 2
```
Remove-StatusCakeHelperMaintenanceWindow -ID 123456 -Series
```

Remove the series of maintenance windows scheduled under id 123456

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
A descriptive name for the maintenance window

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

### -State
The state of the maintenance window to remove.
Required only when removing a MW by name.

```yaml
Type: String
Parameter Sets: name
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Series
Set flag to cancel the entire series of maintenance windows instead of cancelling the one window

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
Return the object to be deleted

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
