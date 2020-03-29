
<#
.SYNOPSIS
    Remove HTTP status codes from a StatusCake test
.DESCRIPTION
    Remove HTTP Status Codes from an existing test.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestID
    ID of the Test to be removed from StatusCake
.PARAMETER TestName
    Name of the Test to be removed from StatusCake
.PARAMETER StatusCodes
    Array of status codes to be removed
.PARAMETER PassThru
    Return the object that is removed
.EXAMPLE
    C:\PS>Remove-StatusCakeHelperTestStatusCodes -TestID "123456" -StatusCodes @("401","404")
    Remove status codes 401 and 404 from test with ID 123456

#>
function Remove-StatusCakeHelperTestStatusCode
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='ByTestID',Mandatory=$true)]
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

    foreach($statuscode in $StatusCodes)
    {
        Write-Verbose "Validating status code [$statuscode]"
        if(!$($statuscode | Test-StatusCakeHelperStatusCode))
        {
            Write-Error "Status code invalid [$statuscode]"
            Return $null
        }
    }
    if(!$detailedTestData.StatusCodes)
    {
        Write-Verbose "Test currently contains no status codes"
        $detailedTestData.StatusCodes = ""
    }
    $StatusCodes = $StatusCodes | Select-Object -Unique
    $differentStatusCodes = Compare-Object $detailedTestData.StatusCodes $StatusCodes -IncludeEqual
    $StatusCodes = $differentStatusCodes | Where-Object {$_.SideIndicator -eq "<="} | Select-Object -ExpandProperty InputObject | Sort-Object
    $RemovedStatusCodes = $differentStatusCodes | Where-Object {$_.SideIndicator -eq "=="} | Select-Object -ExpandProperty InputObject
    $StatusCodesNotPresent = $differentStatusCodes | Where-Object {$_.SideIndicator -eq "=>"} | Select-Object -ExpandProperty InputObject

    Write-Verbose "Removing following status code(s) from Test [$RemovedStatusCodes]"
    Write-Verbose "Following status code(s) not used by Test [$StatusCodesNotPresent]"

    if( $pscmdlet.ShouldProcess("StatusCake API", "Remove Status Code from StatusCake Test"))
    {
        $result = Set-StatusCakeHelperTest -APICredential $APICredential -TestID $TestID -StatusCodes $StatusCodes
        if($PassThru)
        {
            Return $result
        }
    }
}