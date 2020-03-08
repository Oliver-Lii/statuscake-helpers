
<#
.Synopsis
   Updates a StatusCake Maintenance Window
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Name
    A descriptive name for the maintenance window
.PARAMETER ID
    The maintenance window ID
.PARAMETER StartDate
    Start date of your window. Can be slightly in the past
.PARAMETER EndDate
    End time of your window. Must be in the future
.PARAMETER Timezone
    Must be a valid timezone, or UTC
.PARAMETER TestIDs
    Individual tests that should be included
.PARAMETER TestTags
    Tests with these tags will be included
.PARAMETER RecurEvery
    How often in days this window should recur. 0 disables this
.PARAMETER FollowDST
    Whether DST should be followed or not
.EXAMPLE
   Update-StatusCakeHelperMaintenanceWindow -ID 123456 -RecurEvery 30
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
        [string]$ID,

        [Parameter(ParameterSetName='SetByName')]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Alias('start_unix','start_date')]
        [datetime]$StartDate,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Alias('end_unix','end_date')]
        [datetime]$EndDate,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [string]$Timezone,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Alias('raw_tests')]
        [int[]]$TestIDs,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Alias('raw_tags')]
        [string[]]$TestTags,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [ValidateSet("0","1","7","14","30")]
        [Alias('recur_every')]
        [int]$RecurEvery,

        [Parameter(ParameterSetName='SetByID')]
        [Parameter(ParameterSetName='SetByName')]
        [Alias('follow_dst')]
        [boolean]$FollowDST

    )

    if($Name)
    {   #If setting test by name verify if a test or tests with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Windows"))
        {
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -Name $Name -State "PND"
            if(!$maintenanceWindow)
            {
                Write-Error "No pending Maintenance Window with specified name exists [$Name]"
                Return $null
            }
            elseif($maintenanceWindow.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Pending Maintenance Windows with the same name [$Name] [$($maintenanceWindow.id)]"
                Return $null
            }
            $ID = $maintenanceWindow.id
        }
    }
    elseif($ID)
    {   #If setting by id verify that id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Windows"))
        {
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -ID $ID -State "PND"
            if(!$maintenanceWindow)
            {
                Write-Error "No pending Maintenance Window with specified ID exists [$ID]"
                Return $null
            }
            $ID = $maintenanceWindow.id
        }
    }

    $exclude = @("Name")
    $lower = @("Timezone","Name")
    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude $exclude -ToLowerName $lower
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
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -ID $ID
        }
        Return $maintenanceWindow
    }

}