
<#
.Synopsis
   Updates a StatusCake Maintenance Window
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Name
    A descriptive name for the maintenance window
.PARAMETER Id
    The maintenance window ID
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
   Update-StatusCakeHelperMaintenanceWindow -Username "Username" -ApiKey "APIKEY" -id 123456 -checkrate 3600
.FUNCTIONALITY
   Updates the configuration of StatusCake Maintenance Window using the supplied parameters. You can only update a window which is in a pending state.
#>
function Update-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='SetByID')]
        [ValidateNotNullOrEmpty()]
        [string]$id,

        [Parameter(ParameterSetName='SetByName')]
        [ValidateNotNullOrEmpty()]
        [string]$name,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Alias('start_unix')]
        [datetime]$start_date,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Alias('end_unix')]
        [datetime]$end_date,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [string]$timezone,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [ValidateScript({$_ -match '^[\d]+$'})]
        [int[]]$raw_tests,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [string[]]$raw_tags,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [ValidateSet("0","1","7","14","30")]
        [int]$recur_every,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [boolean]$follow_dst

    )

    if($name)
    {   #If setting test by name verify if a test or tests with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Windows"))
        {
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -name $name -state "PND"
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
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -id $id -state "PND"
            if(!$maintenanceWindow)
            {
                Write-Error "No pending Maintenance Window with specified ID exists [$id]"
                Return $null
            }
            $id = $maintenanceWindow.id
        }
    }

    $exclude = @("Name")
    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude $exclude
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Maintenance/Update"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Post"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Set StatusCake Maintenance Window") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams=@{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }
        else
        {
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -id $id
        }
        Return $maintenanceWindow
    }

}