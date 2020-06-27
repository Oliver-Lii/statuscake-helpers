# Get-StatusCakeHelperTestDetail

## SYNOPSIS
Retrieves a StatusCake Test with a Test ID

## SYNTAX

```
Get-StatusCakeHelperTestDetail [-APICredential <PSCredential>] [-TestID <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves StatusCake Detailed Test Data via the Test ID

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperTestDetail -testID 123456
```

Retrieve detailed test information for test with ID 123456

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Returns detailed test information
## NOTES

## RELATED LINKS
