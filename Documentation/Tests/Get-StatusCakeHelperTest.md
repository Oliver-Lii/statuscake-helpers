# Get-StatusCakeHelperTest

## SYNOPSIS
Retrieves a StatusCake Test with a specific name or Test ID

## SYNTAX

### MatchTag (Default)
```
Get-StatusCakeHelperTest [-APICredential <PSCredential>] [-ContactID <Int32>] [-Status <String>]
 [-Tags <String[]>] [<CommonParameters>]
```

### ByTestName
```
Get-StatusCakeHelperTest [-APICredential <PSCredential>] [-TestName <String>] [-Detailed] [<CommonParameters>]
```

### ByTestID
```
Get-StatusCakeHelperTest [-APICredential <PSCredential>] [-TestID <Int32>] [-Detailed] [<CommonParameters>]
```

### MatchAnyTag
```
Get-StatusCakeHelperTest [-APICredential <PSCredential>] [-ContactID <Int32>] [-Status <String>]
 -Tags <String[]> [-MatchAny <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves StatusCake Test via the test name of the test or Test ID

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperTest
```

Retrieve all tests

### EXAMPLE 2
```
Get-StatusCakeHelperTest -testID 123456
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

### -TestName
Name of the test to retrieve

```yaml
Type: String
Parameter Sets: ByTestName
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestID
Test ID to retrieve

```yaml
Type: Int32
Parameter Sets: ByTestID
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
Parameter Sets: ByTestName, ByTestID
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContactID
Filter tests using a specific Contact Group ID

```yaml
Type: Int32
Parameter Sets: MatchTag, MatchAnyTag
Aliases: CUID

Required: False
Position: Named
Default value: 0
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

### -Tags
Match tests with tags

```yaml
Type: String[]
Parameter Sets: MatchTag
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String[]
Parameter Sets: MatchAnyTag
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MatchAny
Match tests which have any of the supplied tags (true) or all of the supplied tags (false)

```yaml
Type: Boolean
Parameter Sets: MatchAnyTag
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

### Returns the test which exists returning $null if no matching test
## NOTES

## RELATED LINKS
