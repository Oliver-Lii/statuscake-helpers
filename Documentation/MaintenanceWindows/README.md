# Maintenance Windows


### Get-StatusCakeHelperMaintenanceWindow
This cmdlet retrieves StatusCake Maintenance Windows by id or name in a specific state. If no id or name is supplied all maintenance windows will be returned.

```powershell
Get-StatusCakeHelperMaintenanceWindow -ID 123456 -State ACT

id          : 123456
name        : Maintenance Window
start_utc   : 2020-01-01 00:00:00
end_utc     : 2020-01-02 00:00:00
recur_every : 0
all_tests   : {1234567}
raw_tests   : {1234567}
raw_tags    : {}
state       : Active
timezone    : UTC
follow_dst  : True
```


### New-StatusCakeHelperMaintenanceWindow
This cmdlet creates a new maintenance window. The cmdlet tests to see if the name of the maintenance window to be created already matches an existing pending maintenance window.
Mandatory parameters are illustrated in the example below:

```powershell
New-StatusCakeHelperMaintenanceWindow -name "Example 1 Day Maintenance Window" -StartDate $(Get-Date) -EndDate $((Get-Date).AddDays(1)) -timezone "Europe/London" -TestIDs @("123456","234567")
id          : 123456
name        : Example 1 Day Maintenance Window
start_utc   : 2020-01-01 00:00:00
end_utc     : 2020-01-02 00:00:00
recur_every : 0
all_tests   : {1234567,234567}
raw_tests   : {1234567,234567}
raw_tags    : {}
state       : Active
timezone    : UTC
follow_dst  : True
```

### Update-StatusCakeHelperMaintenanceWindow
This cmdlet sets the configuration of a specific pending maintenance window.

```powershell
Update-StatusCakeHelperMaintenanceWindow -ID 123456 -RecurEvery 7
id          : 123456
name        : Example 1 Day Maintenance Window
start_utc   : 2020-01-01 00:00:00
end_utc     : 2020-01-02 00:00:00
recur_every : 7
all_tests   : {1234567,234567}
raw_tests   : {1234567,234567}
raw_tags    : {}
state       : Active
timezone    : UTC
follow_dst  : True
```
A pending maintenance window can be updated by name if there are no duplicates as follows:
```powershell
Update-StatusCakeHelperMaintenanceWindow -name "Example 1 Day Maintenance Window" -RecurEvery 7
id          : 123456
name        : Example 1 Day Maintenance Window
start_utc   : 2020-01-01 00:00:00
end_utc     : 2020-01-02 00:00:00
recur_every : 7
all_tests   : {1234567,234567}
raw_tests   : {1234567,234567}
raw_tags    : {}
state       : Active
timezone    : UTC
follow_dst  : True
```

### Clear-StatusCakeHelperMaintenanceWindow
This cmdlet clears the tests and/or tags associated with a pending StatusCake Maintenance Window

```powershell
Clear-StatusCakeHelperMaintenanceWindow -ID 123456 -TestIDs
```

### Remove-StatusCakeHelperMaintenanceWindow
This cmdlet removes a maintenance window via either id or name of the maintenance window. By default a single window will be cancelled if the series parameter is not supplied.

```powershell
Remove-StatusCakeHelperMaintenanceWindow -ID 123456
```
To remove by name specify the name parameter along with the state of the maintenance window to be removed.
```powershell
Remove-StatusCakeHelperMaintenanceWindow -name "Example Maintenance Window" -state PND -PassThru
id          : 123456
name        : Example Maintenance Window
start_utc   : 2020-01-01 00:00:00
end_utc     : 2020-01-02 00:00:00
recur_every : 7
all_tests   : {1234567,234567}
raw_tests   : {1234567,234567}
raw_tags    : {}
state       : Pending
timezone    : UTC
follow_dst  : True
```

# Authors
- Oliver Li