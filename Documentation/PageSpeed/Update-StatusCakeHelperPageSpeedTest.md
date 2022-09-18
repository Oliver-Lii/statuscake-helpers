# Update-StatusCakeHelperPageSpeedTest

## SYNOPSIS
Updates a StatusCake PageSpeed Test

## SYNTAX

### ID
```
Update-StatusCakeHelperPageSpeedTest [-APICredential <PSCredential>] [-ID <Int32>] [-WebsiteURL <String>]
 [-Checkrate <Int32>] [-AlertBigger <Int32>] [-AlertSlower <Int32>] [-AlertSmaller <Int32>]
 [-ContactID <Int32[]>] [-Region <String>] [-Paused <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Name
```
Update-StatusCakeHelperPageSpeedTest [-APICredential <PSCredential>] [-Name <String>] [-WebsiteURL <String>]
 [-Checkrate <Int32>] [-AlertBigger <Int32>] [-AlertSlower <Int32>] [-AlertSmaller <Int32>]
 [-ContactID <Int32[]>] [-Region <String>] [-Paused <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates a new StatusCake PageSpeed Test by either its name or ID.

## EXAMPLES

### EXAMPLE 1
```
Update-StatusCakeHelperPageSpeedTest -WebsiteURL "https://www.example.com" -Checkrate 60 -Region UK -AlertSlower 10000
```

Create a page speed test to check site "https://www.example.com" every 60 minutes from a UK test server and alert when page speed load time is slower than 10000ms

### EXAMPLE 2
```
Update-StatusCakeHelperPageSpeedTest -WebsiteURL "https://www.example.com" -Checkrate 60 -Region UK -AlertSmaller 500
```

Create a page speed test to check site "https://www.example.com" every 60 minutes from a UK test server and alert when page load is less than 500kb

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
ID of PageSpeed test to update

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

### -Name
Name of PageSpeed test to update

```yaml
Type: String
Parameter Sets: Name
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WebsiteURL
URL that should be checked

```yaml
Type: String
Parameter Sets: (All)
Aliases: website_url

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Checkrate
Number of seconds between checks

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: check_rate

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertBigger
An alert will be sent if the size of the page is larger than this value (kb).
A value of 0 prevents alerts being sent.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: alert_bigger

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertSlower
Time in ms, will alert to Contact Groups if actual time is slower.
A value of 0 prevents alerts being sent.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: alert_slower

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertSmaller
Size in kb, will alert to Contact Groups if actual size is smaller.
A value of 0 prevents alerts being sent.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: alert_smaller

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContactID
IDs of selected Contact Groups to alert

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: contact_groups

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Region
Statuscake region from which to run the checks.
Valid values: AU, CA, DE, FR, IN, JP, NL, SG, UK, US, USW

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

### -Paused
Whether the test should be run.

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

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/PageSpeed/Update-StatusCakeHelperPageSpeedTest.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/PageSpeed/Update-StatusCakeHelperPageSpeedTest.md)

[https://www.statuscake.com/api/v1/#tag/pagespeed/operation/update-pagespeed-test](https://www.statuscake.com/api/v1/#tag/pagespeed/operation/update-pagespeed-test)

