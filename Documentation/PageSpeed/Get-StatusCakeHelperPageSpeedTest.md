# Get-StatusCakeHelperPageSpeedTest

## SYNOPSIS
Gets a StatusCake PageSpeed Test

## SYNTAX

### All (Default)
```
Get-StatusCakeHelperPageSpeedTest [-APICredential <PSCredential>] [-Detailed] [<CommonParameters>]
```

### Name
```
Get-StatusCakeHelperPageSpeedTest [-APICredential <PSCredential>] [-Name <String>] [-Detailed]
 [<CommonParameters>]
```

### ID
```
Get-StatusCakeHelperPageSpeedTest [-APICredential <PSCredential>] [-ID <Int32>] [-Detailed]
 [<CommonParameters>]
```

## DESCRIPTION
Retrieves a StatusCake PageSpeed Test.
If no name or id is supplied all tests are returned.
By default only standard information about a test is returned and more detailed information can be retrieved by using detailed switch.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperPageSpeedTest
```

Retrieve all page speed tests

### EXAMPLE 2
```
Get-StatusCakeHelperPageSpeedTest -Name "Example Page Speed Test" -Detailed
```

Retrieve detailed page speed test information for a test called "Example Page Speed Test"

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

### -Name
Name of the PageSpeed test

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

### -ID
ID of the PageSpeed Test

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

### -Detailed
Retrieve detailed test data

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
