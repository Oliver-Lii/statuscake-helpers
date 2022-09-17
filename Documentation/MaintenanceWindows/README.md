# Maintenance Windows


### Get-StatusCakeHelperMaintenanceWindow
This cmdlet retrieves StatusCake Maintenance Windows by id or name in a specific state. If no id or name is supplied all maintenance windows will be returned.

```powershell
Get-StatusCakeHelperMaintenanceWindow

id              : 123456
name            : Maintenance Window
start_at        : 2022-01-01T02:00:00+00:00
end_at          : 2022-01-01T02:20:00+00:00
repeat_interval : 1w
tests           : {12345678}
tags            : {}
state           : pending
timezone        : UTC
```


### New-StatusCakeHelperMaintenanceWindow
This cmdlet creates a new maintenance window. The cmdlet tests to see if the name of the maintenance window to be created already matches an existing pending maintenance window. Only the ID of the maintenance window is returned and to return the maintenance window specify the PassThru switch.


```powershell
New-StatusCakeHelperMaintenanceWindow -Name "Example Maintenance Window" -StartDate $(Get-Date) -EndDate $((Get-Date).AddHours(1)) -Timezone "Europe/London" -TestIDs @("123456") -PassThru
id              : 123456
name            : Maintenance Window
start_at        : 2022-01-01T02:00:00+00:00
end_at          : 2022-01-01T02:20:00+00:00
repeat_interval :
tests           : {12345678}
tags            : {}
state           : pending
timezone        : UTC
```

Specify the RepeatInterval argument to set the re-occurrence of the maintenance window.

```powershell
New-StatusCakeHelperMaintenanceWindow -Name "Example Maintenance Window" -StartDate $(Get-Date) -EndDate $((Get-Date).AddHours(1)) -Timezone "Europe/London" -TestIDs @("123456") -RepeatInterval 1w -PassThru
id              : 123456
name            : Maintenance Window
start_at        : 2022-01-01T02:00:00+00:00
end_at          : 2022-01-01T02:20:00+00:00
repeat_interval : 1w
tests           : {12345678}
tags            : {}
state           : pending
timezone        : UTC
```

### Update-StatusCakeHelperMaintenanceWindow
This cmdlet sets the configuration of a specific pending maintenance window.

```powershell
Update-StatusCakeHelperMaintenanceWindow -ID 123456 -RepeatInterval 1w
```

### Remove-StatusCakeHelperMaintenanceWindow
This cmdlet removes a maintenance window via either id or name of the maintenance window.

```powershell
Remove-StatusCakeHelperMaintenanceWindow -ID 123456
```
To remove by name specify the name parameter along with the state of the maintenance window to be removed.
```powershell
Remove-StatusCakeHelperMaintenanceWindow -name "Example Maintenance Window"
```

# Authors
- Oliver Li