# Get-StatusCakeHelperItem

## SYNOPSIS
Gets a StatusCake Contact Group, Maintenance Window, PageSpeed, SSL or Uptime item

## SYNTAX

### All (Default)
```
Get-StatusCakeHelperItem [-APICredential <PSCredential>] -Type <String> [-Parameter <Hashtable>]
 [-Limit <Int32>] [<CommonParameters>]
```

### ID
```
Get-StatusCakeHelperItem [-APICredential <PSCredential>] [-ID <Int32>] -Type <String> [-Parameter <Hashtable>]
 [-Limit <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves a StatusCake item by type.
If no name or id is supplied all items of that type are returned.

## EXAMPLES

### EXAMPLE 1
```
Get-StatusCakeHelperItem -Type "PageSpeed"
```

Retrieve all pagespeed tests

### EXAMPLE 2
```
Get-StatusCakeHelperItem -Type "SSL" -ID 1234
```

Retrieve ssl test information for a test with ID 1234

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
ID of the item to retrieve

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

### -Parameter
Hashtable of parameters for the item.
The keys and values in the hashtable should match the parameters expected by the StatusCake API.

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

### -Limit
Number of items to retrieve per page

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Collections.Generic.List`1[[System.Management.Automation.PSObject, System.Management.Automation, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]
## NOTES

## RELATED LINKS
