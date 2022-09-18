# SSL Tests

The following are examples for the functions which work against the StatusCake SSL Tests API

### Get-StatusCakeHelperSSLTest
This cmdlet retrieves a specific StatusCake SSL Test by id or domain. If no id or name is supplied all SSL tests will be returned.

```powershell
Get-StatusCakeHelperSSLTest -id 123456
id                 : 123456
paused             : False
check_rate         : 86400
website_url        : https://www.example.com
issuer_common_name : R3
cipher             : TLS_CHACHA20_POLY1305_SHA256
cipher_score       : 100
certificate_score  : 100
certificate_status : CERT_OK
contact_groups     : {}
alert_at           : {1, 7, 14}
last_reminder      : 0
alert_reminder     : True
alert_expiry       : True
alert_broken       : True
alert_mixed        : True
follow_redirects   : True
valid_from         : 2022-01-01T16:59:00+00:00
valid_until        : 2022-03-03T16:59:00+00:00
updated_at         : 2022-03-03T21:23:31+00:00
mixed_content      : {}
flags              : @{is_extended=False; has_pfs=True; is_broken=False; is_expired=False; is_missing=False; is_revoked=False; has_mixed=False; follow_redirects=True}

```

### New-StatusCakeHelperSSLTest
This cmdlet creates a new SSL Test. The cmdlet tests to see if the domain to be monitored already being checked before creating the SSL Test. A SSL test is created by default to have all reminders enabled at 60, 30 and 7 days intervals. Only the ID of the page speed test is returned and to return the page speed test specify the PassThru switch.

```powershell
New-StatusCakeHelperSSLTest -Domain "https://www.example.com" -Checkrate 86400
id                 : 123456
paused             : False
check_rate         : 86400
website_url        : https://www.example.com
issuer_common_name : R3
cipher             : TLS_CHACHA20_POLY1305_SHA256
cipher_score       : 100
certificate_score  : 100
certificate_status : CERT_OK
contact_groups     : {}
alert_at           : {1, 7, 14}
last_reminder      : 0
alert_reminder     : True
alert_expiry       : True
alert_broken       : True
alert_mixed        : True
follow_redirects   : True
valid_from         : 2022-01-01T16:59:00+00:00
valid_until        : 2022-03-03T16:59:00+00:00
updated_at         : 2022-03-03T21:23:31+00:00
mixed_content      : {}
flags              : @{is_extended=False; has_pfs=True; is_broken=False; is_expired=False; is_missing=False; is_revoked=False; has_mixed=False; follow_redirects=True}
```

### Copy-StatusCakeHelperSSLTest
This cmdlet copies a SSL Test. The cmdlet tests to see if the domain to be monitored already being checked before creating the SSL Test. Returns the ID of the new test.

```powershell
Copy-StatusCakeHelperSSLTest -Domain "https://www.example.org" -NewDomain "https://www.example.com"
```

### Update-StatusCakeHelperSSLTest
This cmdlet updates the configuration of a specific SSL Test.

```powershell
Update-StatusCakeHelperSSLTest -ID 123456 -Checkrate 3600 -AlertAt @("14","90","120")
```

### Remove-StatusCakeHelperSSLTest
This cmdlet removes a SSL Test via either id or domain of the SSL Test

```powershell
Remove-StatusCakeHelperSSLTest -id 123456
```

# Authors
- Oliver Li