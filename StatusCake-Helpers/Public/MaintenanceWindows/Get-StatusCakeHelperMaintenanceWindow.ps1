
<#
.Synopsis
   Gets a StatusCake Maintenance Window
.PARAMETER baseMaintenanceWindowURL
    Base URL endpoint of the statuscake Maintenance Window API
.PARAMETER Username
    Username associated with the API key
.PARAMETER ApiKey
    APIKey to access the StatusCake API
.PARAMETER Name
    Name of the maintenance window to retrieve
.PARAMETER ID
    ID of the maintenance window to retrieve
.PARAMETER State
    Filter results based on state
.EXAMPLE
   Get-StatusCakeHelperMaintenanceWindow -Username "Username" -ApiKey "APIKEY" -id 123456
.OUTPUTS
    Returns StatusCake Maintenance Windows as an object
.FUNCTIONALITY
    Retrieves StatusCake Maintenance Windows by id or state.

#>
function Get-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName = "Name")]
        [Parameter(ParameterSetName = "ID")]
        $baseMaintenanceWindowURL = "https://app.statuscake.com/API/Maintenance/",

        [Parameter(ParameterSetName = "Name")]
        [Parameter(ParameterSetName = "ID")]
		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [Parameter(ParameterSetName = "Name")]
        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName = "Name")]
        [Parameter(ParameterSetName = "ID")]
        [ValidateSet("ALL","PND","ACT","END","CNC")]
        [string]$state,

        [Parameter(ParameterSetName = "Name")]
        [ValidateNotNullOrEmpty()]
        [string]$name,

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$id
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

        if($name)
        {
            $matchingTests = $response.data | Where-Object {$_.name -eq $name}
        }
        elseif($id)
        {
            $matchingTests = $response.data | Where-Object {$_.id -eq $id}
        }

        if($matchingTests)
        {
            Return $matchingTests
        }

        Return $null
    }

}

