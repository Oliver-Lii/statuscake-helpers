# SSL Tests

The following are examples for the functions which work against the StatusCake SSL Tests API

### Get-StatusCakeHelperSSLTest
This cmdlet retrieves a specific StatusCake SSL Test by id or domain. If no id or name is supplied all SSL tests will be returned.

```powershell
Get-StatusCakeHelperSSLTest -id 123456
id               : 123456
checkrate        : 86400
paused           : False
domain           : https://www.example.com
issuer_cn        :
cert_score       : 0
cipher_score     : 0
cert_status      :
cipher           :
valid_from_utc   : 0000-00-00 00:00:00
valid_until_utc  : 0000-00-00 00:00:00
mixed_content    :
flags            : @{is_extended=False; has_pfs=True; is_broken=False; is_expired=False; is_missing=False; is_revoked=False; has_mixed=False}
contact_groups   : {}
alert_at         : 1,7,30
last_reminder    : 0
alert_reminder   : True
alert_expiry     : True
alert_broken     : True
alert_mixed      : True
last_updated_utc : 0000-00-00 00:00:00

```

### New-StatusCakeHelperSSLTest
This cmdlet creates a new SSL Test. The cmdlet tests to see if the domain to be monitored already being checked before creating the SSL Test. A SSL test is created by default to have all reminders enabled at 60, 30 and 7 days intervals. Mandatory parameters are illustrated in the example below:

```powershell
New-StatusCakeHelperSSLTest -Domain "https://www.example.com" -checkrate 3600
id               : 123456
checkrate        : 86400
paused           : False
domain           : https://www.example.com
issuer_cn        :
cert_score       : 0
cipher_score     : 0
cert_status      :
cipher           :
valid_from_utc   : 0000-00-00 00:00:00
valid_until_utc  : 0000-00-00 00:00:00
mixed_content    :
flags            : @{is_extended=False; has_pfs=True; is_broken=False; is_expired=False; is_missing=False; is_revoked=False; has_mixed=False}
contact_groups   : {}
alert_at         : 1,7,30
last_reminder    : 0
alert_reminder   : True
alert_expiry     : True
alert_broken     : True
alert_mixed      : True
last_updated_utc : 0000-00-00 00:00:00
```

### Copy-StatusCakeHelperSSLTest
This cmdlet copies a SSL Test. The cmdlet tests to see if the domain to be monitored already being checked before creating the SSL Test. The check rate is not returned when retrieving the details of a SSL test and defaults to checking once a day.

```powershell
Copy-StatusCakeHelperSSLTest -Domain "https://www.example.org" -NewDomain "https://www.example.com"
id               : 123456
checkrate        : 86400
paused           : False
domain           : https://www.example.com
issuer_cn        :
cert_score       : 0
cipher_score     : 0
cert_status      :
cipher           :
valid_from_utc   : 0000-00-00 00:00:00
valid_until_utc  : 0000-00-00 00:00:00
mixed_content    :
flags            : @{is_extended=False; has_pfs=True; is_broken=False; is_expired=False; is_missing=False; is_revoked=False; has_mixed=False}
contact_groups   : {}
alert_at         : 1,7,30
last_reminder    : 0
alert_reminder   : True
alert_expiry     : True
alert_broken     : True
alert_mixed      : True
last_updated_utc : 0000-00-00 00:00:00
```

### Set-StatusCakeHelperSSLTest
This cmdlet sets the configuration of a specific SSL Test. If a id or a domain with setByDomain flag set is not supplied then a new test will be created

```powershell
Set-StatusCakeHelperSSLTest -id 123456 -checkrate 3600 -Alert_At @("14","90","120")
id               : 123456
checkrate        : 3600
paused           : False
domain           : https://www.example.com
issuer_cn        :
cert_score       : 0
cipher_score     : 0
cert_status      :
cipher           :
valid_from_utc   : 0000-00-00 00:00:00
valid_until_utc  : 0000-00-00 00:00:00
mixed_content    :
flags            : @{is_extended=False; has_pfs=True; is_broken=False; is_expired=False; is_missing=False; is_revoked=False; has_mixed=False}
contact_groups   : {}
alert_at         : 14,90,120
last_reminder    : 0
alert_reminder   : True
alert_expiry     : True
alert_broken     : True
alert_mixed      : True
last_updated_utc : 0000-00-00 00:00:00
```
A SSL Test can be updated by domain if there are no duplicates as follows:
```powershell
Set-StatusCakeHelperSSLTest -Domain "https://www.example.com" -checkrate 3600 -Alert_At @("14","90","120") -SetByDomain
id               : 123456
checkrate        : 3600
paused           : False
domain           : https://www.example.com
issuer_cn        :
cert_score       : 0
cipher_score     : 0
cert_status      :
cipher           :
valid_from_utc   : 0000-00-00 00:00:00
valid_until_utc  : 0000-00-00 00:00:00
mixed_content    :
flags            : @{is_extended=False; has_pfs=True; is_broken=False; is_expired=False; is_missing=False; is_revoked=False; has_mixed=False}
contact_groups   : {}
alert_at         : 14,90,120
last_reminder    : 0
alert_reminder   : True
alert_expiry     : True
alert_broken     : True
alert_mixed      : True
last_updated_utc : 0000-00-00 00:00:00
```
A new SSL Test can be created via the cmdlet with the following parameters:
```powershell
Set-StatusCakeHelperSSLTest -domain https://www.example.org -CheckRate "3600" -alert_expiry $False -alert_reminder $False -alert_broken $False -Alert_At @("14","90","120")
id               : 234567
checkrate        : 3600
paused           : False
domain           : https://www.example.org
issuer_cn        :
cert_score       : 0
cipher_score     : 0
cert_status      :
cipher           :
valid_from_utc   : 0000-00-00 00:00:00
valid_until_utc  : 0000-00-00 00:00:00
mixed_content    :
flags            : @{is_extended=False; has_pfs=True; is_broken=False; is_expired=False; is_missing=False; is_revoked=False; has_mixed=False}
contact_groups   : {}
alert_at         : 14,90,120
last_reminder    : 0
alert_reminder   : False
alert_expiry     : False
alert_broken     : False
alert_mixed      : False
last_updated_utc : 0000-00-00 00:00:00
```

### Remove-StatusCakeHelperSSLTest
This cmdlet removes a SSL Test via either id or domain of the SSL Test

```powershell
Remove-StatusCakeHelperSSLTest -id 123456
```
To remove by domain specify the domain parameter
```powershell
Remove-StatusCakeHelperSSLTest -Domain "https://www.example.com" -PassThru
id               : 123456
checkrate        : 3600
paused           : False
domain           : https://www.example.com
issuer_cn        :
cert_score       : 0
cipher_score     : 0
cert_status      :
cipher           :
valid_from_utc   : 0000-00-00 00:00:00
valid_until_utc  : 0000-00-00 00:00:00
mixed_content    :
flags            : @{is_extended=False; has_pfs=True; is_broken=False; is_expired=False; is_missing=False; is_revoked=False; has_mixed=False}
contact_groups   : {}
alert_at         : 14,90,120
last_reminder    : 0
alert_reminder   : False
alert_expiry     : False
alert_broken     : False
alert_mixed      : False
last_updated_utc : 0000-00-00 00:00:00
```

# Authors
- Oliver Li