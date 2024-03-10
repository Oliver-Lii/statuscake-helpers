
<#
.SYNOPSIS
    Copies the settings of a StatusCake test
.DESCRIPTION
    Creates a copy of a test. Supply the Paused parameter to override the original values in the source test.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    The Heartbeat test ID to modify the details for
.PARAMETER Name
    Name of the heartbeat Test
.PARAMETER NewName
    Name of the new copied heartbeat test
.PARAMETER Paused
    If supplied sets the state of the test should be after it is copied.
.EXAMPLE
    C:\PS>Copy-StatusCakeHelperHeartbeatTest -Name "Example" -NewName "Example - Copy"
    Create a copy of test "Example" with name "Example - Copy"
.LINK
    https://github.com/Oliver-Lii/statuscake-helpers/blob/master/Documentation/Heartbeat/Copy-StatusCakeHelperHeartbeatTest.md
#>
function Copy-StatusCakeHelperHeartbeatTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [int]$ID,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$Name,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$NewName,

        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [Boolean]$Paused
    )

    if($Name)
    {   #If copying by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $statusCakeItem = Get-StatusCakeHelperHeartbeatTest -APICredential $APICredential -Name $Name
            if(!$statusCakeItem)
            {
                Write-Error "No Heartbeat test with Specified Name Exists [$Name]"
                Return $null
            }
            elseif($statusCakeItem.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Heartbeat tests with the same name [$Name] [$($statusCakeItem.ID)]"
                Return $null
            }
            $ID = $statusCakeItem.ID
        }
    }
    elseif($ID)
    {   #If copying by ID verify that a resource with the Id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $statusCakeItem = Get-StatusCakeHelperHeartbeatTest -APICredential $APICredential -ID $ID
            if(!$statusCakeItem)
            {
                Write-Error "No Test with Specified ID Exists [$ID]"
                Return $null
            }
            $ID = $statusCakeItem.ID
        }
    }

    $psParams = @{}
    $psParams = $statusCakeItem | Get-StatusCakeHelperCopyParameter -FunctionName "New-StatusCakeHelperHeartbeatTest"

    Write-Verbose "$($psParams.Keys -join ",")"

    $psParams.Name = $NewName

    if($Paused)
    {
        $psParams.Paused = $Paused
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake Heartbeat Test"))
    {
        $result = New-StatusCakeHelperHeartbeatTest -APICredential $APICredential @psParams
    }
    Return $result

}