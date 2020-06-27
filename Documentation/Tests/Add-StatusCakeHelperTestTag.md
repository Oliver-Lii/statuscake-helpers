# Add-StatusCakeHelperTestTag

## SYNOPSIS
Add tags to a StatusCake test

## SYNTAX

### ByTestID
```
Add-StatusCakeHelperTestTag [-APICredential <PSCredential>] -TestID <Int32> -Tags <String[]> [-PassThru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByTestName
```
Add-StatusCakeHelperTestTag [-APICredential <PSCredential>] -TestName <String> -Tags <String[]> [-PassThru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Add tag(s) to a existing test.

## EXAMPLES

### EXAMPLE 1
```
Add-StatusCakeHelperTestTags -TestID "123456" -Tags @("Tag1","Tag2")
```

Add tags Tag1 and Tag2 to test with ID 123456

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
The Test ID to modify the details for

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
Name of the Test displayed in StatusCake

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
Array of tags to add

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
Returns the object which this function modifies.
By default, this function does not return any output.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
