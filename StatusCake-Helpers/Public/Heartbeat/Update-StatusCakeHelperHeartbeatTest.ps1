
<#
.SYNOPSIS
    Updates a StatusCake Heartbeat Test
.DESCRIPTION
    Updates a new StatusCake Heartbeat Test using the supplied parameters.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the Test to be updated in StatusCake
.PARAMETER Name
    Name of the check
.PARAMETER Period
    Number of seconds since last ping before the check is considered down
.PARAMETER ContactID
    Array containing contact IDs to alert.
.PARAMETER HostingProvider
    Name of the hosting provider
.PARAMETER Paused
    Whether the check should be run.
.PARAMETER Tags
    Array of tags
.PARAMETER Force
    Update an Heartbeat test even if one with the same name already exists
.PARAMETER Passthru
    Return the Heartbeat test details instead of the Heartbeat test id
.EXAMPLE
    C:\PS>Update-StatusCakeHelperHeartbeatTest -Name "Example Heartbeat test"
    Update a Heartbeat check called "Example Heartbeat test"
.EXAMPLE
    C:\PS>Update-StatusCakeHelperHeartbeatTest -Name "Example Heartbeat test" -Period 30
    Update a Heartbeat check called "Example Heartbeat test" to be considered down if a ping is not received every 30 seconds
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Heartbeat/Update-StatusCakeHelperHeartbeatTest.md
.LINK
    https://www.statuscake.com/api/v1/#tag/heartbeat/operation/update-heartbeat-test
#>
function Update-StatusCakeHelperHeartbeatTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName = "ID")]
        [ValidateNotNullOrEmpty()]
        [int]$ID,

        [Parameter(ParameterSetName = "Name")]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [ValidateRange(30,172800)]
        [int]$Period=1800,

        [Alias('contact_groups')]
        [int[]]$ContactID,

        [Alias('host')]
        [string]$HostingProvider,

        [boolean]$Paused,

        [string[]]$Tags,

        [switch]$Force,

        [switch]$PassThru

    )

    if($Name)
    {
       $statusCakeItem = Get-StatusCakeHelperHeartbeatTest -APICredential $APICredential -Name $Name
       if(!$statusCakeItem)
       {
            Write-Error "No Heartbeat test(s) found with name [$Name]"
            Return $null
       }
       elseif($statusCakeItem.GetType().Name -eq 'Object[]')
       {
           Write-Error "Multiple Heartbeat Tests found with name [$Name]. Please update the Heartbeat test by ID"
           Return $null
       }
       $ID = $statusCakeItem.id
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude @("Force","Name")  | ConvertTo-StatusCakeHelperAPIValue

    if( $pscmdlet.ShouldProcess("$ID", "Update StatusCake Heartbeat Test") )
    {
        Return (Update-StatusCakeHelperItem -APICredential $APICredential -Type Heartbeat -ID $ID -Parameter $statusCakeAPIParams)
    }

}