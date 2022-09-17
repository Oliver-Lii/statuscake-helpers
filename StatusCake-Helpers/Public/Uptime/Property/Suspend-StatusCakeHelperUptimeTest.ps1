
<#
.SYNOPSIS
    Pauses a StatusCake test check
.DESCRIPTION
    Pauses a test.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER ID
    ID of the Test to be removed from StatusCake
.PARAMETER Name
    Name of the Test to be removed from StatusCake
.EXAMPLE
    C:\PS>Suspend-StatusCakeHelperUptimeTest -Name "Example"
    Pauses the test called "Example"
#>
function Suspend-StatusCakeHelperUptimeTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='PauseById',Mandatory=$true)]
        [int]$ID,

        [Parameter(ParameterSetName='PauseByName',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name
    )

    if($Name)
    {   #If pausing by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $testCheck = Get-StatusCakeHelperUptimeTest -APICredential $APICredential -Name $Name
            if(!$testCheck)
            {
                Write-Error "No Test with Specified Name Exists [$Name]"
                Return $null
            }
            elseif($testCheck.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Tests with the same name [$Name] [$($testCheck.ID)]"
                Return $null
            }
            $ID = $testCheck.ID
        }
    }
    elseif($ID)
    {   #If pausing by ID verify that a resource with the Id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $testCheck = Get-StatusCakeHelperUptimeTest -APICredential $APICredential -ID $ID
            if(!$testCheck)
            {
                Write-Error "No Test with Specified ID Exists [$ID]"
                Return $null
            }
            $ID = $testCheck.ID
        }
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Suspend StatusCake Test"))
    {
        $result = Update-StatusCakeHelperUptimeTest -APICredential $APICredential -ID $ID -Paused $true
    }
    Return $result
}