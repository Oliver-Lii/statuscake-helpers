
<#
.Synopsis
   Gets all StatusCake Maintenance Windows in specific state
.PARAMETER baseMaintenanceWindowURL
    Base URL endpoint of the statuscake Maintenance Window API
.PARAMETER Username
    Username associated with the API key
.PARAMETER ApiKey
    APIKey to access the StatusCake API
.PARAMETER State
    Filter results based on state
.EXAMPLE
   Get-StatusCakeHelperAllMaintenanceWindows -Username "Username" -ApiKey "APIKEY"
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

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [ValidateSet("ALL","PND","ACT","END","CNC")]
        [string]$state="ALL"
    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}

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

