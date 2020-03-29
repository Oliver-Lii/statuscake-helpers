# Remove-StatusCakeHelperTestNodeLocation

## SYNOPSIS
Remove node locations from a StatusCake test

## SYNTAX

### ByTestID
```
Remove-StatusCakeHelperTestNodeLocation [-APICredential <PSCredential>] -TestID <Int32>
 -NodeLocations <String[]> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByTestName
```
Remove-StatusCakeHelperTestNodeLocation [-APICredential <PSCredential>] -TestName <String[]>
 -NodeLocations <String[]> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove node location(s) to a existing test.
The supplied node location is tested against a list of the node location server codes to determine if it is valid.
Server codes can be retrieved via the Get-StatusCakeHelperProbe command and checking the servercode property of the returned objects.

## EXAMPLES

### EXAMPLE 1
```
Remove-StatusCakeHelperTestNodeLocation -TestID "123456" -NodeLocations @("EU1","EU2")
```

Remove node locations EU1 and EU2 from test with ID 123456

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
ID of the Test to be removed from StatusCake

```yaml
Type: Int32
Parameter Sets: ByTestID
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestName
Name of the Test to be removed from StatusCake

```yaml
Type: String[]
Parameter Sets: ByTestName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NodeLocations
Array of test locations to be removed.
Test location servercodes are required

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Return the object that is removed

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

## NOTES

## RELATED LINKS
