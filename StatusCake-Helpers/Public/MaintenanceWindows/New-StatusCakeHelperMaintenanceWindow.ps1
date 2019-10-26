
<#
.Synopsis
   Create a StatusCake Maintenance Window
.PARAMETER baseMaintenanceWindowURL
    Base URL endpoint of the statuscake Maintenance Window API
.PARAMETER Username
    Username associated with the API key
.PARAMETER ApiKey
    APIKey to access the StatusCake API
.PARAMETER Name
    A descriptive name for the maintenance window
.PARAMETER start_date
    Start date of your window. Can be slightly in the past
.PARAMETER end_date
    End time of your window. Must be in the future
.PARAMETER timezone
    Must be a valid timezone, or UTC
.PARAMETER raw_tests
    Individual tests that should be included
.PARAMETER raw_tags
    Tests with these tags will be included
.PARAMETER recur_every
    How often in days this window should recur. 0 disables this
.PARAMETER follow_dst
    Whether DST should be followed or not
.EXAMPLE
   New-StatusCakeHelperMaintenanceWindow -name "Example Maintenance Window" -start_date $(Get-Date) -end_date $((Get-Date).AddHours(1)) -timezone "Europe/London" -raw_tests @("123456") -verbose
.FUNCTIONALITY
   Creates a new StatusCake Maintenance Window using the supplied parameters. The raw_tests or raw_tags value must be provided to create a new maintenance window.
#>
function New-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='SetByTestTags')]
        [Parameter(ParameterSetName='SetByTestIDs')]
        $baseMaintenanceWindowURL = "https://app.statuscake.com/API/Maintenance/Update",

		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName='SetByTestTags',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTestIDs',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$name,

        [Parameter(ParameterSetName='SetByTestTags',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTestIDs',Mandatory=$true)]
        [datetime]$start_date,

        [Parameter(ParameterSetName='SetByTestTags',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTestIDs',Mandatory=$true)]
        [datetime]$end_date,

        [Parameter(ParameterSetName='SetByTestTags',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTestIDs',Mandatory=$true)]
        [ValidateScript({$_ | Test-StatusCakeHelperTimeZone})]
        [string]$timezone,

        [Parameter(ParameterSetName='SetByTestIDs')]
        [ValidateScript({$_ -match '^[\d]+$'})]
        [object]$raw_tests,

        [Parameter(ParameterSetName='SetByTestTags')]
        [object]$raw_tags,

        [Parameter(ParameterSetName='SetByTestIDs')]
        [Parameter(ParameterSetName='SetByTestTags')]
        [ValidateSet("0","1","7","14","30")]
        $recur_every,

        [Parameter(ParameterSetName='SetByTestIDs')]
        [Parameter(ParameterSetName='SetByTestTags')]
        [ValidateRange(0,1)]
        $follow_dst
    )
    $authenticationHeader = @{"Username"="$Username";"API"="$ApiKey"}
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}

    if($pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Windows"))
    {
        $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow @statusCakeFunctionAuth -name $name -state "PND"
        if($maintenanceWindow)
        {
            if($maintenanceWindow.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Pending Maintenance Windows with the same name [$name] [$($maintenanceWindow.id)]"
            }
            else
            {
                Write-Error "Pending Maintenance Window with specified name already exists [$name]"
            }
            Return $null
        }

    }

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

    $postRequestParams = @{
        uri = $baseMaintenanceWindowURL
        Headers = $authenticationHeader
        UseBasicParsing = $true
        method = "Post"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Add StatusCake Maintenance Window") )
    {
        $jsonResponse = Invoke-WebRequest @postRequestParams
        $response = $jsonResponse | ConvertFrom-Json
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }
        Return $response
    }

}