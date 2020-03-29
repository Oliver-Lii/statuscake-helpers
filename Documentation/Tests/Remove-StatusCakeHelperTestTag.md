# Remove-StatusCakeHelperTestTag

## SYNOPSIS
Remove tag(s) from a StatusCake test

## SYNTAX

### ByTestID
```
Remove-StatusCakeHelperTestTag [-APICredential <PSCredential>] -TestID <Int32> -Tags <String[]> [-PassThru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByTestName
```
Remove-StatusCakeHelperTestTag [-APICredential <PSCredential>] -TestName <String> -Tags <String[]> [-PassThru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Remove tag(s) from an existing test.

## EXAMPLES

### EXAMPLE 1
```
Remove-StatusCakeHelperTestTags -TestID "123456" -TestTags @("Tag1","Tag2")
```

Remove tags Tag1 and Tag2 from test with ID 123456

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
Type: String
Parameter Sets: ByTestName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tags
Array of tags to be removed

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: TestTags

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
