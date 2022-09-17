
<#
.SYNOPSIS
    Gets a StatusCake Maintenance Window
.DESCRIPTION
    Retrieves StatusCake Maintenance Windows. If no id or name is supplied all maintenance windows are returned. Results can be filtered by maintenance window state.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Name
    Name of the maintenance window to retrieve
.PARAMETER ID
    ID of the maintenance window to retrieve
.PARAMETER State
    Filter results based on state. Valid options are pending, active, and paused
.EXAMPLE
    C:\PS>Get-StatusCakeHelperMaintenanceWindow
    Get all maintenance windows
.EXAMPLE
    C:\PS>Get-StatusCakeHelperMaintenanceWindow -State pending
    Get all maintenance windows in a pending state
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/MaintenanceWindows/Get-StatusCakeHelperMaintenanceWindow.md
.LINK
    https://www.statuscake.com/api/v1/#operation/list-maintenance-windows
.LINK
    https://www.statuscake.com/api/v1/#operation/get-maintenance-window
.OUTPUTS
    Returns StatusCake Maintenance Windows as an object
#>
function Get-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,DefaultParameterSetName='all')]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "all")]
        [ValidateSet("active","paused","pending")]
        [string]$State,

        [Parameter(ParameterSetName = "Name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID
    )

    if($State)
    {
        $parameter = $State | ConvertTo-StatusCakeHelperAPIValue
        $itemParameters["Parameter"] = $parameter
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "Maintenance-Windows" -Parameter $parameter
    }
    elseif($Name)
    {
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "Maintenance-Windows" | Where-Object{$_.name -eq $Name}
    }
    elseif($ID)
    {
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "Maintenance-Windows" -ID $ID
    }
    else
    {
        $statusCakeItem = Get-StatusCakeHelperItem -APICredential $APICredential -Type "Maintenance-Windows"
    }

    Return $statusCakeItem

}
