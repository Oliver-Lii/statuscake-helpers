
<#
.Synopsis
   Copies the settings of a StatusCake test check
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER TestName
    Name of the Test displayed in StatusCake
.PARAMETER TestID
    The Test ID to modify the details for
.PARAMETER TestURL
    The Test ID to modify the details for
.PARAMETER NewTestName
    Name of the new copied test
.PARAMETER Paused
    If supplied sets the state of the test should be after it is copied.
.EXAMPLE
   Copy-StatusCakeHelperTest -TestName "Example" -NewTestName "Example - Copy"
.FUNCTIONALITY
   Creates a copy of a test. Supply the TestURL or Paused parameter to override the original values in the source test.
#>
function Copy-StatusCakeHelperTest
{
    [CmdletBinding(PositionalBinding=$false,SupportsShouldProcess=$true)]
    Param(
        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [int]$TestID,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$TestName,

        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [ValidatePattern('^((http|https):\/\/)?([a-zA-Z0-9\-]+(\.[a-zA-Z]+)+.*)$|^(?!^.*,$)((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))*$')]
        [String]$TestURL,

        [Parameter(ParameterSetName='CopyByName',Mandatory=$true)]
        [Parameter(ParameterSetName='CopyById',Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$NewTestName,

        [Parameter(ParameterSetName='CopyByName')]
        [Parameter(ParameterSetName='CopyById')]
        [Boolean]$Paused
    )

    if($TestName)
    {   #If copying by name check if resource with that name exists
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
    {   #If copying by ID verify that a resource with the Id already exists
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

    if( $pscmdlet.ShouldProcess("StatusCake API", "Retrieve Detailed StatusCake Test Data"))
    {
        $sourceItemDetails = Get-StatusCakeHelperTestDetail -APICredential $APICredential -TestID $TestID
    }

    $ParameterList = (Get-Command -Name New-StatusCakeHelperTest).Parameters

    if(!$TestURL)
    {
        $TestURL = $sourceItemDetails.URI
    }

    $psParams = @{
        "TestName" = $NewTestName
        "TestURL" = $TestURL
    }

    $paramsToUse = $sourceItemDetails | Get-Member | Select-Object Name
    $paramsToUse = Compare-Object $paramsToUse.Name @($ParameterList.keys) -IncludeEqual -ExcludeDifferent
    $paramsToUse = $paramsToUse | Select-Object -ExpandProperty InputObject

    foreach ($key in $paramsToUse)
    {
        $value = $sourceItemDetails | Select-Object -ExpandProperty $key
        if($key -eq "Paused" -and $Paused -eq 0 -or $Paused)
        {
            $psParams.Add($key,$Paused)
        }
        elseif($value -or $value -eq 0)
        {
            $psParams.Add($key,$value)
        }
    }

    if( $pscmdlet.ShouldProcess("StatusCake API", "Create StatusCake Test"))
    {
        $result = New-StatusCakeHelperTest -APICredential $APICredential @psParams
    }
    Return $result
}