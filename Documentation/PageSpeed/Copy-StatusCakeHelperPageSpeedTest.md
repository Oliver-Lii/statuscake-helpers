# Copy-StatusCakeHelperPageSpeedTest

## SYNOPSIS
Copies the settings of a StatusCake Page Speed Test

## SYNTAX

### CopyById
```
Copy-StatusCakeHelperPageSpeedTest [-APICredential <PSCredential>] -ID <Int32> -NewName <String>
 [-WebsiteURL <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CopyByName
```
Copy-StatusCakeHelperPageSpeedTest [-APICredential <PSCredential>] -Name <String> -NewName <String>
 [-WebsiteURL <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a copy of a Page Speed Test.
Supply a value for the WebsiteURL parameter to override the source URL.

## EXAMPLES

### EXAMPLE 1
```
Copy-StatusCakeHelperPageSpeedTest -Name "Example" -NewName "Example - Copy"
```

Creates a copy of a page speed test called "Example" with name "Example - Copy"

### EXAMPLE 2
```
Copy-StatusCakeHelperPageSpeedTest -Name "Example" -NewName "Example - Copy" -WebsiteURL "https://www.example.org"
```

Creates a copy of a page speed test called "Example" with name "Example - Copy" using the URL "https://www.example.org"

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
ID of the Page Speed Test to be copied

```yaml
Type: Int32
Parameter Sets: CopyById
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name of the Page Speed Test to be copied

```yaml
Type: String
Parameter Sets: CopyByName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NewName
Name of the Page Speed Test copy

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
Name of the URL to be used in the copy of the test

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
