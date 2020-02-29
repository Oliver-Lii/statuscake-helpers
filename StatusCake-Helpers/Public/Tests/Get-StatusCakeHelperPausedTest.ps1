
<#
.Synopsis
   Retrieves all the StatusCake Tests that have been paused more than the specified time unit
.PARAMETER APICredential
    Credentials to access StatusCake API
.PARAMETER Days
    Specify the number of day(s) (24h period) that the test(s) has been paused
.PARAMETER Hours
    Specify the number of hour(s) that the test(s) has been paused
.PARAMETER Minutes
    Specify the number of minute(s) that the test(s) has been paused
.PARAMETER IncludeNotTested
    If set tests that have never been tested will be included
.PARAMETER ExcludeTested
    If set tests that have been tested will be excluded
.EXAMPLE
   Get-StatusCakeHelperPausedTest
.OUTPUTS
    Returns an object with the StatusCake Detailed Test data
.FUNCTIONALITY
    Retrieves all the tests from StatusCake that are paused and have been tested longer than
    the supplied parameters. Defaults to returning tests that have been paused more than 24 hours.

#>
function Get-StatusCakeHelperPausedTest
{
    [CmdletBinding(PositionalBinding=$false)]
    Param(
        [Parameter(ParameterSetName='Days')]
        [Parameter(ParameterSetName='Hours')]
        [Parameter(ParameterSetName='Minutes')]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential] $APICredential = (Get-StatusCakeHelperAPIAuth),

        [Parameter(ParameterSetName='Days')]
        [int]$Days=1,

        [Parameter(ParameterSetName='Hours')]
        [int]$Hours,

        [Parameter(ParameterSetName='Minutes')]
        [int]$Minutes,

        [Parameter(ParameterSetName='Days')]
        [Parameter(ParameterSetName='Hours')]
        [Parameter(ParameterSetName='Minutes')]
        [switch]$IncludeNotTested,

        [Parameter(ParameterSetName='Days')]
        [Parameter(ParameterSetName='Hours')]
        [Parameter(ParameterSetName='Minutes')]
        [switch]$ExcludeTested
    )
    $statusCakePausedTests = Get-StatusCakeHelperTest -APICredential $APICredential
    $statusCakePausedTests = $StatusCakePausedTests | Where-Object{$_.Paused -eq "True"}

    $matchingTests=@()
    Foreach($sctest in $statusCakePausedTests)
    {
        $detailedTestData = Get-StatusCakeHelperTestDetail -APICredential $APICredential -TestID $sctest.TestID
        if($detailedTestData.LastTested -eq "0000-00-00 00:00:00")
        {
            Write-Verbose "Test [$($sctest.TestID) / $($sctest.WebsiteName)] has never been tested"
            if($IncludeNotTested)
            {
                $matchingTests += $sctest
            }
            continue
        }

        if($ExcludeTested)
        {
            Write-Verbose "Skipping test [$($sctest.TestID) / $($sctest.WebsiteName)] as ExcludeTested flag set"
            continue
        }

        $testLastTestTimeSpan = New-TimeSpan -Start $detailedTestData.LastTested

        If($testLastTestTimeSpan.TotalDays -ge $Days -and $hours -eq 0)
        {
            Write-Verbose "Test [$($sctest.TestID) / $($sctest.WebsiteName)] paused for [$([math]::Round($testLastTestTimeSpan.totaldays,2))] days"
            $matchingTests += $detailedTestData
            continue
        }
        elseif($testLastTestTimeSpan.Totalhours -ge $Hours -and $minutes -eq 0)
        {
            Write-Verbose "Test [$($sctest.TestID) / $($sctest.WebsiteName)] paused for [$([int]$($testLastTestTimeSpan.totalhours))] hours"
            $matchingTests += $detailedTestData
        }
        elseif($testLastTestTimeSpan.Totalminutes -ge $Minutes)
        {
            Write-Verbose "Test [$($sctest.TestID) / $($sctest.WebsiteName)] paused for [$([int]$($testLastTestTimeSpan.totalminutes))] minutes"
            $matchingTests += $detailedTestData
        }
    }
    Return $matchingTests
}