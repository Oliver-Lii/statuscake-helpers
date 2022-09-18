
<#
.SYNOPSIS
    Create a StatusCake Maintenance Window
.DESCRIPTION
    Creates a new StatusCake Maintenance Window using the supplied parameters. Tests can be included in the maintenance window by either supplying the uptime test IDs or uptime test tags.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Name
    A descriptive name for the maintenance window
.PARAMETER StartDate
    Start date of the maintenance window.
.PARAMETER EndDate
    End time of your window. Must be in the future
.PARAMETER Timezone
    Must be a valid timezone, or UTC
.PARAMETER UptimeID
    Array of uptime test IDs that should be included
.PARAMETER UptimeTag
    Array of uptime test tags with these tags will be included
.PARAMETER RepeatInterval
    How often this window should occur
.PARAMETER Force
    Force creation of the maintenance window even if a window with the same name already exists
.PARAMETER Passthru
    Return the maintenance window details instead of the maintenance window id
.EXAMPLE
    C:\PS>New-StatusCakeHelperMaintenanceWindow -Name "Example Maintenance Window" -StartDate $(Get-Date) -EndDate $((Get-Date).AddHours(1)) -Timezone "Europe/London" -TestIDs @("123456")
    Create a maintenance window called "Example Maintenance Window" starting today and ending in one hour in the Europe/London timezone for test ID 123456
.EXAMPLE
    C:\PS>New-StatusCakeHelperMaintenanceWindow -Name "Example Maintenance Window" -StartDate $(Get-Date) -EndDate $((Get-Date).AddHours(1)) -Timezone "Europe/London" -TestTags @("Tag1","Tag2")
    Create a maintenance window called "Example Maintenance Window" starting today and ending in one hour in the Europe/London timezone including tests which have tags "Tag1" and "Tag2"
.EXAMPLE
    C:\PS>New-StatusCakeHelperMaintenanceWindow -Name "Example Maintenance Window" -StartDate $(Get-Date) -EndDate $((Get-Date).AddHours(1)) -Timezone "Europe/London" -TestIDs @("123456") -RecurEvery 7
    Create a maintenance window called "Example Maintenance Window" starting today and ending in one hour in the Europe/London timezone for test ID 123456 recurring every 7 day
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/MaintenanceWindows/New-StatusCakeHelperMaintenanceWindow.md
.LINK
    https://www.statuscake.com/api/v1/#tag/maintenance-windows/operation/create-maintenance-window
#>
function New-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory=$true)]
        [Alias('start_at','start_date','start_unix')]
        [datetime]$StartDate,

        [Parameter(Mandatory=$true)]
        [Alias('end_at','end_date','end_unix')]
        [datetime]$EndDate,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Timezone,

        [ValidateNotNullOrEmpty()]
        [Alias('tests','raw_tests','TestIDs')]
        [int[]]$UptimeID,

        [ValidateNotNullOrEmpty()]
        [Alias('tags','raw_tags','TestTags')]
        [string[]]$UptimeTag,

        [ValidateSet("never","1d","1w","2w","1m")]
        [Alias('repeat_interval')]
        [string]$RepeatInterval,

        [switch]$Force,

        [switch]$PassThru
    )

    #If force flag not set then check if an existing item with the same name already exists
    if(!$Force)
    {
       $statusCakeItem = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -Name $Name
       if($statusCakeItem)
       {
            Write-Error "Existing maintenance window(s) found with name [$Name]. Please use a different name for the check or use the -Force argument"
            Return $null
       }
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude @("Force","PassThru") | ConvertTo-StatusCakeHelperAPIValue

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake Maintenance Window") )
    {
        Return (New-StatusCakeHelperItem -APICredential $APICredential -Type Maintenance-Windows -Parameter $statusCakeAPIParams -PassThru:$PassThru)
    }

}