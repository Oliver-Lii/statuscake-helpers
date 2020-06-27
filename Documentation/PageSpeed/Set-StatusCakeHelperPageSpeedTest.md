# Set-StatusCakeHelperPageSpeedTest

## SYNOPSIS
Updates a StatusCake PageSpeed Test

## SYNTAX

### NewPageSpeedTest
```
Set-StatusCakeHelperPageSpeedTest [-APICredential <PSCredential>] -Name <String> -Checkrate <Int32>
 -LocationISO <String> -WebsiteURL <String> [-AlertBigger <Int32>] [-AlertSlower <Int32>]
 [-AlertSmaller <Int32>] [-ContactIDs <Int32[]>] [-PrivateName <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### SetByName
```
Set-StatusCakeHelperPageSpeedTest [-APICredential <PSCredential>] [-SetByName] [-Name <String>]
 [-Checkrate <Int32>] [-LocationISO <String>] [-WebsiteURL <String>] [-AlertBigger <Int32>]
 [-AlertSlower <Int32>] [-AlertSmaller <Int32>] [-ContactIDs <Int32[]>] [-PrivateName <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### SetByID
```
Set-StatusCakeHelperPageSpeedTest [-APICredential <PSCredential>] -ID <Int32> [-Name <String>]
 [-Checkrate <Int32>] [-LocationISO <String>] [-WebsiteURL <String>] [-AlertBigger <Int32>]
 [-AlertSlower <Int32>] [-AlertSmaller <Int32>] [-ContactIDs <Int32[]>] [-PrivateName <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Set the details of a StatusCake PageSpeed Test using the supplied parameters.
Values supplied overwrite existing values.

## EXAMPLES

### EXAMPLE 1
```
Set-StatusCakeHelperPageSpeedTest -ID 123456 -Checkrate 1440
```

Modify the page speed test with id 123456 to be checked every 1440 minutes

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
ID of the PageSpeed Test

```yaml
Type: Int32
Parameter Sets: SetByID
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -SetByName
Flag to set to use Page Speed Test name instead of id

```yaml
Type: SwitchParameter
Parameter Sets: SetByName
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name for Page Speed test

```yaml
Type: String
Parameter Sets: NewPageSpeedTest
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: SetByName, SetByID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Checkrate
Frequency in minutes with which the page speed test should be run

```yaml
Type: Int32
Parameter Sets: NewPageSpeedTest
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Int32
Parameter Sets: SetByName, SetByID
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LocationISO
2-letter ISO code of the location.
Valid values: AU, CA, DE, IN, NL, SG, UK, US, PRIVATE

```yaml
Type: String
Parameter Sets: NewPageSpeedTest
Aliases: location_iso

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: SetByName, SetByID
Aliases: location_iso

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
Parameter Sets: NewPageSpeedTest
Aliases: website_url

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: String
Parameter Sets: SetByName, SetByID
Aliases: website_url

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AlertBigger
Size in kb, will alert to Contact Groups if actual size is bigger

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

### -ContactIDs
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

### -PrivateName
Must select PRIVATE in location_iso.
Name of private server \[NOT YET IMPLEMENTED\]

```yaml
Type: String
Parameter Sets: (All)
Aliases: private_name

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
