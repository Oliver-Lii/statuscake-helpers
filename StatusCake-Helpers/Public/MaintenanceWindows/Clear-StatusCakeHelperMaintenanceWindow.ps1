
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
.PARAMETER TestIDs
    Flag to clear all tests included in a maintenance window
.PARAMETER TestTags
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
        [Alias('raw_tests')]
        [switch]$TestIDs,

        [Parameter(ParameterSetName='TestTags',Mandatory=$true)]
        [Parameter(ParameterSetName='ByID')]
        [Parameter(ParameterSetName='ByName')]
        [Alias('raw_tags')]
        [switch]$TestTags
    )

    if($Name)
    {   #If setting test by name verify if a test or tests with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Windows"))
        {
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -name $Name -state "PND"
            if(!$maintenanceWindow)
            {
                Write-Error "No pending Maintenance Window with specified name exists [$Name]"
                Return $null
            }
            elseif($maintenanceWindow.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Pending Maintenance Windows with the same name [$Name] [$($maintenanceWindow.id)]"
                Return $null
            }
            $ID = $maintenanceWindow.id
        }
    }
    elseif($ID)
    {   #If setting by id verify that id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Windows"))
        {
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -ID $ID -state "PND"
            if(!$maintenanceWindow)
            {
                Write-Error "No pending Maintenance Window with specified ID exists [$ID]"
                Return $null
            }
            $ID = $maintenanceWindow.id
        }
    }

    $clearItems = @{}
    if($TestIDs){$clearItems["raw_tests"]=@()}
    if($TestTags){$clearItems["raw_tags"]=""}

    if( $pscmdlet.ShouldProcess("StatusCake API", "Clear Value From StatusCake Test"))
    {
        $result = Update-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -ID $ID @clearItems
        if($PassThru)
        {
            Return $result
        }
    }
}