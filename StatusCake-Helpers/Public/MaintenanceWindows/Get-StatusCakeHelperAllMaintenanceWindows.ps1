
<#
.Synopsis
   Gets all StatusCake Maintenance Windows in specific state
.EXAMPLE
   Get-StatusCakeHelperAllMaintenanceWindows -Username "Username" -ApiKey "APIKEY"
.INPUTS
    baseMaintenanceWindowURL - Base URL endpoint of the statuscake auth API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API

    State - Filter tests based on state. 
.OUTPUTS    
    Returns all the StatusCake Maintenance Windows as an object
.FUNCTIONALITY
    Retrieves all Maintenance Windows in a specific state from StatusCake
   
#>
function Get-StatusCakeHelperAllMaintenanceWindows
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]    
    Param(
        $baseMaintenanceWindowURL = "https://app.statuscake.com/API/Maintenance/",
        [Parameter(Mandatory=$true)]        
        $Username,
        [Parameter(Mandatory=$true)]        
        $ApiKey,

        [ValidateSet("ALL","PND","ACT","END","CNC")]
        [string]$state="ALL"   
    )
    $authenticationHeader = @{"Username"="$username";"API"="$ApiKey"}

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("baseMaintenanceWindowURL","Username","ApiKey")
    foreach ($key in $ParameterList.keys)
    {
        $var = Get-Variable -Name $key -ErrorAction SilentlyContinue;
        if($ParamsToIgnore -contains $var.Name)
        {
            continue
        }
        elseif($var.value -or $var.value -eq 0)
        {
            $psParams.Add($var.name,$var.value)                  
        }
    }

    $statusCakeAPIParams = $psParams | ConvertTo-StatusCakeHelperAPIParams

    $webRequestParams = @{
        uri = $baseMaintenanceWindowURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams 
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Window") )
    {
        $jsonResponse = Invoke-WebRequest @webRequestParams
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Verbose $response
            Write-Error "$($response.Message) [$($response.Issues)]"
        }         
    
        if($response)
        {
            Return $response.data
        }
    
        Return $null
    }
}
