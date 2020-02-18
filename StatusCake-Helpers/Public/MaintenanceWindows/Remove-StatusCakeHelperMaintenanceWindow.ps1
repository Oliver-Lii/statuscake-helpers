
<#
.Synopsis
   Remove a StatusCake Maintenance Window
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Name
    A descriptive name for the maintenance window
.PARAMETER Id
    The maintenance window ID
.PARAMETER State
    The state of the maintenance window to remove. Required only when removing a MW by name.
.PARAMETER Series
    Set to True to cancel the entire series, false to just cancel the one window
.PARAMETER Passthru
    Return the object to be deleted
.EXAMPLE
   Remove-StatusCakeHelperMaintenanceWindow -ID 123456
.FUNCTIONALITY
   Deletes a StatusCake Maintenance Window using the supplied ID.
#>
function Remove-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [int]$id,

        [Parameter(ParameterSetName = "name")]
        [string]$name,

        [Parameter(ParameterSetName = "name",Mandatory=$true)]
        [ValidateSet("ACT","PND")]
        [string]$state,

        [Parameter(ParameterSetName='ID')]
        [Parameter(ParameterSetName='name')]
        [boolean]$series=0,

        [switch]$PassThru
    )

    $checkParams = @{}
    if($name)
    {
        $checkParams.Add("name",$name)
        $checkParams.Add("state",$state)
    }
    else
    {
        $checkParams.Add("id",$id)
    }

    $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential @checkParams
    if($maintenanceWindow)
    {
        if($maintenanceWindow.GetType().Name -eq 'Object[]')
        {
            Write-Error "Multiple Maintenance Windows found in state [$state] with name [$name]. Please remove the Maintenance Window by ID"
            Return $null
        }
        $id = $maintenanceWindow.id
    }
    else
    {

        Write-Error "Unable to find Maintenance Window in state [$state] with name [$name]"
        Return $null
    }


    $requestParams = @{
        uri = "https://app.statuscake.com/API/Maintenance/Update?id=$id&series=$series"
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