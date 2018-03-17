
<#
.Synopsis
   Remove a StatusCake MaintenanceWindow Test
.EXAMPLE
   Remove-StatusCakeHelperMaintenanceWindow -Username "Username" -ApiKey "APIKEY" -ID 123456
.INPUTS
    baseMaintenanceWindowURL - Base URL endpoint of the statuscake ContactGroup API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    
    ID - ID of the Maintenance Window to remove
    Name - Name of the Maintenance Window
    State - The state of the maintenance window to remove. Required only when removing a MW by name.
    Series - True to cancel the entire series, false to just cancel the one window

.FUNCTIONALITY
   Deletes a StatusCake Maintenance Window using the supplied ID.
#>
function Remove-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(
        $baseMaintenanceWindowURL = "https://app.statuscake.com/API/Maintenance/Update?id=",

        [Parameter(Mandatory=$true)]        
        $Username,        

        [Parameter(Mandatory=$true)]        
        $ApiKey,

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
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}
 
    if($name)
    {
        $MaintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -Username $username -apikey $ApiKey -name $name -state $state
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