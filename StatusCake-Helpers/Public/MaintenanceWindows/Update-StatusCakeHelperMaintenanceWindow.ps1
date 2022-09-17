
<#
.SYNOPSIS
    Updates a StatusCake Maintenance Window
.DESCRIPTION
    Updates the configuration of StatusCake Maintenance Window using the supplied parameters. You can only update a window which is in a pending state.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Name
    A descriptive name for the maintenance window
.PARAMETER ID
    The maintenance window ID
.PARAMETER StartDate
    Start date of your window. Can be slightly in the past
.PARAMETER EndDate
    End time of your window. Must be in the future
.PARAMETER Timezone
    Must be a valid timezone, or UTC
.PARAMETER UptimeID
    Array of uptime test IDs that should be included
.PARAMETER UptimeTag
    Array of uptime test tags with these tags will be included
.PARAMETER RepeatInterval
    How often in days this window should occur
.EXAMPLE
    C:PS>Update-StatusCakeHelperMaintenanceWindow -ID 123456 -RepeatInterval 1m
    Modify the maintenance window with ID 123456 to recur every month
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/MaintenanceWindows/Update-StatusCakeHelperMaintenanceWindow.md
.LINK
    https://www.statuscake.com/api/v1/#tag/maintenance-windows/operation/update-maintenance-window
#>
function Update-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='ID')]
        [ValidateNotNullOrEmpty()]
        [string]$ID,

        [Parameter(ParameterSetName='Name')]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Alias('start_at','start_date','start_unix')]
        [datetime]$StartDate,

        [Alias('end_at','end_date','end_unix')]
        [datetime]$EndDate,

        [ValidateScript({$_ | Test-StatusCakeHelperTimeZone})]
        [string]$Timezone,

        [Alias('tests','raw_tests','TestIDs')]
        [int[]]$UptimeID,

        [Alias('tags','raw_tags','TestTags')]
        [string[]]$UptimeTag,

        [ValidateSet("never","1d","1w","2w","1m")]
        [Alias('repeat_interval')]
        [string]$RepeatInterval

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
           Write-Error "Multiple maintenance windows found with name [$Name]. Please update the maintenance window by ID"
           Return $null
       }
       $ID = $statusCakeItem.id
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude @("Force","Name","ID")  | ConvertTo-StatusCakeHelperAPIValue

    if( $pscmdlet.ShouldProcess("$ID", "Update StatusCake Maintenance Window") )
    {
        Return (Update-StatusCakeHelperItem -APICredential $APICredential -Type Maintenance-Windows -ID $ID -Parameter $statusCakeAPIParams)
    }

}