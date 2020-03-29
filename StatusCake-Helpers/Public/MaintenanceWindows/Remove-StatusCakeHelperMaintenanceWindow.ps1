
<#
.SYNOPSIS
   Remove a StatusCake Maintenance Window
.DESCRIPTION
    Deletes a StatusCake Maintenance Window using the supplied ID or name. If the series switch is not provided then the next window scheduled under the ID will be removed.
    The entire series of windows can be removed if the series switch is provided.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Name
    A descriptive name for the maintenance window
.PARAMETER ID
    The maintenance window ID
.PARAMETER State
    The state of the maintenance window to remove. Required only when removing a MW by name.
.PARAMETER Series
    Set flag to cancel the entire series of maintenance windows instead of cancelling the one window
.PARAMETER Passthru
    Return the object to be deleted
.EXAMPLE
    C:\PS>Remove-StatusCakeHelperMaintenanceWindow -ID 123456
    Remove the next pending maintenance window under id 123456
.EXAMPLE
    C:\PS>Remove-StatusCakeHelperMaintenanceWindow -ID 123456 -Series
    Remove the series of maintenance windows scheduled under id 123456

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
        [string]$Name,

        [Parameter(ParameterSetName = "name",Mandatory=$true)]
        [ValidateSet("ACT","PND")]
        [string]$State,

        [Parameter(ParameterSetName='ID')]
        [Parameter(ParameterSetName='name')]
        [switch]$Series,

        [switch]$PassThru
    )

    $checkParams = @{}
    if($Name)
    {
        $checkParams.Add("Name",$Name)
        $checkParams.Add("State",$State)
    }
    else
    {
        $checkParams.Add("ID",$ID)
    }

    $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential @checkParams
    if($maintenanceWindow)
    {
        if($maintenanceWindow.GetType().Name -eq 'Object[]')
        {
            Write-Error "Multiple Maintenance Windows found in state [$State] with name [$Name]. Please remove the Maintenance Window by ID"
            Return $null
        }
        $ID = $maintenanceWindow.id
    }
    else
    {

        Write-Error "Unable to find Maintenance Window in state [$State] with name [$Name]"
        Return $null
    }

    $allSeries = 0
    If($Series)
    {
        $allSeries = 1
    }

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Maintenance/Update?id=$ID&series=$allSeries"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Delete"
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Remove StatusCake Maintenance Window") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams=@{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
        }
        elseif($PassThru)
        {
            Return $maintenanceWindow
        }
    }
}