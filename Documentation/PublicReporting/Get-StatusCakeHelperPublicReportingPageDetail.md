# Get-StatusCakeHelperPublicReportingPageDetail

## SYNOPSIS
Retrieves a StatusCake Public Reporting Page

## SYNTAX

```
Get-StatusCakeHelperPublicReportingPageDetail [-APICredential <PSCredential>] [-ID <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Retrieves StatusCake Detailed Public Reporting Page Data via the ID

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperPublicReportingPageDetail -ID a1B2c3D4e5
```

Retrieve detailed information about the public reporting page with ID a1B2c3D4e5

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Returns the details of a StatusCake Public Reporting page
## NOTES

## RELATED LINKS
