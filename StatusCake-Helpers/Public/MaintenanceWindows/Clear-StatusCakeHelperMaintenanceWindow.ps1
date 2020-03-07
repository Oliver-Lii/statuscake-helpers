
<#
.Synopsis
   Clears the tests associated with a StatusCake Maintenance Window
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Name
    Name of the maintenance window to clear the tests from
.PARAMETER ID
    The maintenance window ID
.PARAMETER TestIDs
    Flag to clear all tests included in a maintenance window
.PARAMETER TestTags
    Flag to clear all tags of the tests to be included in a maintenance window
.EXAMPLE
    # Clear all test IDs associated with maintenance window 123456
    Clear-StatusCakeHelperMaintenanceWindow -ID 123456 -TestIDs
.FUNCTIONALITY
   Clears the tests and/or tags associated with a pending StatusCake Maintenance Window. You can only clear the tests for a window which is in a pending state.
#>
function Clear-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='ByID')]
        [Parameter(ParameterSetName='ByName')]
		[ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='ByID')]
        [ValidateNotNullOrEmpty()]
        [string]$ID,

        [Parameter(ParameterSetName='ByName')]
        [string]$Name,

        [Parameter(ParameterSetName='ByID')]
        [Parameter(ParameterSetName='ByName')]
        [Alias('raw_tests')]
        [switch]$TestIDs,

        [Parameter(ParameterSetName='ByID')]
        [Parameter(ParameterSetName='ByName')]
        [Alias('raw_tags')]
        [switch]$TestTags
    )

    if($Name)
    {   #If setting test by name verify if a test or tests with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Windows"))
        {
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -name $Name -state "PND"
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
            $maintenanceWindow = Get-StatusCakeHelperMaintenanceWindow -APICredential $APICredential -ID $ID -state "PND"
            if(!$maintenanceWindow)
            {
                Write-Error "No pending Maintenance Window with specified ID exists [$ID]"
                Return $null
            }
            $ID = $maintenanceWindow.id
        }
    }

    If(!$TestIDs -and !$TestTags)
    {
        Write-Error "Please set the switch to clear tests or tags from the maintenance window"
        Return
    }

    $exclude = @("Name")
    $clear = @()
    if($TestIDs){$clear += "raw_tests"}
    if($TestTags){$clear += "raw_tags"}

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude $exclude -Clear $clear
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
        }
    }
}