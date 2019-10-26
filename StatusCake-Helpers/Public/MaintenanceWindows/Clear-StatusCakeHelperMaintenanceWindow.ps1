
<#
.Synopsis
   Clears the tests associated with a StatusCake Maintenance Window
.PARAMETER baseMaintenanceWindowURL
    Base URL endpoint of the statuscake Maintenance Window API
.PARAMETER Username
    Username associated with the API key
.PARAMETER ApiKey
    APIKey to access the StatusCake API
.PARAMETER Name
    Name of the maintenance window to clear the tests from
.PARAMETER ByName
    Flag to set if you want to clear tests by test name
.PARAMETER Id
    The maintenance window ID
.PARAMETER raw_tests
    Flag to clear all tests included in a maintenance window
.PARAMETER raw_tags
    Flag to clear all tags of the tests to be included in a maintenance window
.EXAMPLE
   Clear-StatusCakeHelperMaintenanceWindow -Username "Username" -ApiKey "APIKEY" -id 123456 -raw_tests
.FUNCTIONALITY
   Clears the tests and/or tags associated with a pending StatusCake Maintenance Window. You can only clear the tests for a window which is in a pending state.
#>
function Clear-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        $baseMaintenanceWindowURL = "https://app.statuscake.com/API/Maintenance/Update",

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName='SetByName',Mandatory=$true)]
        [switch]$ByName,

        [Parameter(ParameterSetName='SetByID')]
        [ValidateNotNullOrEmpty()]
        [string]$id,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [string]$name,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [switch]$raw_tests,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [switch]$raw_tags
    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}

    if($SetByName -and $name)
    {   #If setting test by name verify if a test or tests with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Windows"))
        {
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow @statusCakeFunctionAuth -name $name -state "PND"
            if(!$maintenanceWindow)
            {
                Write-Error "No pending Maintenance Window with specified name exists [$name]"
                Return $null
            }
            elseif($maintenanceWindow.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Pending Maintenance Windows with the same name [$name] [$($maintenanceWindow.id)]"
                Return $null
            }
            $id = $maintenanceWindow.id
        }
    }
    elseif($id)
    {   #If setting by id verify that id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Windows"))
        {
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow @statusCakeFunctionAuth -id $id -state "PND"
            if(!$maintenanceWindow)
            {
                Write-Error "No pending Maintenance Window with specified ID exists [$id]"
                Return $null
            }
            $id = $maintenanceWindow.id
        }
    }

    If(!$raw_tests -and !$raw_tags)
    {
        Write-Error "Please set the switch to clear tests or tags from the maintenance window"
        Return
    }

    $psParams = @{}
    $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters
    $ParamsToIgnore = @("baseMaintenanceWindowURL","Username","ApiKey","Name","ByName")
    foreach ($key in $ParameterList.keys)
    {
        $var = Get-Variable -Name $key -ErrorAction SilentlyContinue;
        if($ParamsToIgnore -contains $var.Name)
        {
            continue
        }
        elseif($var.Name -eq "id")
        {
            $psParams.Add($var.name,$var.value)
        }
        elseif($var.value -eq $true)
        {   #Send empty field name to clear value for field
            $psParams.Add($var.name,"")
        }
    }

    $putRequestParams = @{
        uri = $baseMaintenanceWindowURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Post"
        ContentType = "application/x-www-form-urlencoded"
        body = $psParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Set StatusCake Maintenance Window") )
    {
        $jsonResponse = Invoke-WebRequest @putRequestParams
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }
        Return $response
    }

}