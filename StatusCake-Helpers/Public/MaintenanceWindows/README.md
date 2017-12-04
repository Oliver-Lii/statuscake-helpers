# Maintenance Windows

### Get-StatusCakeHelperAllMaintenanceWindows
This cmdlet retrieves all Maintenance Windows

```powershell
Get-StatusCakeHelperAllMaintenanceWindows @StatusCakeAuth
```
![Get-StatusCakeHelperAllMaintenanceWindows](https://user-images.githubusercontent.com/30263630/33572313-7979945e-d92a-11e7-83e3-b970908318c3.png)

### Get-StatusCakeHelperMaintenanceWindow
This cmdlet retrieves a specific StatusCake Maintenance Window by id or name in a specific state.

```powershell
Get-StatusCakeHelperMaintenanceWindow @StatusCakeAuth -id 123456 -state PND
```
![Get-StatusCakeHelperMaintenanceWindow](https://user-images.githubusercontent.com/30263630/33572353-9786deac-d92a-11e7-827e-d40383bf3184.png)

### New-StatusCakeHelperMaintenanceWindow
This cmdlet creates a new maintenance window. The cmdlet tests to see if the name of the maintenance window to be created already matches an existing pending maintenance window. 
Mandatory parameters are illustrated in the example below:

```powershell
New-StatusCakeHelperMaintenanceWindow @StatusCakeAuth -name "Example 1 Day Maintenance Window" -start_date $(Get-Date) -end_date $((Get-Date).AddDays(1)) -timezone "Europe/London" -raw_tests @("123456","234567") -verbose
```

### Update-StatusCakeHelperMaintenanceWindow
This cmdlet sets the configuration of a specific pending maintenance window.

```powershell
Update-StatusCakeHelperMaintenanceWindow @StatusCakeAuth -id 123456 -recur_every 7 
```
A pending maintenance window can be updated by name if there are no duplicates as follows:
```powershell
Update-StatusCakeHelperMaintenanceWindow @StatusCakeAuth -name "Example 1 Day Maintenance Window" -SetByName -recur_every 7
```

### Remove-StatusCakeHelperMaintenanceWindow
This cmdlet removes a maintenance window via either id or name of the maintenance window. By default a single window will be cancelled if the series parameter is not supplied.

```powershell
Remove-StatusCakeHelperMaintenanceWindow @StatusCakeAuth -id 123456 -PassThru -Verbose
```
To remove by name specify the name parameter along with the state of the maintenance window to be removed.
```powershell
Remove-StatusCakeHelperMaintenanceWindow @StatusCakeAuth -name "Example Maintenance Window" -state PND -PassThru -Verbose
```

# Authors
- Oliver Li