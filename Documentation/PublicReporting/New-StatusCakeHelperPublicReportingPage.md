# New-StatusCakeHelperPublicReportingPage

## SYNOPSIS
Create a StatusCake Public Reporting Page

## SYNTAX

### Title (Default)
```
New-StatusCakeHelperPublicReportingPage [-APICredential <PSCredential>] -Title <String> [-CName <String>]
 [-Password <SecureString>] [-Twitter <String>] [-DisplayAnnotations <Boolean>] [-DisplayOrbs <Boolean>]
 [-SearchIndexing <Boolean>] [-SortAlphabetical <Boolean>] [-Announcement <String>] [-BGColor <String>]
 [-HeaderColor <String>] [-TitleColor <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### UseTags
```
New-StatusCakeHelperPublicReportingPage [-APICredential <PSCredential>] -Title <String> [-CName <String>]
 [-Password <SecureString>] [-Twitter <String>] [-DisplayAnnotations <Boolean>] [-DisplayOrbs <Boolean>]
 [-SearchIndexing <Boolean>] [-SortAlphabetical <Boolean>] [-TestTags <String[]>] [-TagsInclusive <Boolean>]
 [-Announcement <String>] [-BGColor <String>] [-HeaderColor <String>] [-TitleColor <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### UseTestIDs
```
New-StatusCakeHelperPublicReportingPage [-APICredential <PSCredential>] -Title <String> [-CName <String>]
 [-Password <SecureString>] [-Twitter <String>] [-DisplayAnnotations <Boolean>] [-DisplayOrbs <Boolean>]
 [-SearchIndexing <Boolean>] [-SortAlphabetical <Boolean>] [-TestIDs <Int32[]>] [-Announcement <String>]
 [-BGColor <String>] [-HeaderColor <String>] [-TitleColor <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new StatusCake Public Reporting Page using the supplied parameters.

## EXAMPLES

### EXAMPLE 1
```
New-StatusCakeHelperPublicReportingPage -Title "Example.com Public Reporting Page"
```

Create a public reporting page called "Example.com Public Reporting Page" with no associated tests

### EXAMPLE 2
```
New-StatusCakeHelperPublicReportingPage -Title "Example.com Public Reporting Page" -TestIDs @(123456)
```

Create a public reporting page called "Example.com Public Reporting Page" for test ID 123456

### EXAMPLE 3
```
New-StatusCakeHelperPublicReportingPage -Title "Example.com Public Reporting Page" -TestTags @("Example","Example Page")
```

Create a public reporting page called "Example.com Public Reporting Page" for tests which have the tags "Example" and "Example Page"

### EXAMPLE 4
```
New-StatusCakeHelperPublicReportingPage -Title "Example.com Public Reporting Page" -TestTags @("Example","Example Page") -TagsInclusive
```

Create a public reporting page called "Example.com Public Reporting Page" for tests which have one or more of the tags "Example" or "Example Page"

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

### -Title
The title of the Public Reporting Page

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

### -CName
CName record for a custom domain

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

### -Password
Password protection for the page.
Leave empty to disable

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Twitter
Twitter handle to display with the @.
Leave empty to disable

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

### -DisplayAnnotations
Set to true to show annotations for status periods

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: display_annotations

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayOrbs
Set to true to display uptime as colored orbs

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: display_orbs

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchIndexing
Set to false to disable search engine indexing

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: search_indexing

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortAlphabetical
Set to true to order tests by alphabetical name

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: sort_alphabetical

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestTags
Array of tags which a test must contain to be included on the Public Reporting Page

```yaml
Type: String[]
Parameter Sets: UseTags
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TagsInclusive
Set to true to select all tests that include one or more of the provided tags

```yaml
Type: Boolean
Parameter Sets: UseTags
Aliases: tags_inclusive

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -TestIDs
Array of TestIDs to be associated with Public Reporting page

```yaml
Type: Int32[]
Parameter Sets: UseTestIDs
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Announcement
Free text field that will appear as an announcement on the page

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

### -BGColor
HEX value for the background colour

```yaml
Type: String
Parameter Sets: (All)
Aliases: bg_color

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HeaderColor
HEX value for the header colour

```yaml
Type: String
Parameter Sets: (All)
Aliases: header_color

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TitleColor
HEX value for the header text colour

```yaml
Type: String
Parameter Sets: (All)
Aliases: title_color

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
