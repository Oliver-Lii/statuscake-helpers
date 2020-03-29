
<#
.SYNOPSIS
    Add node locations to a StatusCake test
.DESCRIPTION
    Add node location(s) to a existing test. The supplied node location is tested against a list of the node location server codes to determine if it is valid.
    Server codes can be retrieved via the Get-StatusCakeHelperProbe command and checking the servercode property of the returned objects.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestID
    The Test ID to modify the details for
.PARAMETER AddByTestName
    Switch to add node location via test name
.PARAMETER TestName
    Name of the Test displayed in StatusCake
.PARAMETER NodeLocations
    Array of test locations to be added. Test location servercodes are required
.PARAMETER PassThru
    Returns the object which this function modifies. By default, this function does not return any output.
.EXAMPLE
    C:\PS>Add-StatusCakeHelperTestNodeLocation -TestID "123456" -NodeLocations @("EU1","EU2")
    Add node locations EU1 and EU2 to test with ID 123456

#>
function Add-StatusCakeHelperTestNodeLocation
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='ByTestName')]
        [Parameter(ParameterSetName='ByTestID')]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='ByTestID')]
        [ValidateNotNullOrEmpty()]
        [int]$TestID,

        [Parameter(ParameterSetName='ByTestName')]
        [ValidateNotNullOrEmpty()]
        [string]$TestName,

        [Parameter(ParameterSetName='ByTestName',Mandatory=$true)]
        [Parameter(ParameterSetName='ByTestID',Mandatory=$true)]
        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperNodeLocation)){
                Throw "Node Location Server code invalid [$_]"
            }
            else{$true}
        })]
        [string[]]$NodeLocations,

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

    $detailedTestData.NodeLocations += $NodeLocations
    $NodeLocations = $detailedTestData.NodeLocations | Select-Object -Unique

    if( $pscmdlet.ShouldProcess("StatusCake API", "Add Node Location to StatusCake Test"))
    {
        $result = Set-StatusCakeHelperTest -APICredential $APICredential -TestID $TestID -NodeLocations $NodeLocations
        if($PassThru)
        {
            Return $result
        }
    }
}