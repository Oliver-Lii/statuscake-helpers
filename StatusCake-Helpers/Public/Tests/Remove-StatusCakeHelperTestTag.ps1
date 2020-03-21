
<#
.SYNOPSIS
   Remove tag(s) from a StatusCake test
.DESCRIPTION
    Remove tag(s) from an existing test.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestID
    ID of the Test to be removed from StatusCake
.PARAMETER TestName
    Name of the Test to be removed from StatusCake
.PARAMETER TestTags
    Array of tags to be removed
.EXAMPLE
    C:\PS>Remove-StatusCakeHelperTestTags -TestID "123456" -TestTags @("Tag1","Tag2")
    Remove tags Tag1 and Tag2 from test with ID 123456

#>
function Remove-StatusCakeHelperTestTag
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

    if(!$detailedTestData.Tags)
    {
        Write-Verbose "Test currently contains no tags"
        $detailedTestData.Tags = ""
    }
    $Tags = $Tags | Select-Object -Unique
    $differentTestTags = Compare-Object $detailedTestData.Tags $Tags -IncludeEqual
    $Tags = $differentTestTags | Where-Object {$_.SideIndicator -eq "<="} | Select-Object -ExpandProperty InputObject
    $RemovedTags = $differentTestTags | Where-Object {$_.SideIndicator -eq "=="} | Select-Object -ExpandProperty InputObject
    $TagsNotPresent = $differentTestTags | Where-Object {$_.SideIndicator -eq "=>"} | Select-Object -ExpandProperty InputObject

    Write-Verbose "Removing Following Tags from Test [$RemovedTags]"
    Write-Verbose "Following Tags not attached to Test [$TagsNotPresent]"

    if( $pscmdlet.ShouldProcess("StatusCake API", "Remove Status Code from StatusCake Test"))
    {
        $result = Set-StatusCakeHelperTest -APICredential $APICredential -TestID $TestID -Tags $Tags
        if($PassThru)
        {
            Return $result
        }
    }
}