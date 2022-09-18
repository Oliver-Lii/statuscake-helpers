# New-StatusCakeHelperUptimeTest

## SYNOPSIS
Create a StatusCake uptime tes

## SYNTAX

```
New-StatusCakeHelperUptimeTest [-APICredential <PSCredential>] -Name <String> -Type <String>
 -WebsiteURL <String> -CheckRate <Int32> [-BasicUsername <String>] [-BasicPassword <SecureString>]
 [-Confirmation <Int32>] [-ContactID <Int32[]>] [-CustomHeader <Hashtable>] [-DoNotFind <Boolean>]
 [-EnableSSLAlert <Boolean>] [-FinalEndpoint <String>] [-FindString <String>] [-FollowRedirect <Boolean>]
 [-HostingProvider <String>] [-IncludeHeader <Boolean>] [-Paused <Boolean>] [-PostBody <Object>]
 [-PostRaw <String>] [-Region <String[]>] [-StatusCode <Int32[]>] [-Tag <String[]>] [-Timeout <Int32>]
 [-TriggerRate <Int32>] [-UseJar <Boolean>] [-UserAgent <String>] [-Force] [-PassThru] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates a new StatusCake Uptime Test using the supplied parameters.
Only parameters which have been supplied values are set
and the defaults for a particular test type are used otherwise.

## EXAMPLES

### EXAMPLE 1
```
New-StatusCakeHelperUptimeTest -tName "Example" -WebsiteURL "http://www.example.com" -TestType HTTP -CheckRate 300
```

Create a HTTP test called "Example" with URL http://www.example.com checking every 300 seconds

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
Name of the Test to be displayed in StatusCake

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

### -Type
The type of test to create.
Valid options are "DNS", "HEAD", "HTTP", "PING", "SMTP", "SSH", "TCP"

```yaml
Type: String
Parameter Sets: (All)
Aliases: test_type, TestType

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WebsiteURL
Test location, either an IP (for TCP and Ping) or a fully qualified URL for other TestTypes

```yaml
Type: String
Parameter Sets: (All)
Aliases: website_url, Endpoint, Domain, IP, HostName

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CheckRate
The interval in seconds between checks.
Default is 300 seconds.

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

### -BasicUsername
A Basic Auth Username to use to login for a HTTP check

```yaml
Type: String
Parameter Sets: (All)
Aliases: basic_username

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -BasicPassword
If BasicUser is set then this should be the password for the BasicUser for a HTTP check

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases: basic_password

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirmation
Number of confirmation servers to use must be between 0 and 3

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

### -ContactID
An array of contact group IDs to be assigned to the check

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: contact_groups, ContactGroup

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CustomHeader
Custom HTTP header for the test, must be supplied as as hashtable

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: custom_header

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DoNotFind
If the value for the FindString parameter should be found to trigger a alert.
1 = will trigger if FindString found

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: do_not_find

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableSSLAlert
HTTP Tests only.
If enabled, tests will send warnings if the SSL certificate is about to expire.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: enable_ssl_alert, EnableSSLWarning

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FinalEndpoint
Use to specify the expected Final URL in the testing process

```yaml
Type: String
Parameter Sets: (All)
Aliases: final_endpoint

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FindString
A string that should either be found or not found.

```yaml
Type: String
Parameter Sets: (All)
Aliases: find_string

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FollowRedirect
HTTP Tests only.
Whether to follow redirects when testing.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: follow_redirects

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -HostingProvider
Name of the hosting provider

```yaml
Type: String
Parameter Sets: (All)
Aliases: host

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeHeader
Include header content in string match search

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: include_header

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Paused
The state of the test should be after it is created.
0 for unpaused, 1 for paused

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

### -PostBody
Use to populate the POST data field on the test

```yaml
Type: Object
Parameter Sets: (All)
Aliases: post_body

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PostRaw
Use to populate the RAW POST data field on the test

```yaml
Type: String
Parameter Sets: (All)
Aliases: post_raw

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Region
Array of region codes which should be used for the test.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: regions

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StatusCode
Array of StatusCodes that trigger an alert

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases: status_codes_csv

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tag
Array of tags to assign to a test

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: tags

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Timeout
Time in seconds before a test times out.
Valid values are between 5 and 100 seconds

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

### -TriggerRate
How many minutes to wait before sending an alert.
Valid values are between 0 and 60 minutes

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: trigger_rate

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseJar
Set to 1 to enable the Cookie Jar.
Required for some redirects.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases: use_jar

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserAgent
Use to populate the test with a custom user agent

```yaml
Type: String
Parameter Sets: (All)
Aliases: user_agent

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Create an uptime test even if one with the same website URL already exists

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
Return the uptime test details instead of the uptime test id

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

[https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Uptime/New-StatusCakeHelperUptimeTest.md](https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Uptime/New-StatusCakeHelperUptimeTest.md)

[https://www.statuscake.com/api/v1/#tag/uptime/operation/create-uptime-test](https://www.statuscake.com/api/v1/#tag/uptime/operation/create-uptime-test)

