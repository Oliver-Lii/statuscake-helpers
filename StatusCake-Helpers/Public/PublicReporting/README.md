# Public Reporting Pages

The following are examples for the functions which work against the StatusCake Public Reporting API

### Get-StatusCakeHelperPublicReportingPage
This cmdlet retrieves all Public Reporting Pages if no id or title supplied

```powershell
Get-StatusCakeHelperPublicReportingPage
id                 : a1B2c3D4e5
title              : Example Public Reporting Page
url                : https://uptime.statuscake.com/a1B2c3D4e5
cname              :
password_protected : False
created            : 2020-01-01T00:00:00+00:00
```

### Get-StatusCakeHelperPublicReportingPageDetail
This cmdlet retrieves detailed Public Reporting Pages by id

```powershell
Get-StatusCakeHelperPublicReportingPageDetail
id                  : a1B2c3D4e5
title               : Example Public Reporting Page
url                 : https://uptime.statuscake.com/a1B2c3D4e5
cname               :
password_protected  : False
twitter             :
display_annotations : False
display_orbs        : False
search_indexing     : False
sort_alphabetical   : False
use_tags            : False
tests_or_tags       : {}
tags_inclusive      : False
announcement        :
bg_color            : #22b0000
header_color        : #3780000
title_color         : #000000
created             : 2020-01-01T00:00:00+00:00
visits              : 0
```

### New-StatusCakeHelperPublicReportingPage
This cmdlet creates a new public reporting page. The cmdlet tests to see if a page with the title to be monitored already exists before creating the public reporting page.

```powershell
New-StatusCakeHelperPublicReportingPage -Title "Example Public Reporting Page" -TestIDs @("12345","23456")
id                  : a1B2c3D4e5
title               : Example Public Reporting Page
url                 : https://uptime.statuscake.com/a1B2c3D4e5
cname               :
password_protected  : False
twitter             :
display_annotations : False
display_orbs        : False
search_indexing     : False
sort_alphabetical   : False
use_tags            : False
tests_or_tags       : {12345,23456}
tags_inclusive      : False
announcement        :
bg_color            : #22b0000
header_color        : #3780000
title_color         : #000000
created             : 2020-01-01T00:00:00+00:00
visits              : 0
```

### Copy-StatusCakeHelperPublicReportingPage
This cmdlet copies a public reporting page. The cmdlet tests to see if a page with the title to be monitored already exists before creating the public reporting page.

```powershell
Copy-StatusCakeHelperPublicReportingPage -Title "Example Public Reporting Page" -NewTitle "Example Public Reporting Page - Copy"
id                  : B2c3D4e5F6
title               : Example Public Reporting Page - Copy
url                 : https://uptime.statuscake.com/B2c3D4e5F6
cname               :
password_protected  : False
twitter             :
display_annotations : False
display_orbs        : False
search_indexing     : False
sort_alphabetical   : False
use_tags            : False
tests_or_tags       : {12345,23456}
tags_inclusive      : False
announcement        :
bg_color            : #22b0000
header_color        : #3780000
title_color         : #000000
created             : 2020-01-01T00:00:00+00:00
visits              : 0
```

### Set-StatusCakeHelperPublicReportingPage
This cmdlet sets the configuration of a public reporting page. If a id or a title with setByTitle flag set is not supplied then a new public reporting page will be created.

```powershell
Set-StatusCakeHelperPublicReportingPage -ID "a1B2c3D4e5" -DisplayOrbs $true
id                  : a1B2c3D4e5
title               : Example Public Reporting Page
url                 : https://uptime.statuscake.com/a1B2c3D4e5
cname               :
password_protected  : False
twitter             :
display_annotations : False
display_orbs        : True
search_indexing     : False
sort_alphabetical   : False
use_tags            : False
tests_or_tags       : {12345,23456}
tags_inclusive      : False
announcement        :
bg_color            : #22b0000
header_color        : #3780000
title_color         : #000000
created             : 2020-01-01T00:00:00+00:00
visits              : 0
```
A public reporting page can be updated by title if there are no duplicates as follows:
```powershell
Set-StatusCakeHelperPublicReportingPage -Title "Example Public Reporting Page" -DisplayOrbs $false -SetByTitle
id                  : a1B2c3D4e5
title               : Example Public Reporting Page
url                 : https://uptime.statuscake.com/a1B2c3D4e5
cname               :
password_protected  : False
twitter             :
display_annotations : False
display_orbs        : False
search_indexing     : False
sort_alphabetical   : False
use_tags            : False
tests_or_tags       : {12345,23456}
tags_inclusive      : False
announcement        :
bg_color            : #22b0000
header_color        : #3780000
title_color         : #000000
created             : 2020-01-01T00:00:00+00:00
visits              : 0
```

### Remove-StatusCakeHelperPublicReportingPage
This cmdlet removes a Public Reporting page via either id or title of the public reporting page

```powershell
Remove-StatusCakeHelperPublicReportingPage -ID "1a2b3c4d5"
```
To remove by title specify the title parameter
```powershell
Remove-StatusCakeHelperPublicReportingPage -Title "Example Public Reporting Page" -PassThru
id                  : a1B2c3D4e5
title               : Example Public Reporting Page
url                 : https://uptime.statuscake.com/a1B2c3D4e5
cname               :
password_protected  : False
twitter             :
display_annotations : False
display_orbs        : False
search_indexing     : False
sort_alphabetical   : False
use_tags            : False
tests_or_tags       : {12345,23456}
tags_inclusive      : False
announcement        :
bg_color            : #22b0000
header_color        : #3780000
title_color         : #000000
created             : 2020-01-01T00:00:00+00:00
visits              : 0

```

# Authors
- Oliver Li