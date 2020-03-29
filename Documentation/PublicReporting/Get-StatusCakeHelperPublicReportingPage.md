# Get-StatusCakeHelperPublicReportingPage

## SYNOPSIS
Retrieves a StatusCake Public Reporting Page

## SYNTAX

```
Get-StatusCakeHelperPublicReportingPage [-APICredential <PSCredential>] [-Title <String>] [-ID <String>]
 [-Detailed] [<CommonParameters>]
```

## DESCRIPTION
Retrieves all StatusCake Public Reporting Pages if no parameters supplied otherwise returns the specified public reporting page.
By default only standard information about a public reporting page is returned and more detailed information can be retrieved by using the detailed switch.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperPublicReportingPage
```

Retrieve all public reporting pages

### EXAMPLE 2
```
Get-StatusCakeHelperPublicReportingPage -ID a1B2c3D4e5
```

Retrieve the public reporting page with ID a1B2c3D4e5

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

### -Title
Title of the public reporting page

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

### -ID
ID of the public reporting page

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

### -Detailed
Retrieve detailed public reporting page data

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

### Returns StatusCake Public Reporting Pages as an object
## NOTES

## RELATED LINKS
