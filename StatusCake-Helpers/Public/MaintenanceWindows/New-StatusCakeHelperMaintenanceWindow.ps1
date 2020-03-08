
<#
.Synopsis
   Create a StatusCake Maintenance Window
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Name
    A descriptive name for the maintenance window
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
   New-StatusCakeHelperMaintenanceWindow -Name "Example Maintenance Window" -StartDate $(Get-Date) -EndDate $((Get-Date).AddHours(1)) -Timezone "Europe/London" -TestIDs @("123456")
.FUNCTIONALITY
   Creates a new StatusCake Maintenance Window using the supplied parameters. The raw_tests or raw_tags value must be provided to create a new maintenance window.
#>
function New-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='SetByTestTags',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTestIDs',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(ParameterSetName='SetByTestTags',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTestIDs',Mandatory=$true)]
        [Alias('start_unix','start_date')]
        [datetime]$StartDate,

        [Parameter(ParameterSetName='SetByTestTags',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTestIDs',Mandatory=$true)]
        [Alias('end_unix','end_date')]
        [datetime]$EndDate,

        [Parameter(ParameterSetName='SetByTestTags',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTestIDs',Mandatory=$true)]
        [ValidateScript({$_ | Test-StatusCakeHelperTimeZone})]
        [string]$Timezone,

        [Parameter(ParameterSetName='SetByTestIDs')]
        [Alias('raw_tests')]
        [int[]]$TestIDs,

        [Parameter(ParameterSetName='SetByTestTags')]
        [Alias('raw_tags')]
        [string[]]$TestTags,

        [Parameter(ParameterSetName='SetByTestIDs')]
        [Parameter(ParameterSetName='SetByTestTags')]
        [ValidateSet("0","1","7","14","30")]
        [Alias('recur_every')]
        [int]$RecurEvery,

        [Parameter(ParameterSetName='SetByTestIDs')]
        [Parameter(ParameterSetName='SetByTestTags')]
        [Alias('follow_dst')]
        [boolean]$FollowDST
    )

    if($pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Windows"))
    {
        $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -Name $Name -State "PND"
        if($maintenanceWindow)
        {
            if($maintenanceWindow.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Pending Maintenance Windows with the same name [$Name] [$($maintenanceWindow.id)]"
            }
            else
            {
                Write-Error "Pending Maintenance Window with specified name already exists [$Name]"
            }
            Return $null
        }

    }

    $lower=@("Timezone","Name")
    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -ToLowerName $lower
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Maintenance/Update"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Post"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Add StatusCake Maintenance Window") )
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
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -id $response.data.new_id
        }
        Return $maintenanceWindow
    }

}