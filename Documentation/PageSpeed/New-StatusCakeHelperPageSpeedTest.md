# New-StatusCakeHelperPageSpeedTest

## SYNOPSIS
Create a StatusCake PageSpeed Test

## SYNTAX

```
New-StatusCakeHelperPageSpeedTest [-APICredential <PSCredential>] -Name <String> -WebsiteURL <String>
 -Checkrate <Int32> [-AlertBigger <Int32>] [-AlertSlower <Int32>] [-AlertSmaller <Int32>]
 [-ContactID <Int32[]>] -Region <String> [-Paused <Boolean>] [-Force] [-PassThru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a new StatusCake PageSpeed Test using the supplied parameters.

## EXAMPLES

### EXAMPLE 1
```
New-StatusCakeHelperPageSpeedTest -WebsiteURL "https://www.example.com" -Checkrate 60 Region UK -AlertSlower 10000
```

Create a page speed test to check site "https://www.example.com" every 60 minutes from a UK test server and alert when page speed load time is slower than 10000ms

### EXAMPLE 2
```
New-StatusCakeHelperPageSpeedTest -WebsiteURL "https://www.example.com" -Checkrate 60 -Region UK -AlertSmaller 500
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

### -Name
Name for PageSpeed test

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

### -WebsiteURL
URL that should be checked

```yaml
Type: String
Parameter Sets: (All)
Aliases: website_url

Required: True
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

Required: True
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
Time in ms, will alert to Contact Groups if actual time is slower

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
Size in kb, will alert to Contact Groups if actual size is smaller

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
2-letter code of the region from which to run the checks.
Valid values: AU, CA, DE, FR, IN, JP, NL, SG, UK, US, USW

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

### -Force
Force creation of the test even if a test with the same name already exists

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

### -PassThru
Return the page speed test details instead of the page speed test id

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

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/PageSpeed/New-StatusCakeHelperPageSpeedTest.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/PageSpeed/New-StatusCakeHelperPageSpeedTest.md)

[https://www.statuscake.com/api/v1/#tag/pagespeed/operation/create-pagespeed-test](https://www.statuscake.com/api/v1/#tag/pagespeed/operation/create-pagespeed-test)

