# Remove-StatusCakeHelperHeartbeatTest

## SYNOPSIS
Removes the specified StatusCake Test

## SYNTAX

### ID
```
Remove-StatusCakeHelperHeartbeatTest [-APICredential <PSCredential>] [-ID <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Name
```
Remove-StatusCakeHelperHeartbeatTest [-APICredential <PSCredential>] [-Name <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Removes the StatusCake test via it's Test ID or name

## EXAMPLES

### EXAMPLE 1
```
Remove-StatusCakeHelperHeartbeatTest -ID 123456
```

Delete the StatusCake test with ID 123456

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
ID of the Test to be removed from StatusCake

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
Name of the Test to be removed from StatusCake

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

### Returns the result of the test removal as an object
## NOTES

## RELATED LINKS

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Heartbeat/Remove-StatusCakeHelperHeartbeatTest.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Heartbeat/Remove-StatusCakeHelperHeartbeatTest.md)

[https://www.statuscake.com/api/v1/#tag/heartbeat/operation/delete-heartbeat-test](https://www.statuscake.com/api/v1/#tag/heartbeat/operation/delete-heartbeat-test)

