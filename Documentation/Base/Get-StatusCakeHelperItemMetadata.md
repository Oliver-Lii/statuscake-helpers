# Get-StatusCakeHelperItemMetadata

## SYNOPSIS
Gets the metadata for a StatusCake Pagespeed or Uptime test

## SYNTAX

### All (Default)
```
Get-StatusCakeHelperItemMetadata [-APICredential <PSCredential>] -Type <String> -Property <String>
 [-Parameter <Hashtable>] [-PageLimit <Int32>] [-ResultLimit <Int32>] [<CommonParameters>]
```

### ID
```
Get-StatusCakeHelperItemMetadata [-APICredential <PSCredential>] [-ID <Int32>] -Type <String>
 -Property <String> [-Parameter <Hashtable>] [-PageLimit <Int32>] [-ResultLimit <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves the metadata for a StatusCake item by type.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperItemMetadata -Type "PageSpeed" -Property History -Name "Pagespeed Test"
```

Retrieve pagespeed test history for test with name PageSpeed Test

### EXAMPLE 2
```
Get-StatusCakeHelperItemMetadata -Type "Uptime" -Property Alerts -Name "Example Uptime Speed Test"
```

Retrieve details of alerts sent for a Uptime test called "Example Page Speed Test"

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
ID of the item

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

### -Type
Type of item to retrieve

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

### -Property
Type of metadata to retrieve

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

### -Parameter
Hashtable of parameters to be used for the request

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PageLimit
The number of results to return per page

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 25
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResultLimit
The maximum number of results to return

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Collections.Generic.List`1[[System.Management.Automation.PSObject, System.Management.Automation, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]
## NOTES

## RELATED LINKS
