
<#
.SYNOPSIS
    Remove node locations from a StatusCake test
.DESCRIPTION
    Remove node location(s) to a existing test. The supplied node location is tested against a list of the node location server codes to determine if it is valid.
    Server codes can be retrieved via the Get-StatusCakeHelperProbe command and checking the servercode property of the returned objects.
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestID
    ID of the Test to be removed from StatusCake
.PARAMETER TestName
    Name of the Test to be removed from StatusCake
.PARAMETER NodeLocations
    Array of test locations to be removed. Test location servercodes are required
.PARAMETER PassThru
    Return the object that is removed
.EXAMPLE
    C:\PS>Remove-StatusCakeHelperTestNodeLocation -TestID "123456" -NodeLocations @("EU1","EU2")
    Remove node locations EU1 and EU2 from test with ID 123456

#>
function Remove-StatusCakeHelperTestNodeLocation
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
        [string[]]$TestName,

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

    foreach($node in $NodeLocations)
    {
        Write-Verbose "Validating node location [$node]"
        if(!$($node | Test-StatusCakeHelperNodeLocation))
        {
            Write-Error "Node Location Server code invalid [$node]"
            Return $null
        }
    }
    if(!$detailedTestData.NodeLocations)
    {
        Write-Verbose "Test currently contains no specific node locations"
        $detailedTestData.NodeLocations = ""
    }
    $NodeLocations = $NodeLocations | Select-Object -Unique
    $differentNodeLocations = Compare-Object $detailedTestData.NodeLocations $NodeLocations -IncludeEqual
    $NodeLocations = $differentNodeLocations | Where-Object {$_.SideIndicator -eq "<="} | Select-Object -ExpandProperty InputObject
    $RemovedNodeLocations = $differentNodeLocations | Where-Object {$_.SideIndicator -eq "=="} | Select-Object -ExpandProperty InputObject
    $NodeLocationsNotPresent = $differentNodeLocations | Where-Object {$_.SideIndicator -eq "=>"} | Select-Object -ExpandProperty InputObject

    Write-Verbose "Removing following node locations from Test [$RemovedNodeLocations]"
    Write-Verbose "Following node locations not used by Test [$NodeLocationsNotPresent]"

    if( $pscmdlet.ShouldProcess("StatusCake API", "Remove Node Location from StatusCake Test"))
    {
        $result = Set-StatusCakeHelperTest -APICredential $APICredential -TestID $TestID -NodeLocations $NodeLocations
        if($PassThru)
        {
            Return $result
        }
    }
}