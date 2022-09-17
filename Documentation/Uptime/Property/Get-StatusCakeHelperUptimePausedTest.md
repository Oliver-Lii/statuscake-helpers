# Get-StatusCakeHelperUptimePausedTest

## SYNOPSIS
Retrieves all the StatusCake Tests that have been paused more than the specified time unit

## SYNTAX

### Minutes
```
Get-StatusCakeHelperUptimePausedTest [-APICredential <PSCredential>] [-Minutes <Int32>] [-IncludeNotTested]
 [-ExcludeTested] [<CommonParameters>]
```

### Hours
```
Get-StatusCakeHelperUptimePausedTest [-APICredential <PSCredential>] [-Hours <Int32>] [-IncludeNotTested]
 [-ExcludeTested] [<CommonParameters>]
```

### Days
```
Get-StatusCakeHelperUptimePausedTest [-APICredential <PSCredential>] [-Days <Int32>] [-IncludeNotTested]
 [-ExcludeTested] [<CommonParameters>]
```

## DESCRIPTION
Retrieves all the tests from StatusCake that are paused and have been tested longer than
the supplied parameters.
Defaults to returning tests that have been paused more than 24 hours.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperUptimePausedTest
```

Get all tests paused longer than a day

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

### -Days
Specify the number of day(s) (24h period) that the test(s) has been paused

```yaml
Type: Int32
Parameter Sets: Days
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -Hours
Specify the number of hour(s) that the test(s) has been paused

```yaml
Type: Int32
Parameter Sets: Hours
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Minutes
Specify the number of minute(s) that the test(s) has been paused

```yaml
Type: Int32
Parameter Sets: Minutes
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeNotTested
If set tests that have never been tested will be included

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

### -ExcludeTested
If set tests that have been tested will be excluded

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Returns an object with the StatusCake Detailed Test data
## NOTES

## RELATED LINKS
