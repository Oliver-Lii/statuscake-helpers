# Copy-StatusCakeHelperHeartbeatTest

## SYNOPSIS
Copies the settings of a StatusCake test

## SYNTAX

### CopyById
```
Copy-StatusCakeHelperHeartbeatTest [-APICredential <PSCredential>] -ID <Int32> -NewName <String>
 [-Paused <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CopyByName
```
Copy-StatusCakeHelperHeartbeatTest [-APICredential <PSCredential>] -Name <String> -NewName <String>
 [-Paused <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a copy of a test.
Supply the Paused parameter to override the original values in the source test.

## EXAMPLES

### EXAMPLE 1
```
Copy-StatusCakeHelperHeartbeatTest -Name "Example" -NewName "Example - Copy"
```

Create a copy of test "Example" with name "Example - Copy"

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
The Heartbeat test ID to modify the details for

```yaml
Type: Int32
Parameter Sets: CopyById
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the heartbeat Test

```yaml
Type: String
Parameter Sets: CopyByName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewName
Name of the new copied heartbeat test

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

### -Paused
If supplied sets the state of the test should be after it is copied.

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

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Heartbeat/Copy-StatusCakeHelperHeartbeatTest.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Heartbeat/Copy-StatusCakeHelperHeartbeatTest.md)

