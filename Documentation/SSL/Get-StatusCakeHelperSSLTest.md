# Get-StatusCakeHelperSSLTest

## SYNOPSIS
Gets a StatusCake SSL Test

## SYNTAX

### All (Default)
```
Get-StatusCakeHelperSSLTest [-APICredential <PSCredential>] [<CommonParameters>]
```

### Domain
```
Get-StatusCakeHelperSSLTest [-APICredential <PSCredential>] [-Domain <String>] [<CommonParameters>]
```

### ID
```
Get-StatusCakeHelperSSLTest [-APICredential <PSCredential>] [-ID <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves a StatusCake SSL Test.
If no domain or id is supplied all tests are returned.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperSSLTest
```

Retrieve all SSL tests

### EXAMPLE 2
```
Get-StatusCakeHelperSSLTest -ID 123456
```

Retrieve SSL test with ID 123456

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

### -Domain
Name of the test to retrieve

```yaml
Type: String
Parameter Sets: Domain
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ID
Test ID to retrieve

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Returns a StatusCake SSL Tests as an object
## NOTES

## RELATED LINKS
