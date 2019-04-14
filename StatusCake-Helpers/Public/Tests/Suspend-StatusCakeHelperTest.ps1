
<#
.Synopsis
   Pauses a StatusCake test check
.EXAMPLE
   Suspend-StatusCakeHelperTest -TestName "Example"
.INPUTS
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API

    TestName - Name of the Test to be paused
    TestID - ID of the Test to be paused
.FUNCTIONALITY
   Pauses a test.
#>
function Suspend-StatusCakeHelperTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='PauseByName')]
        [Parameter(ParameterSetName='PauseById')]
		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [Parameter(ParameterSetName='PauseByName')]
        [Parameter(ParameterSetName='PauseById')]
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName='PauseById',Mandatory=$true)]
        [ValidatePattern('^\d{1,}$')]
        $TestID,

        [Parameter(ParameterSetName='PauseByName',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        $TestName
    )
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}

    if($TestName)
    {   #If pausing by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $testCheck = Get-StatusCakeHelperTest @statusCakeFunctionAuth -TestName $TestName
            if(!$testCheck)
            {
                Write-Error "No Test with Specified Name Exists [$TestName]"
                Return $null
            }
            elseif($testCheck.GetType().Name -eq 'Object[]')
            {
                Write-Error "Multiple Tests with the same name [$TestName] [$($testCheck.TestID)]"
                Return $null
            }
            $TestID = $testCheck.TestID
        }
    }
    elseif($TestID)
    {   #If pausing by ID verify that a resource with the Id already exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $testCheck = Get-StatusCakeHelperTest @statusCakeFunctionAuth -TestID $TestID
            if(!$testCheck)
            {
                Write-Error "No Test with Specified ID Exists [$TestID]"
                Return $null
            }
            $TestID = $testCheck.TestID
        }
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Suspend StatusCake Test"))
    {
        $result = Set-StatusCakeHelperTest @statusCakeFunctionAuth -TestID $testID -Paused $true
    }
    Return $result
}