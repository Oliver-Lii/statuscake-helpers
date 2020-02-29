
<#
.Synopsis
   Resumes a StatusCake test check
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestID
    ID of the Test to be removed from StatusCake
.PARAMETER TestName
    Name of the Test to be removed from StatusCake
.PARAMETER TestTags
    Array of tags to be removed
.EXAMPLE
   Resumes-StatusCakeHelperTest -TestName "Example"
.FUNCTIONALITY
   Resumes a test.
#>
function Resume-StatusCakeHelperTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='ResumeById',Mandatory=$true)]
        [int]$TestID,

        [Parameter(ParameterSetName='ResumeByName',Mandatory=$true)]
        [string]$TestName
    )

    if($TestName)
    {   #If resuming by name check if resource with that name exists
        if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Tests"))
        {
            $testCheck = Get-StatusCakeHelperTest -APICredential $APICredential -TestName $TestName
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
            $testCheck = Get-StatusCakeHelperTest -APICredential $APICredential -TestID $TestID
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
        $result = Set-StatusCakeHelperTest -APICredential $APICredential -TestID $testID -Paused $false
    }
    Return $result
}