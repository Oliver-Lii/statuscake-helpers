# Get-StatusCakeHelperPageSpeedTestDetail

## SYNOPSIS
Retrieves the details of a StatusCake Page Speed Test

## SYNTAX

```
Get-StatusCakeHelperPageSpeedTestDetail [-APICredential <PSCredential>] [-ID <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves StatusCake Detailed Page Speed Test Data via the Test ID

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperPageSpeedTestDetail -ID 123456
```

Retrieve detailed page speed test data by ID 123456

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
Test ID to retrieve detailed test data

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Returns the details of the page speed test
## NOTES

## RELATED LINKS
