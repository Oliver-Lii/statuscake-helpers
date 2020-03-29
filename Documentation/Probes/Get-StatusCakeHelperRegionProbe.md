# Get-StatusCakeHelperRegionProbe

## SYNOPSIS
Retrieve the StatusCake Probe by AWS region

## SYNTAX

```
Get-StatusCakeHelperRegionProbe [-AWSRegion] <Object> [[-Status] <Object>] [[-StatusCakeProbeData] <Object>]
 [<CommonParameters>]
```

## DESCRIPTION
Retrieves the details of StatusCake probes nearest to a specific AWS region.
If no object for StatusCake probe data is supplied the probe data is retrieved from StatusCake's RSS feed.
Probes can be filtered to probes which are up, down or either

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperRegionProbe -AWSRegion "eu-west-1"
```

Retrieve StatusCake probes nearest to AWS Region eu-west-1

## PARAMETERS

### -AWSRegion
AWSRegion to retrieve probes for

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
Filter the probe status include probes which are up or down.
Default will return both.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### -StatusCakeProbeData
Supply StatusCakeProbeData if you wish to limit the probe data which should be searched

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: (Get-StatusCakeHelperProbe)
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
