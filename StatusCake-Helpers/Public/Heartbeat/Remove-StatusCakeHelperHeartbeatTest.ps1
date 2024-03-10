

<#
.SYNOPSIS
    Removes the specified StatusCake Test
.DESCRIPTION
    Removes the StatusCake test via it's Test ID or name
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the Test to be removed from StatusCake
.PARAMETER Name
    Name of the Test to be removed from StatusCake
.EXAMPLE
    C:\PS>Remove-StatusCakeHelperHeartbeatTest -ID 123456
    Delete the StatusCake test with ID 123456
.OUTPUTS
    Returns the result of the test removal as an object
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Heartbeat/Remove-StatusCakeHelperHeartbeatTest.md
.LINK
    https://www.statuscake.com/api/v1/#tag/heartbeat/operation/delete-heartbeat-test
#>
function Remove-StatusCakeHelperHeartbeatTest
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
        [string]$Name
    )

    if($Name)
    {
       $statusCakeItem = Get-StatusCakeHelperHeartbeatTest -APICredential $APICredential -Name $Name
       if(!$statusCakeItem)
       {
            Write-Error "No heartbeat test(s) found with name [$Name]"
            Return $null
       }
       elseif($statusCakeItem.GetType().Name -eq 'Object[]')
       {
           Write-Error "Multiple heartbeat tests found with name [$Name]. Please delete the heartbeat test by ID"
           Return $null
       }
       $ID = $statusCakeItem.id
    }

    if( $pscmdlet.ShouldProcess("$ID", "Delete StatusCake Heartbeat Test") )
    {
        Return (Remove-StatusCakeHelperItem -APICredential $APICredential -Type Heartbeat -ID $ID)
    }
}

