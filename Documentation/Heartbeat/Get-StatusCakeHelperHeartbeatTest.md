# Get-StatusCakeHelperHeartbeatTest

## SYNOPSIS
Retrieves a StatusCake Heartbeat Test with a specific name or Test ID

## SYNTAX

### MatchTag (Default)
```
Get-StatusCakeHelperHeartbeatTest [-APICredential <PSCredential>] [-ID <Int32>] [-Name <String>]
 [-Tag <String[]>] [-NoUptime] [-Status <String>] [<CommonParameters>]
```

### MatchAnyTag
```
Get-StatusCakeHelperHeartbeatTest [-APICredential <PSCredential>] [-ID <Int32>] [-Name <String>]
 -Tag <String[]> [-NoUptime] [-MatchAny] [-Status <String>] [<CommonParameters>]
```

### ByTestID
```
Get-StatusCakeHelperHeartbeatTest [-APICredential <PSCredential>] [-ID <Int32>] [<CommonParameters>]
```

### ByTestName
```
Get-StatusCakeHelperHeartbeatTest [-APICredential <PSCredential>] [-Name <String>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves StatusCake Heartbeat Test via the test name of the test or Test ID

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperHeartbeatTest
```

Retrieve all tests

### EXAMPLE 2
```
Get-StatusCakeHelperHeartbeatTest -ID 123456
```

Retrieve the test with ID 123456

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
Test ID to retrieve

```yaml
Type: Int32
Parameter Sets: MatchTag, MatchAnyTag, ByTestID
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the test to retrieve

```yaml
Type: String
Parameter Sets: MatchTag, MatchAnyTag, ByTestName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tag
Match tests with tags

```yaml
Type: String[]
Parameter Sets: MatchTag
Aliases: tags

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String[]
Parameter Sets: MatchAnyTag
Aliases: tags

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoUptime
Do not calculate uptime percentages for results.
Default is false.

```yaml
Type: SwitchParameter
Parameter Sets: MatchTag, MatchAnyTag
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -MatchAny
Match tests which have any of the supplied tags (true) or all of the supplied tags (false).
Default is false.

```yaml
Type: SwitchParameter
Parameter Sets: MatchAnyTag
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
Filter tests to a specific status

```yaml
Type: String
Parameter Sets: MatchTag, MatchAnyTag
Aliases:

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

### Returns the test which exists returning $null if no matching test
## NOTES

## RELATED LINKS

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Heartbeat/Get-StatusCakeHelperHeartbeatTest.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Heartbeat/Get-StatusCakeHelperHeartbeatTest.md)

[https://www.statuscake.com/api/v1/#tag/heartbeat/operation/list-heartbeat-tests](https://www.statuscake.com/api/v1/#tag/heartbeat/operation/list-heartbeat-tests)

[https://www.statuscake.com/api/v1/#tag/heartbeat/operation/get-heartbeat-test](https://www.statuscake.com/api/v1/#tag/heartbeat/operation/get-heartbeat-test)

