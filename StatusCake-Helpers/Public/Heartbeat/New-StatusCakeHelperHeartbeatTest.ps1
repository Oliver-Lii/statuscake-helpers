
<#
.SYNOPSIS
    Create a StatusCake Heartbeat Test
.DESCRIPTION
    Creates a new StatusCake Heartbeat Test using the supplied parameters.
.PARAMETER APICredential
    Credentials to access StatusCake API
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
    Array of tags to apply to the test
.PARAMETER Force
    Create an Heartbeat test even if one with the same name already exists
.PARAMETER Passthru
    Return the Heartbeat test details instead of the Heartbeat test id
.EXAMPLE
    C:\PS>New-StatusCakeHelperHeartbeatTest -Name "Example Heartbeat test"
    Create a new Heartbeat check called "Example Heartbeat test"
.EXAMPLE
    C:\PS>New-StatusCakeHelperHeartbeatTest -Name "Example Heartbeat test" -Period 30
    Create a new Heartbeat check called "Example Heartbeat test" to be considered down if a ping is not received every 30 seconds
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Heartbeat/New-StatusCakeHelperHeartbeatTest.md
.LINK
    https://www.statuscake.com/api/v1/#tag/heartbeat/operation/create-heartbeat-test
#>
function New-StatusCakeHelperHeartbeatTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(Mandatory=$true)]
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

    #If force flag not set then check if an existing test with the same name already exists
    if(!$Force)
    {
       $statusCakeItem = Get-StatusCakeHelperHeartbeatTest -APICredential $APICredential -Name $Name
       if($statusCakeItem)
       {
            Write-Error "Existing heartbeat test(s) found with name [$Name]. Please use a different name for the check or use the -Force argument"
            Return $null
       }
    }

    $allParameterValues = $MyInvocation | Get-StatusCakeHelperParameterValue -BoundParameters $PSBoundParameters
    $statusCakeAPIParams = $allParameterValues | Get-StatusCakeHelperAPIParameter -InvocationInfo $MyInvocation -Exclude @("Force","PassThru") | ConvertTo-StatusCakeHelperAPIValue

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake Heartbeat Check") )
    {
        Return (New-StatusCakeHelperItem -APICredential $APICredential -Type Heartbeat -Parameter $statusCakeAPIParams -PassThru:$PassThru)
    }

}