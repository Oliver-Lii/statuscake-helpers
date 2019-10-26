
<#
.Synopsis
   Remove a StatusCake Maintenance Window
.PARAMETER baseMaintenanceWindowURL
    Base URL endpoint of the statuscake Maintenance Window API
.PARAMETER Username
    Username associated with the API key
.PARAMETER ApiKey
    APIKey to access the StatusCake API
.PARAMETER Name
    A descriptive name for the maintenance window
.PARAMETER Id
    The maintenance window ID
.PARAMETER State
    The state of the maintenance window to remove. Required only when removing a MW by name.
.PARAMETER Series
    Set to True to cancel the entire series, false to just cancel the one window
.EXAMPLE
   Remove-StatusCakeHelperMaintenanceWindow -Username "Username" -ApiKey "APIKEY" -ID 123456
.FUNCTIONALITY
   Deletes a StatusCake Maintenance Window using the supplied ID.
#>
function Remove-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        $baseMaintenanceWindowURL = "https://app.statuscake.com/API/Maintenance/Update?id=",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName = "ID")]
        [int]$id,

        [Parameter(ParameterSetName = "name")]
        [string]$name,

        [Parameter(ParameterSetName = "name",Mandatory=$true)]
        [ValidateSet("ACT","PND")]
        [string]$state,

        [Parameter(ParameterSetName='ID')]
        [Parameter(ParameterSetName='name')]
        [ValidateRange(0,1)]
        $series=0,

        [switch]$PassThru
    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}

    if($name)
    {
        $MaintenanceWindow = Get-StatusCakeHelperMaintenanceWindow @statusCakeFunctionAuth -name $name -state $state
        if($MaintenanceWindow)
        {
            if($MaintenanceWindow.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Maintenance Windows found in state [$state] with name [$name]. Please remove the Maintenance Window by ID"
                Return $null
            }
            $id = $MaintenanceWindow.id
        }
        else
        {

            Write-Error "Unable to find Maintenance Window in state [$state] with name [$name]"
            Return $null
        }
    }

    $webRequestParams = @{
        uri = "$baseMaintenanceWindowURL$id&series=$series"
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Delete"
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Remove StatusCake Maintenance Window") )
    {
        $jsonResponse = Invoke-WebRequest @webRequestParams
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Verbose $response
            Write-Error "$($response.Message) [$($response.Issues)]"
        }
        if(!$PassThru)
        {
            Return
        }
        Return $response
    }

}