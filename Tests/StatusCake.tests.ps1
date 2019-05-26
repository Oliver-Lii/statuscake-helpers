$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleRoot = "$here\..\statuscake-helpers"

if(! (Test-StatusCakeHelperAPIAuthSet))
{
    $scUser = Read-Host "Enter the StatusCake Username"
    $scAPIKey = Read-Host "Enter the StatusCake API key" -AsSecureString
    $scCredentials = New-Object System.Management.Automation.PSCredential ($scUser, $scAPIKey)
    Set-StatusCakeHelperAPIAuth -Credentials $scCredentials
}

Describe "StatusCake Tests" {

    It "New-StatusCakeHelperTest creates a test"{
        $script:SCTest = New-StatusCakeHelperTest -TestName "Pester Test StatusCake Test" -TestURL "https://www.example.com" -checkRate 300 -testType HTTP
        $scTest.Success | Should Be "True"
    }

    It "Get-StatusCakeHelperAllTests retrieves all tests"{
        $results = Get-StatusCakeHelperAllTests
        $results.count | Should -BeGreaterThan 0
    }

    It "Copy-StatusCakeHelperTest copies a test"{
        $result = Copy-StatusCakeHelperTest -TestName "Pester Test StatusCake Test" -NewTestName "Pester Test StatusCake Test - Copy"
        $result.Success | Should Be "True"
    }

    It "Set-StatusCakeHelperTest pauses a test"{
        $result = Set-StatusCakeHelperTest -TestID $SCTest.InsertID -Paused 1
        $result.Success | Should Be "True"
    }

    It "Get-StatusCakeHelperPausedTests retrieves paused tests"{
        $result = Get-StatusCakeHelperPausedTests -Minutes 1 -IncludeNotTested
        $result.Paused | Should Be "True"
    }

    It "Get-StatusCakeHelperTest retrieves the test created by name"{
        $result = Get-StatusCakeHelperTest -TestName $SCTest.Data.WebsiteName
        $result | Should Be $true
    }

    It "Get-StatusCakeHelperDetailedTestData retrieves the detailed test data"{
        $result = Get-StatusCakeHelperDetailedTestData -TestID $SCTest.InsertID
        $result | Should Be $true
    }

    It "Add-StatusCakeHelperTestTags adds tags to a test"{
        $result = Add-StatusCakeHelperTestTags -TestID $SCTest.InsertID -TestTags @("Pester Test","Add Tags Test")
        $result.Success | Should Be "True"
    }

    It "Remove-StatusCakeHelperTestTags removes tags from a test"{
        $result = Remove-StatusCakeHelperTestTags -TestID $SCTest.InsertID -TestTags @("Add Tags Test")
        $result.Success | Should Be "True"
    }

    It "Get-StatusCakeHelperAllTests retrieves tests filtered by a tag"{
        Get-StatusCakeHelperAllTests -tags @("Pester Test") | Should Be $true
    }

    It "Remove-StatusCakeHelperTestStatusCodes removes a status code from a test"{
        $result = Remove-StatusCakeHelperTestStatusCodes -TestID $SCTest.InsertID -StatusCodes 401
        $result.Success | Should Be "True"
    }

    It "Add-StatusCakeHelperTestStatusCodes adds a statuscode to a test"{
        $result = Add-StatusCakeHelperTestStatusCodes -TestID $SCTest.InsertID -StatusCodes 401
        $result.Success | Should Be "True"
    }

    It "Remove-StatusCakeHelperTest removes a test"{
        $result = Remove-StatusCakeHelperTest -TestID $SCTest.InsertID -PassThru
        $result.Success | Should Be "True"
    }

    It "Remove-StatusCakeHelperTest removes a test by name"{
        $result = Remove-StatusCakeHelperTest -TestName "Pester Test StatusCake Test - Copy" -PassThru
        $result.Success | Should Be "True"
    }

}

Describe "StatusCake Contact Groups" {

    It "New-StatusCakeHelperContactGroup creates a contact group"{
        $script:SCContactGroup = New-StatusCakeHelperContactGroup -GroupName "Pester Test Contact Group" -Mobile "+12345678910"
        $SCContactGroup.Success | Should Be "True"
    }

    It "Get-StatusCakeHelperAllContactGroups retrieves all contact groups"{
        $results = Get-StatusCakeHelperAllContactGroups
        $results.count | Should -BeGreaterThan 0
    }

    It "Set-StatusCakeHelperContactGroup adds a email address"{
        $result = Set-StatusCakeHelperContactGroup -ContactID $SCContactGroup.InsertID -Email @("pestertest@example.com")
        $result.Success | Should Be "True"
    }

    It "Copy-StatusCakeHelperContactGroup copies a contact"{
        $result = Copy-StatusCakeHelperContactGroup -ContactID $SCContactGroup.InsertID -NewGroupName "Pester Test Contact Group - Copy"
        $result.Success | Should Be "True"
    }

    It "Get-StatusCakeHelperContactGroup retrieves a contact by group name"{
        $result = Get-StatusCakeHelperContactGroup -GroupName $SCContactGroup.Data.GroupName
        $result | Should Be $true
    }

    It "Remove-StatusCakeHelperContactGroup removes a contact by ID"{
        $result = Remove-StatusCakeHelperContactGroup -ContactID $SCContactGroup.InsertID -PassThru
        $result.Success | Should Be "True"
    }

    It "Remove-StatusCakeHelperContactGroup removes a contact by name"{
        $result = Remove-StatusCakeHelperContactGroup -GroupName "Pester Test Contact Group - Copy" -PassThru
        $result.Success | Should Be "True"
    }

}

Describe "StatusCake Page Speed Tests" {

    It "New-StatusCakeHelperPageSpeedTest creates a page speed test"{
        $script:SCPageSpeedTest = New-StatusCakeHelperPageSpeedTest -name "Pester Test Page Speed Check" -website_url "https://www.example.com" -location_iso UK -checkrate 1440
        $SCPageSpeedTest.Success | Should Be "True"
    }

    It "Get-StatusCakeHelperPageSpeedTest retrieves all Page Speed Tests"{
        $results = Get-StatusCakeHelperAllPageSpeedTests
        $results.count | Should -BeGreaterThan 0
    }

    It "Set-StatusCakeHelperPageSpeedTest updates the checkrate"{
        $result = Set-StatusCakeHelperPageSpeedTest -id $SCPageSpeedTest.data.new_id -checkrate 60
        $result.Success | Should Be "True"
    }

    It "Copy-StatusCakeHelperPageSpeedTest copies a Page Speed Test"{
        $result = Copy-StatusCakeHelperPageSpeedTest -id $SCPageSpeedTest.data.new_id -NewName "Pester Test Page Speed Check - Copy"
        $result.Success | Should Be "True"
    }

    It "Get-StatusCakeHelperPageSpeedTest retrieves a Page Speed test by name"{
        $result = Get-StatusCakeHelperPageSpeedTest -name "Pester Test Page Speed Check"
        $result | Should Be $true
    }

    It "Get-StatusCakeHelperPageSpeedTestHistory retrieves the history of a page speed check"{
        $result = Get-StatusCakeHelperPageSpeedTestHistory -id $SCPageSpeedTest.data.new_id
        $result | Should Be $true
    }

    It "Remove-StatusCakeHelperPageSpeedTest removes a test by ID"{
        $result = Remove-StatusCakeHelperPageSpeedTest -id $SCPageSpeedTest.data.new_id -PassThru
        $result.Success | Should Be "True"
    }

    It "Remove-StatusCakeHelperPageSpeedTest removes a test by name"{
        $result = Remove-StatusCakeHelperPageSpeedTest -name "Pester Test Page Speed Check - Copy" -PassThru
        $result.Success | Should Be "True"
    }

}

Describe "StatusCake SSL Tests" {

    It "New-StatusCakeHelperSSLTest creates a SSL Test"{
        $script:SCSSLTest = New-StatusCakeHelperSSLTest -domain "https://www.example.com" -checkrate 2073600
        $SCSSLTest.Success | Should Be "True"
    }

    It "Get-StatusCakeHelperAllSSLTests retrieves all SSL Tests"{
        $results = Get-StatusCakeHelperAllSSLTests
        $results.count | Should -BeGreaterThan 0
    }

    It "Set-StatusCakeHelperSSLTest updates the checkrate"{
        $result = Set-StatusCakeHelperSSLTest -id $SCSSLTest.Message -checkrate 86400
        $result.Success | Should Be "True"
    }

    It "Copy-StatusCakeHelperSSLTest copies a SSL Test"{
        $result = Copy-StatusCakeHelperSSLTest -id $SCSSLTest.Message -newdomain "https://www.example.org"
        $result.Success | Should Be "True"
    }

    It "Get-StatusCakeHelperSSLTest retrieves a SSL test by domain"{
        $result = Get-StatusCakeHelperSSLTest -domain "https://www.example.com"
        $result | Should Be $true
    }

    It "Remove-StatusCakeHelperSSLTest removes a SSL test by ID"{
        $result = Remove-StatusCakeHelperSSLTest -id $SCSSLTest.Message -PassThru
        $result.Success | Should Be "True"
    }

    It "Remove-StatusCakeHelperSSLTest removes a SSL test by domain"{
        $result = Remove-StatusCakeHelperSSLTest -domain "https://www.example.org" -PassThru
        $result.Success | Should Be "True"
    }

}

Describe "StatusCake Maintenance Windows" {

    It "New-StatusCakeHelperMaintenanceWindow creates a maintenance window"{
        $script:SCTest = New-StatusCakeHelperTest -TestName "Pester Test SC Test for MW" -TestURL "https://www.example.com" -checkRate 24000 -testType HTTP
        $script:SCMWTest = New-StatusCakeHelperMaintenanceWindow -name "Pester Test Maintenance Window" -timezone UTC -start_date $(Get-Date).AddHours(1) -end_date $(Get-Date).AddDays(1) -raw_tests @($SCTest.InsertID)
        $SCMWTest.Success | Should Be "True"
    }

    It "Get-StatusCakeHelperAllMaintenanceWindows retrieves all maintenance windows"{
        $results = Get-StatusCakeHelperAllMaintenanceWindows
        $results.count | Should -BeGreaterThan 0
    }

    It "Update-StatusCakeHelperMaintenanceWindow updates the maintenance window"{
        $result = Update-StatusCakeHelperMaintenanceWindow -id $SCMWTest.data.new_id -recur_every 30
        $result.Success | Should Be "True"
    }

    It "Clear-StatusCakeHelperMaintenanceWindow clears a test associated with a maintenance window"{
        $result = Clear-StatusCakeHelperMaintenanceWindow -id $SCMWTest.data.new_id -raw_tests
        $result.Success | Should Be "True"
    }

    It "Get-StatusCakeHelperMaintenanceWindow retrieves a maintenance window by name"{
        $result = Get-StatusCakeHelperMaintenanceWindow -name "Pester Test Maintenance Window"
        $result | Where-Object {$_.state -eq "Pending"} | Select-Object -ExpandProperty "name" | Should Be "Pester Test Maintenance Window"
        $result.id | Should -BeGreaterThan 0
    }

    It "Remove-StatusCakeHelperMaintenanceWindow removes a maintenance window"{
        Remove-StatusCakeHelperTest -TestName "Pester Test SC Test for MW"
        $result = Remove-StatusCakeHelperMaintenanceWindow -id $SCMWTest.data.new_id -Series $true -PassThru
        $result.Success | Should Be "True"
    }

}

Describe "StatusCake Public Reporting Pages" {

    It "New-StatusCakeHelperPublicReportingPage creates a public reporting page"{
        $script:SCPRPage = New-StatusCakeHelperPublicReportingPage -title "Pester Test Public Reporting Page" -display_orbs $false
        $SCPRPage.Success | Should Be "True"
    }

    It "Get-StatusCakeHelperAllPublicReportingPages retrieves all public reporting pages"{
        $results = Get-StatusCakeHelperPublicReportingPage
        $results.count | Should -BeGreaterThan 0
    }

    It "Get-StatusCakeHelperPublicReportingPage retrieves a public reporting page by title"{
        Get-StatusCakeHelperPublicReportingPage -title "Pester Test Public Reporting Page" | Should Be $true
    }

    It "Set-StatusCakeHelperPublicReportingPage updates a public reporting page"{
        $result = Set-StatusCakeHelperPublicReportingPage -id $SCPRPage.data.new_id -display_orbs $true
        $result.Success | Should Be "True"
    }

    It "Copy-StatusCakeHelperPublicReportingPage copies a Public Reporting Page"{
        $result = Copy-StatusCakeHelperPublicReportingPage -id $SCPRPage.data.new_id -newtitle "Pester Test Public Reporting Page (Copy)"
        $result.Success | Should Be "True"
    }

    It "Remove-StatusCakeHelperPublicReportingPage removes a public reporting page"{
        Remove-StatusCakeHelperPublicReportingPage -Title "Pester Test Public Reporting Page (Copy)"
        $result = Remove-StatusCakeHelperPublicReportingPage -id $SCPRPage.data.new_id -PassThru
        $result.Success | Should Be "True"
    }

}