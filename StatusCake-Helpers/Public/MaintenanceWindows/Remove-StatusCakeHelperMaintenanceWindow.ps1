
<#
.SYNOPSIS
   Remove a StatusCake Maintenance Window
.DESCRIPTION
    Deletes a StatusCake Maintenance Window using the supplied ID or name.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    The maintenance window ID
.PARAMETER Name
    Name of the maintenance window to remove
.EXAMPLE
    C:\PS>Remove-StatusCakeHelperMaintenanceWindow -ID 123456
    Remove the maintenance window with id 123456
.EXAMPLE
    C:\PS>Remove-StatusCakeHelperMaintenanceWindow -ID 123456 -Name "Example Maintenance Window"
    Remove the maintenance window with name "Example Maintenance Window"
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/MaintenanceWindows/Remove-StatusCakeHelperMaintenanceWindow.md
.LINK
    https://www.statuscake.com/api/v1/#tag/maintenance-windows/operation/delete-maintenance-window
#>
function Remove-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [int]$ID,

        [Parameter(ParameterSetName = "name")]
        [string]$Name
    )

    if($Name)
    {
       $statusCakeItem = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -Name $Name
       if(!$statusCakeItem)
       {
            Write-Error "No maintenance window(s) found with name [$Name]"
            Return $null
       }
       elseif($statusCakeItem.GetType().Name -eq 'Object[]')
       {
           Write-Error "Multiple maintenance windows found with name [$Name]. Please delete the maintenance window by ID"
           Return $null
       }
       $ID = $statusCakeItem.id
    }

    if( $pscmdlet.ShouldProcess("$ID", "Remove StatusCake Maintenance Window") )
    {
        Return (Remove-StatusCakeHelperItem -APICredential $APICredential -Type Maintenance-Windows -ID $ID)
    }
}