
<#
.SYNOPSIS
    Gets a StatusCake Maintenance Window
.DESCRIPTION
    Retrieves StatusCake Maintenance Windows. If no id or name is supplied all maintenance windows are returned. Results can be filtered by maintenance window state.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Name
    Name of the maintenance window to retrieve
.PARAMETER ID
    ID of the maintenance window to retrieve
.PARAMETER State
    Filter results based on state. PND - Pending, ACT - Active, END - Ended, CNC - Cancelled
.EXAMPLE
    C:\PS>Get-StatusCakeHelperMaintenanceWindow
    Get all maintenance windows
.EXAMPLE
    C:\PS>Get-StatusCakeHelperMaintenanceWindow -State PND
    Get all maintenance windows in a pending state
.OUTPUTS
    Returns StatusCake Maintenance Windows as an object
#>
function Get-StatusCakeHelperMaintenanceWindow
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true,DefaultParameterSetName='all')]
    Param(
        [Parameter(ParameterSetName = "Name")]
        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "Name")]
        [Parameter(ParameterSetName = "ID")]
        [ValidateSet("ALL","PND","ACT","END","CNC")]
        [string]$State,

        [Parameter(ParameterSetName = "Name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID
    )

    $lower=@("State")
    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -ToLowerName $lower
    $statusCakeAPIParams = $statusCakeAPIParams | ConvertTo-StatusCakeHelperAPIParameter

    $requestParams = @{
        uri = "https://app.statuscake.com/API/Maintenance/"
        Headers = @{"Username"=$APICredential.Username;"API"=$APICredential.GetNetworkCredential().password}
        UseBasicParsing = $true
        method = "Get"
        ContentType = "application/x-www-form-urlencoded"
        body = $statusCakeAPIParams
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Maintenance Window") )
    {
        $response = Invoke-RestMethod @requestParams
        $requestParams=@{}
        if($response.Success -ne "True")
        {
            Write-Error "$($response.Message) [$($response.Issues)]"
            Return $null
        }

        if($PSCmdlet.ParameterSetName -eq "all")
        {
            $matchingMW = $response.data
        }
        elseif($Name)
        {
            $matchingMW = $response.data | Where-Object {$_.name -eq $Name}
        }
        elseif($ID)
        {
            $matchingMW = $response.data | Where-Object {$_.id -eq $ID}
        }

        if($matchingMW)
        {
            Return $matchingMW
        }

        Return $null
    }

}

