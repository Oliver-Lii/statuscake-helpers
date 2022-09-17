# New-StatusCakeHelperItem

## SYNOPSIS
Creates a StatusCake Contact Group, Maintenance Window, PageSpeed, SSL or Uptime item

## SYNTAX

```
New-StatusCakeHelperItem [-APICredential <PSCredential>] -Type <String> [-Parameter <Hashtable>] [-PassThru]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a StatusCake Contact Group, Maintenance Window, PageSpeed, SSL or Uptime item and returns the ID.
Use the passthru switch to return the details of the test created.

## EXAMPLES

### EXAMPLE 1
```
New-StatusCakeHelperItem -Type "pagespeed" -Parameter @{"name"="Example Page Speed Test"; "website_url"="https://www.example.com"; "check_rate"=86400; "region"="US"}
```

Create a pagespeed test called "Example Page Speed Test" to check https://www.example.com every day from the US region

### EXAMPLE 2
```
New-StatusCakeHelperItem -Type "ssl" -Parameter @{"website_url"="https://www.example.com"; "check_rate"=86400}
```

Create a ssl test to check https://www.example.com every day

### EXAMPLE 3
```
New-StatusCakeHelperItem -Type "uptime" -Parameter @{"name"="Example Uptime Speed Test";"test_type"="HTTP" "website_url"="https://www.example.com"; "check_rate"=86400}
```

Create a uptime test called "Example Uptime Speed Test" to perform a HTTP check to test https://www.example.com every day

### EXAMPLE 4
```
New-StatusCakeHelperItem -Type "contact-groups" -Parameter @{"name"="Example Contact Group"}
```

Create a contact group called "Example Contact Group"

### EXAMPLE 5
```
New-StatusCakeHelperItem -Type "maintenance-window" -Parameter @{"name"="Example Contact Group";"start_at"="2022-01-01T00:30:00Z";"end_at"="2022-01-01T01:30:00Z";"timezone"="UTC"}
```

Create a maintenance window called "Example Maintenance Window" starting at 1st January 2022 00:30 UTC until 1st January 2022 01:30 UTC

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

### -Type
Type of item to create

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
Hashtable of parameters to create the item.
The keys and values in the hashtable should match the parameters expected by the StatusCake API

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

### -PassThru
Return the details of the object created.
By default only the ID is returned.

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
