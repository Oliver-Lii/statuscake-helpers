# Update-StatusCakeHelperItem

## SYNOPSIS
Update a StatusCake item

## SYNTAX

```
Update-StatusCakeHelperItem [-APICredential <PSCredential>] [-ID <Int32>] -Type <String>
 [-Parameter <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update a StatusCake Contact Group, Maintenance Window, PageSpeed, SSL or Uptime item

## EXAMPLES

### EXAMPLE 1
```
Update-StatusCakeHelperItem -Type "PageSpeed" -ID 12345 -Parameter @{"check_rate"="3600"}
```

Update a pagespeed test called "Example Page Speed Test" to check every hour

### EXAMPLE 2
```
Update-StatusCakeHelperItem -Type "SSL" -ID 12345 -Parameter @{"check_rate"=86400}
```

Update a ssl test to check the SSL certificate of https://www.example.com every day

### EXAMPLE 3
```
Update-StatusCakeHelperItem -Type "Uptime" ID 12345 -Parameter @{"name"="New Example Uptime Speed Test"}
```

Update a uptime test called "Example Uptime Speed Test" and change it's name to "New Example Uptime Speed Test"

### EXAMPLE 4
```
Update-StatusCakeHelperItem -Type "Contact-Groups" ID 12345 -Parameter @{"email_addresses"="postmaster@example.com"}
```

Update a contact group called "Example Contact Group" to use the email address postmaster@example.com

### EXAMPLE 5
```
Update-StatusCakeHelperItem -Type "Maintenance-Window" -ID 12345 -Parameter @{"repeat_interval"=2w}
```

Update a maintenance window with ID 12345 to have a repeat interval of every 2 weeks

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
ID of the test

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

### -Type
Type of test to remove

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
Hashtable of parameters to use to update the StatusCake item

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
