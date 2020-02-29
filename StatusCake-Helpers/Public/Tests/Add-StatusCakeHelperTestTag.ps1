
<#
.Synopsis
   Add tags to a StatusCake test
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestID
    The Test ID to modify the details for
.PARAMETER AddByTestName
    Switch to add status codes to a test via test name
.PARAMETER TestName
    Name of the Test displayed in StatusCake
.PARAMETER TestTags
    Array of tags to add
.EXAMPLE
   Add-StatusCakeHelperTestTags -TestID "123456" -TestTags @("Tag1","Tag2")
.FUNCTIONALITY
    Add tag(s) to a existing test.

#>
function Add-StatusCakeHelperTestTag
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='ByTestName')]
        [Parameter(ParameterSetName='ByTestID')]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='ByTestID',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [int]$TestID,

        [Parameter(ParameterSetName='ByTestName',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$TestName,

        [Parameter(ParameterSetName='ByTestName',Mandatory=$true)]
        [Parameter(ParameterSetName='ByTestID',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [Alias('TestTags')]
        [string[]]$Tags,

        [Parameter(ParameterSetName='ByTestName')]
        [Parameter(ParameterSetName='ByTestID')]
        [switch]$PassThru
    )

    if($TestName)
    {   #If setting test by name check if a test or tests with that name exists
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
    {   #If setting by TestID verify that TestID already exists
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

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve StatusCake Detailed Test Data") )
    {
        $detailedTestData = Get-StatusCakeHelperTestDetail -APICredential $APICredential -TestID $TestID
    }

    #Tags property does not exist unless Test already has Tags
    if($detailedTestData.Tags)
    {
        $detailedTestData.Tags += $Tags
        $Tags = $detailedTestData.Tags | Select-Object -Unique
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Add Test Tag to StatusCake Test"))
    {
        $result = Set-StatusCakeHelperTest -APICredential $APICredential -TestID $TestID -Tags $Tags
        if($PassThru)
        {
            Return $result
        }
    }
}