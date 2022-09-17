
<#
.SYNOPSIS
    Clears the tests associated with a StatusCake Maintenance Window
.DESCRIPTION
    Clears the tests and/or tags associated with a pending StatusCake Maintenance Window. You can only clear the test IDs/tags for a window which is in a pending state.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Name
    Name of the maintenance window to clear the tests from
.PARAMETER ID
    The maintenance window ID
.PARAMETER UptimeID
    Flag to clear all tests included in a maintenance window
.PARAMETER UptimeTag
    Flag to clear all tags of the tests to be included in a maintenance window
.EXAMPLE
    C:\PS>Clear-StatusCakeHelperMaintenanceWindow -ID 123456 -TestIDs
    Clear all test IDs associated with maintenance window 123456
.EXAMPLE
    C:\PS>Clear-StatusCakeHelperMaintenanceWindow -ID 123456 -TestTags
    Clear all test tags associated with maintenance window 123456
#>
function Clear-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='ByID',Mandatory=$true)]
        [Parameter(ParameterSetName='TestIDs',Mandatory=$true)]
        [Parameter(ParameterSetName='TestTags',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$ID,

        [Parameter(ParameterSetName='ByName',Mandatory=$true)]
        [Parameter(ParameterSetName='TestIDs',Mandatory=$true)]
        [Parameter(ParameterSetName='TestTags',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(ParameterSetName='TestIDs',Mandatory=$true)]
        [Parameter(ParameterSetName='ByID')]
        [Parameter(ParameterSetName='ByName')]
        [Alias('tests','raw_tests','TestIDs')]
        [switch]$UptimeID,

        [Parameter(ParameterSetName='TestTags',Mandatory=$true)]
        [Parameter(ParameterSetName='ByID')]
        [Parameter(ParameterSetName='ByName')]
        [Alias('tags','raw_tags','TestTags')]
        [switch]$UptimeTag
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

    if($UptimeID)
    {
        $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
        $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude @("Name","ID") -Clear "UptimeID"
    }
    elseif($UptimeTag)
    {
        $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
        $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude @("Name","ID") -Clear "UptimeTag"
    }
    Write-Verbose "[$($allParameterValues.keys)] [$($allParameterValues.values)]"
    Write-Verbose "[$($statusCakeAPIParams.keys)] [$($statusCakeAPIParams.values)]"
    if( $pscmdlet.ShouldProcess("StatusCake API", "Clear Value From StatusCake Test"))
    {
        Return (Update-StatusCakeHelperItem -APICredential $APICredential -Type Maintenance-Windows -ID $ID -Parameter $statusCakeAPIParams)
    }
}