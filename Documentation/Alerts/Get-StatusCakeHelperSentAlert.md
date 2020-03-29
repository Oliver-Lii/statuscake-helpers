# Get-StatusCakeHelperSentAlert

## SYNOPSIS
Retrieves alerts that have been sent in relation to tests setup on the account

## SYNTAX

```
Get-StatusCakeHelperSentAlert [-APICredential <PSCredential>] [-TestID <Int32>] [-TestName <String>]
 [-Since <DateTime>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Returns alerts that have been sent for tests.
The return order is newest alerts are shown first.
Alerts to be returned can be filtered by test using the TestID or TestName parameter and filtered by date using the Since parameter.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperSentAlert
```

Return all the alerts sent for any test

### EXAMPLE 2
```
Get-StatusCakeHelperSentAlert -TestID 123456 -since "2017-08-19 13:29:49"
```

Return all the alerts sent for test ID 123456 since the 19th August 2017 13:29:49

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

### -TestID
ID of the Test to retrieve the sent alerts for

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestName
Name of the Test to retrieve the sent alerts for

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

### -Since
Supply to include results only since the specified date

```yaml
Type: DateTime
Parameter Sets: (All)
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Returns an object with the details on the Alerts Sent
## NOTES

## RELATED LINKS
