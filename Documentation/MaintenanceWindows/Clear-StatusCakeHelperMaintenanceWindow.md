# Clear-StatusCakeHelperMaintenanceWindow

## SYNOPSIS
Clears the tests associated with a StatusCake Maintenance Window

## SYNTAX

### TestTags
```
Clear-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] -ID <String> -Name <String>
 [-UptimeTag] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### TestIDs
```
Clear-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] -ID <String> -Name <String> [-UptimeID]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByID
```
Clear-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] -ID <String> [-UptimeID] [-UptimeTag]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByName
```
Clear-StatusCakeHelperMaintenanceWindow [-APICredential <PSCredential>] -Name <String> [-UptimeID] [-UptimeTag]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Clears the tests and/or tags associated with a pending StatusCake Maintenance Window.
You can only clear the test IDs/tags for a window which is in a pending state.

## EXAMPLES

### EXAMPLE 1
```
Clear-StatusCakeHelperMaintenanceWindow -ID 123456 -TestIDs
```

Clear all test IDs associated with maintenance window 123456

### EXAMPLE 2
```
Clear-StatusCakeHelperMaintenanceWindow -ID 123456 -TestTags
```

Clear all test tags associated with maintenance window 123456

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
Parameter Sets: TestTags, TestIDs, ByID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the maintenance window to clear the tests from

```yaml
Type: String
Parameter Sets: TestTags, TestIDs, ByName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UptimeID
Flag to clear all tests included in a maintenance window

```yaml
Type: SwitchParameter
Parameter Sets: TestIDs
Aliases: tests, raw_tests, TestIDs

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: SwitchParameter
Parameter Sets: ByID, ByName
Aliases: tests, raw_tests, TestIDs

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UptimeTag
Flag to clear all tags of the tests to be included in a maintenance window

```yaml
Type: SwitchParameter
Parameter Sets: TestTags
Aliases: tags, raw_tags, TestTags

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: SwitchParameter
Parameter Sets: ByID, ByName
Aliases: tags, raw_tags, TestTags

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
