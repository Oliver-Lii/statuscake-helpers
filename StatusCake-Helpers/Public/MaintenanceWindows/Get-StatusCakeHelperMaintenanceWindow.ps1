
<#
.Synopsis
   Gets a StatusCake Maintenance Window
.PARAMETER APICredential
   Credentials to access StatusCake API
.PARAMETER Name
    Name of the maintenance window to retrieve
.PARAMETER ID
    ID of the maintenance window to retrieve
.PARAMETER State
    Filter results based on state
.EXAMPLE
   Get-StatusCakeHelperMaintenanceWindow -id 123456
.OUTPUTS
    Returns StatusCake Maintenance Windows as an object
.FUNCTIONALITY
    Retrieves StatusCake Maintenance Windows by id or state.

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
        [string]$state,

        [Parameter(ParameterSetName = "Name")]
        [ValidateNotNullOrEmpty()]
        [string]$name,

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$id
    )

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation
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
        elseif($name)
        {
            $matchingMW = $response.data | Where-Object {$_.name -eq $name}
        }
        elseif($id)
        {
            $matchingMW = $response.data | Where-Object {$_.id -eq $id}
        }

        if($matchingMW)
        {
            Return $matchingMW
        }

        Return $null
    }

}

