
<#
.Synopsis
   Clears the tests associated with a StatusCake Maintenance Window
.PARAMETER APICredential
   Credentials to access StatusCake API
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
   Clear-StatusCakeHelperMaintenanceWindow -id 123456 -raw_tests
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
        [string]$id,

        [Parameter(ParameterSetName='ByName')]
        [string]$name,

        [Parameter(ParameterSetName='ByID')]
        [Parameter(ParameterSetName='ByName')]
        [switch]$raw_tests,

        [Parameter(ParameterSetName='ByID')]
        [Parameter(ParameterSetName='ByName')]
        [switch]$raw_tags
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

    If(!$raw_tests -and !$raw_tags)
    {
        Write-Error "Please set the switch to clear tests or tags from the maintenance window"
        Return
    }

    $exclude = @("Name")
    $clear = @()
    if($raw_tests){$clear += "raw_tests"}
    if($raw_tags){$clear += "raw_tags"}

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -exclude $exclude -clear $clear
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