
<#
.Synopsis
   Resumes a StatusCake test check
.EXAMPLE
   Resumes-StatusCakeHelperTest -TestName "Example"
.INPUTS
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API

    TestName - Name of the Test to be resumed
    TestID - ID of the Test to be resumed
.FUNCTIONALITY
   Resumes a test.
#>
function Resume-StatusCakeHelperTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='ResumeByName')]
        [Parameter(ParameterSetName='ResumeById')]
		[ValidateNotNullOrEmpty()]
        $Username = (Get-StatusCakeHelperAPIAuth).Username,

        [Parameter(ParameterSetName='ResumeByName')]
        [Parameter(ParameterSetName='ResumeById')]
        [ValidateNotNullOrEmpty()]
        $ApiKey = (Get-StatusCakeHelperAPIAuth).GetNetworkCredential().password,

        [Parameter(ParameterSetName='ResumeById',Mandatory=$true)]
        [ValidatePattern('^\d{1,}$')]
        $TestID,

        [Parameter(ParameterSetName='ResumeByName',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        $TestName
    )
    $statusCakeFunctionAuth = @{"Username"=$Username;"Apikey"=$ApiKey}

    if($TestName)
    {   #If resuming by name check if resource with that name exists
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
    {   #If resuming by ID verify that a resource with the Id already exists
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

    if( $pscmdlet.ShouldProcess("StatusCake API", "Resume StatusCake Test"))
    {
        $result = Set-StatusCakeHelperTest @statusCakeFunctionAuth -TestID $testID -Paused $false
    }
    Return $result
}