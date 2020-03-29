# Add-StatusCakeHelperTestStatusCode

## SYNOPSIS
Add additional HTTP status codes to alert on to a StatusCake test

## SYNTAX

### ByTestID
```
Add-StatusCakeHelperTestStatusCode [-APICredential <PSCredential>] -TestID <Int32> -StatusCodes <Int32[]>
 [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ByTestName
```
Add-StatusCakeHelperTestStatusCode [-APICredential <PSCredential>] -TestName <String> -StatusCodes <Int32[]>
 [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Add additional HTTP StatusCodes to alert on to an existing test.

## EXAMPLES

### EXAMPLE 1
```
Add-StatusCakeHelperTestStatusCode -TestID "123456" -StatusCodes @(206,207)
```

Add status codes 206 and 207 to test with ID 123456

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

### -StatusCodes
Array of status codes to be added.

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
