
<#
.SYNOPSIS
    Add additional HTTP status codes to alert on to a StatusCake test
.DESCRIPTION
    Add additional HTTP StatusCodes to alert on to an existing test.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestID
    The Test ID to modify the details for
.PARAMETER TestName
    Name of the Test displayed in StatusCake
.PARAMETER StatusCodes
    Array of status codes to be added.
.PARAMETER PassThru
    Returns the object which this function modifies. By default, this function does not return any output.
.EXAMPLE
    C:\PS>Add-StatusCakeHelperTestStatusCode -TestID "123456" -StatusCodes @(206,207)
    Add status codes 206 and 207 to test with ID 123456
#>
function Add-StatusCakeHelperTestStatusCode
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
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
        [ValidateScript({
            if(!($_ | Test-StatusCakeHelperStatusCode)){
                Throw "HTTP Status Code invalid [$_]"
            }
            else{$true}
        })]
        [int[]]$StatusCodes,

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

    $detailedTestData.StatusCodes += $StatusCodes
    $StatusCodes = $detailedTestData.StatusCodes | Sort-Object -Unique

    if( $pscmdlet.ShouldProcess("StatusCake API", "Add Status Code to StatusCake Test"))
    {
        $result = Set-StatusCakeHelperTest -APICredential $APICredential -TestID $TestID -StatusCodes $StatusCodes
        if($PassThru)
        {
            Return $result
        }
    }

}