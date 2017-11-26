
<#
.Synopsis
   Retrieves all the StatusCake Tests that have been paused more than the specified time unit
.EXAMPLE
   Get-StatusCakeHelperPausedTests -Username "Username" -ApiKey "APIKEY"
.INPUTS
    baseTestURL - Base URL endpoint of the statuscake auth API
    Username - Username associated with the API key
    ApiKey - APIKey to access the StatusCake API
    Days - Specify the number of day(s) (24h period) that the test(s) has been paused
    Hours - Specify the number of hour(s) that the test(s) has been paused
    Minutes - Specify the number of minute(s) that the test(s) has been paused
    IncludeNotTested - If set tests that have never been tested will be included
    ExcludeTested - If set tests that have been tested will be excluded
.OUTPUTS    
    Returns an object with the StatusCake Detailed Test data
.FUNCTIONALITY
    Retrieves all the tests from StatusCake that are paused and have been tested longer than
    the supplied parameters. Defaults to returning tests that have been paused more than 24 hours.
   
#>
function Get-StatusCakeHelperPausedTests
{
    [CmdletBinding(PositionalBinding=$false)]    
    Param(
        [Parameter(ParameterSetName='Days')]
        [Parameter(ParameterSetName='Hours')]
        [Parameter(ParameterSetName='Minutes')]                         
        $baseTestURL = "https://app.statuscake.com/API/Tests/",

        [Parameter(ParameterSetName='Days',Mandatory=$true)]
        [Parameter(ParameterSetName='Hours',Mandatory=$true)]
        [Parameter(ParameterSetName='Minutes',Mandatory=$true)]
        [Parameter(Mandatory=$true)]    
        $Username,
      
        [Parameter(ParameterSetName='Days',Mandatory=$true)]
        [Parameter(ParameterSetName='Hours',Mandatory=$true)]
        [Parameter(ParameterSetName='Minutes',Mandatory=$true)]        
        [Parameter(Mandatory=$true)]          
        $ApiKey,

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
    $statusCakeAuth = @{"Username"=$Username;"APIKey"=$ApiKey}
    $statusCakePausedTests = Get-StatusCakeHelperAllTests @statusCakeAuth

    $statusCakePausedTests = $StatusCakePausedTests | Where-Object{$_.Paused -eq "True"}

    $matchingTests=@()
    Foreach($sctest in $statusCakePausedTests)
    {
        $detailedTestData = Get-StatusCakeHelperDetailedTestData @StatusCakeAuth -TestID $sctest.TestID
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