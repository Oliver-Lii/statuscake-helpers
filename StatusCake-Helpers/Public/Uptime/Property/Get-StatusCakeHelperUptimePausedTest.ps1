
<#
.SYNOPSIS
    Retrieves all the StatusCake Tests that have been paused more than the specified time unit
.DESCRIPTION
    Retrieves all the tests from StatusCake that are paused and have been tested longer than
    the supplied parameters. Defaults to returning tests that have been paused more than 24 hours.
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
    C:\PS>Get-StatusCakeHelperUptimePausedTest
    Get all tests paused longer than a day
.OUTPUTS
    Returns an object with the StatusCake Detailed Test data

#>
function Get-StatusCakeHelperUptimePausedTest
{
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Collections.Generic.List[PSObject]])]
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
    $statusCakePausedTests = Get-StatusCakeHelperUptimeTest -APICredential $APICredential
    $statusCakePausedTests = $StatusCakePausedTests | Where-Object{$_.Paused -eq "True"}

    $matchingTests=[System.Collections.Generic.List[PSObject]]::new()
    Foreach($sctest in $statusCakePausedTests)
    {
        $detailedTestData = Get-StatusCakeHelperUptimeTest -APICredential $APICredential -ID $sctest.id
        if($detailedTestData.status -eq "up" -and $detailedTestData.uptime -eq 0)
        {
            Write-Verbose "Uptime test [$($sctest.id) / $($sctest.name)] has never been tested"
            if($IncludeNotTested)
            {
                $matchingTests.Add($sctest)
            }
            continue
        }

        if($ExcludeTested)
        {
            Write-Verbose "Skipping uptime test [$($sctest.id) / $($sctest.name)] as ExcludeTested flag set"
            continue
        }

        $testLastTestTimeSpan = New-TimeSpan -Start $detailedTestData.last_tested_at

        If($testLastTestTimeSpan.TotalDays -ge $Days -and $hours -eq 0)
        {
            Write-Verbose "Uptime test [$($sctest.id) / $($sctest.name)] paused for [$([math]::Round($testLastTestTimeSpan.totaldays,2))] days"
            $matchingTests.Add($detailedTestData)
            continue
        }
        elseif($testLastTestTimeSpan.Totalhours -ge $Hours -and $minutes -eq 0)
        {
            Write-Verbose "Uptime test [$($sctest.id) / $($sctest.name)] paused for [$([int]$($testLastTestTimeSpan.totalhours))] hours"
            $matchingTests.Add($detailedTestData)
        }
        elseif($testLastTestTimeSpan.Totalminutes -ge $Minutes)
        {
            Write-Verbose "Uptime test [$($sctest.id) / $($sctest.name)] paused for [$([int]$($testLastTestTimeSpan.totalminutes))] minutes"
            $matchingTests.Add($detailedTestData)
        }
    }
    Return $matchingTests
}