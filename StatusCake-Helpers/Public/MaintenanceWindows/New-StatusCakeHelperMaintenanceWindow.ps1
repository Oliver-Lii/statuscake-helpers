
<#
.Synopsis
   Create a StatusCake Maintenance Window
.PARAMETER APICredential
   Credentials to access StatusCake API
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
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='SetByTestTags',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTestIDs',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$name,

        [Parameter(ParameterSetName='SetByTestTags',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTestIDs',Mandatory=$true)]
        [Alias('start_unix')]
        [datetime]$start_date,

        [Parameter(ParameterSetName='SetByTestTags',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTestIDs',Mandatory=$true)]
        [Alias('end_unix')]
        [datetime]$end_date,

        [Parameter(ParameterSetName='SetByTestTags',Mandatory=$true)]
        [Parameter(ParameterSetName='SetByTestIDs',Mandatory=$true)]
        [ValidateScript({$_ | Test-StatusCakeHelperTimeZone})]
        [string]$timezone,

        [Parameter(ParameterSetName='SetByTestIDs')]
        [ValidateScript({$_ -match '^[\d]+$'})]
        [int[]]$raw_tests,

        [Parameter(ParameterSetName='SetByTestTags')]
        [string[]]$raw_tags,

        [Parameter(ParameterSetName='SetByTestIDs')]
        [Parameter(ParameterSetName='SetByTestTags')]
        [ValidateSet("0","1","7","14","30")]
        [int]$recur_every,

        [Parameter(ParameterSetName='SetByTestIDs')]
        [Parameter(ParameterSetName='SetByTestTags')]
        [boolean]$follow_dst
    )

    if($pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Windows"))
    {
        $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -name $name -state "PND"
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

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation
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