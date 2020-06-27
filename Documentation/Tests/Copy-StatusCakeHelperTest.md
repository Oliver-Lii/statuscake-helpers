# Copy-StatusCakeHelperTest

## SYNOPSIS
Copies the settings of a StatusCake test check

## SYNTAX

### CopyById
```
Copy-StatusCakeHelperTest [-APICredential <PSCredential>] -TestID <Int32> [-TestURL <String>]
 -NewTestName <String> [-Paused <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CopyByName
```
Copy-StatusCakeHelperTest [-APICredential <PSCredential>] -TestName <String> [-TestURL <String>]
 -NewTestName <String> [-Paused <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a copy of a test.
Supply the TestURL or Paused parameter to override the original values in the source test.

## EXAMPLES

### EXAMPLE 1
```
Copy-StatusCakeHelperTest -TestName "Example" -NewTestName "Example - Copy"
```

Create a copy of test "Example" with name "Example - Copy"

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
Parameter Sets: CopyById
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
Parameter Sets: CopyByName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestURL
The Test ID to modify the details for

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

### -NewTestName
Name of the new copied test

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Paused
If supplied sets the state of the test should be after it is copied.

```yaml
Type: Boolean
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
