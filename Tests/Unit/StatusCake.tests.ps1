Param(
    [ValidateNotNullOrEmpty()]
    [string]$StatusCakeUserName = $env:StatusCake_Username,
    [ValidateNotNullOrEmpty()]
    [string]$StatusCakeAPIKey = $env:StatusCake_API_Key
)
Remove-Module $env:BHPROJECTNAME -ErrorAction SilentlyContinue

Describe 'StatusCake Module Tests' {

    It "Module statuscake-helpers imports without throwing an exception" {
        {Import-Module $env:BHPSModuleManifest -Force } | Should -Not -Throw
    }

}

Import-Module $env:BHPSModuleManifest -Force

if(! (Test-StatusCakeHelperAPIAuthSet))
{
    $scUser = $StatusCakeUserName
    $scAPIKey = ConvertTo-SecureString -String $StatusCakeAPIKey -AsPlainText -Force
    $scCredentials = New-Object System.Management.Automation.PSCredential ($scUser, $scAPIKey)
    Set-StatusCakeHelperAPIAuth -Credential $scCredentials -Session
}

Describe "StatusCake Tests" {

    It "New-StatusCakeHelperTest creates a test"{
        $Script:SCTest = New-StatusCakeHelperTest -TestName "Pester Test StatusCake Test" -TestURL "https://www.example.com" -checkRate 300 -testType HTTP
        $scTest.WebsiteName | Should -Be "Pester Test StatusCake Test"
        $scTest.URI | Should -Be "https://www.example.com"
        $scTest.CheckRate | Should -Be 300
        $scTest.TestType | Should -Be "HTTP"
    }

    It "Get-StatusCakeHelperTest retrieves all tests"{
        $results = Get-StatusCakeHelperTest
        $results.count | Should -BeGreaterThan 0
    }

    It "Get-StatusCakeHelperTest retrieves the detailed data for specific test"{
        $result = Get-StatusCakeHelperTestDetail -TestID $SCTest.TestID
        $result.StatusCodes.count | Should -BeGreaterOrEqual 10 -Because "Status Codes are only part of detailed test data"
    }

    It "Copy-StatusCakeHelperTest copies a test"{
        $result = Copy-StatusCakeHelperTest -TestName "Pester Test StatusCake Test" -NewTestName "Pester Test StatusCake Test - Copy"
        $result.WebsiteName | Should -Be "Pester Test StatusCake Test - Copy"
        $result.URI | Should -Be "https://www.example.com"
        $result.CheckRate | Should -Be 300
        $result.TestType | Should -Be "HTTP"
    }

    It "Suspend-StatusCakeHelperTest pauses a test"{
        Suspend-StatusCakeHelperTest -TestID $SCTest.TestID
        $test = Get-StatusCakeHelperTest -TestID $SCTest.TestID
        $test.Paused | Should -Be "True"
    }

    It "Get-StatusCakeHelperPausedTest retrieves paused tests"{
        $result = Get-StatusCakeHelperPausedTest -Minutes 1 -IncludeNotTested
        $result.Paused | Should -Not -Contain $False
    }

    It "Get-StatusCakeHelperTest retrieves the test created by name"{
        $result = Get-StatusCakeHelperTest -TestName $SCTest.WebsiteName
        $result.WebsiteName | Should -Be "Pester Test StatusCake Test"
    }

    It "Add-StatusCakeHelperTestTag adds tags to a test"{
        Add-StatusCakeHelperTestTag -TestID $SCTest.TestID -TestTags @("Pester Test","Add Tags Test")
        $test = Get-StatusCakeHelperTestDetail -TestID $SCTest.TestID
        $test.Tags | Should -Contain "Pester Test"
        $test.Tags | Should -Contain "Add Tags Test"
    }

    It "Remove-StatusCakeHelperTestTag removes tags from a test"{
        Remove-StatusCakeHelperTestTag -TestID $SCTest.TestID -TestTags @("Add Tags Test")
        $result = Get-StatusCakeHelperTestDetail -TestID $SCTest.TestID
        $result.Tags | Should -Contain "Pester Test"
        $result.Tags | Should -Not -Contain "Add Tags Test"
    }

    It "Get-StatusCakeHelperTest retrieves tests filtered by a tag"{
        $results = Get-StatusCakeHelperTest -tags @("Pester Test")
        $results.TestTags | Should -Contain "Pester Test"
    }

    It "Remove-StatusCakeHelperTestStatusCode removes a status code from a test"{
        Remove-StatusCakeHelperTestStatusCode -TestID $SCTest.TestID -StatusCodes 401
        $testData = Get-StatusCakeHelperTestDetail -TestID $SCTest.TestID
        $testData.StatusCodes | Should -Not -Contain 401
    }

    It "Add-StatusCakeHelperTestStatusCode adds a status code to a test"{
        Add-StatusCakeHelperTestStatusCode -TestID $SCTest.TestID -StatusCodes 401
        $testData = Get-StatusCakeHelperTest -TestID $SCTest.TestID -Detailed
        $testData.StatusCodes | Should -Contain 401
    }

    It "Remove-StatusCakeHelperTest removes a test"{
        Remove-StatusCakeHelperTest -TestID $SCTest.TestID
        $testData = Get-StatusCakeHelperTest
        $testData.TestID | Should -Not -Contain $SCTest.TestID
    }

    It "Remove-StatusCakeHelperTest removes a test by name"{
        Remove-StatusCakeHelperTest -TestName "Pester Test StatusCake Test - Copy"
        $testData = Get-StatusCakeHelperTest
        $testData.WebsiteName | Should -Not -Contain "Pester Test StatusCake Test - Copy"
    }

}

Describe "StatusCake Contact Groups" {

    It "New-StatusCakeHelperContactGroup creates a contact group"{
        $script:SCContactGroup = New-StatusCakeHelperContactGroup -GroupName "Pester Test Contact Group" -Mobile "+12345678910"
        $SCContactGroup.GroupName | Should -Be "Pester Test Contact Group"
        #$SCContactGroup.Mobiles | Should -Contain "+12345678910"
    }

    It "Get-StatusCakeHelperContactGroup retrieves all contact groups"{
        $results = Get-StatusCakeHelperContactGroup
        $results.count | Should -BeGreaterThan 0
    }

    It "Set-StatusCakeHelperContactGroup adds a email address"{
        $result = Set-StatusCakeHelperContactGroup -ContactID $SCContactGroup.ContactID -Email @("pestertest@example.com")
        $result.Emails | Should -Contain "pestertest@example.com"
    }

    It "Copy-StatusCakeHelperContactGroup copies a contact"{
        $result = Copy-StatusCakeHelperContactGroup -ContactID $SCContactGroup.ContactID -NewGroupName "Pester Test Contact Group - Copy"
        $result.GroupName | Should -Be "Pester Test Contact Group - Copy"
        #$result.Mobiles | Should -Contain "+12345678910"
    }

    It "Get-StatusCakeHelperContactGroup retrieves a contact by group name"{
        $result = Get-StatusCakeHelperContactGroup -GroupName "Pester Test Contact Group"
        $result.GroupName | Should -Be "Pester Test Contact Group"
    }

    It "Remove-StatusCakeHelperContactGroup removes a contact by ID"{
        Remove-StatusCakeHelperContactGroup -ContactID $SCContactGroup.ContactID
        $results = Get-StatusCakeHelperContactGroup
        $results.ContactID | Should -Not -Contain $SCContactGroup.ContactID
    }

    It "Remove-StatusCakeHelperContactGroup removes a contact by name"{
        Remove-StatusCakeHelperContactGroup -GroupName "Pester Test Contact Group - Copy"
        $results = Get-StatusCakeHelperContactGroup
        $results.GroupName | Should -Not -Contain "Pester Test Contact Group - Copy"
    }

}

Describe "StatusCake Page Speed Tests" {

    It "New-StatusCakeHelperPageSpeedTest creates a page speed test"{
        $script:SCPageSpeedTest = New-StatusCakeHelperPageSpeedTest -Name "Pester Test Page Speed Check" -WebsiteURL "https://www.example.com" -LocationISO UK -Checkrate 1440
        $SCPageSpeedTest.Name | Should -Be "Pester Test Page Speed Check"
        $SCPageSpeedTest.Website_URL | Should -Be "https://www.example.com"
        $SCPageSpeedTest.Location_ISO | Should -Be "UK"
        $SCPageSpeedTest.CheckRate | Should -Be 1440
    }

    It "Get-StatusCakeHelperPageSpeedTest retrieves all Page Speed Tests"{
        $results = Get-StatusCakeHelperPageSpeedTest
        $results.count | Should -BeGreaterThan 0
    }

    It "Set-StatusCakeHelperPageSpeedTest updates the checkrate"{
        $result = Set-StatusCakeHelperPageSpeedTest -ID $SCPageSpeedTest.id -Checkrate 60
        $result.CheckRate | Should Be 60
    }

    It "Copy-StatusCakeHelperPageSpeedTest copies a Page Speed Test"{
        $result = Copy-StatusCakeHelperPageSpeedTest -ID $SCPageSpeedTest.id -NewName "Pester Test Page Speed Check - Copy"
        $result.Name | Should -Be "Pester Test Page Speed Check - Copy"
        $result.Website_URL | Should -Be "https://www.example.com"
        $result.Location_ISO | Should -Be "UK"
        $result.checkrate | Should -Be 60
    }

    It "Get-StatusCakeHelperPageSpeedTest retrieves a Page Speed test by name"{
        $result = Get-StatusCakeHelperPageSpeedTest -Name "Pester Test Page Speed Check"
        $result.Title | Should Be "Pester Test Page Speed Check"
    }

    It "Get-StatusCakeHelperPageSpeedTestHistory retrieves the history of a page speed check"{
        $result = Get-StatusCakeHelperPageSpeedTestHistory -ID $SCPageSpeedTest.id
        $result | Should Be $true
    }

    It "Remove-StatusCakeHelperPageSpeedTest removes a test by ID"{
        Remove-StatusCakeHelperPageSpeedTest -ID $SCPageSpeedTest.id
        $results = Get-StatusCakeHelperPageSpeedTest
        $results.Title | Should -Not -Contain "Pester Test Page Speed Check"
    }

    It "Remove-StatusCakeHelperPageSpeedTest removes a test by name"{
        Remove-StatusCakeHelperPageSpeedTest -Name "Pester Test Page Speed Check - Copy"
        $results = Get-StatusCakeHelperPageSpeedTest
        $results.Title | Should -Not -Contain "Pester Test Page Speed Check - Copy"
    }

}

Describe "StatusCake SSL Tests" {

    It "New-StatusCakeHelperSSLTest creates a SSL Test"{
        $script:SCSSLTest = New-StatusCakeHelperSSLTest -Domain "https://www.example.com" -Checkrate 2073600
        $SCSSLTest.domain | Should -Be "https://www.example.com"
        $SCSSLTest.checkrate | Should -Be 2073600
    }

    It "Get-StatusCakeHelperSSLTest retrieves all SSL Tests"{
        $results = Get-StatusCakeHelperSSLTest
        $results.count | Should -BeGreaterThan 0
    }

    It "Set-StatusCakeHelperSSLTest updates the checkrate"{
        $result = Set-StatusCakeHelperSSLTest -ID $SCSSLTest.ID -Checkrate 86400
        $result.checkrate | Should -Be 86400
    }

    It "Copy-StatusCakeHelperSSLTest copies a SSL Test"{
        $result = Copy-StatusCakeHelperSSLTest -ID $SCSSLTest.ID -NewDomain "https://www.example.org"
        $result.domain | Should -Be "https://www.example.org"
        $result.checkrate | Should -Be 86400
    }

    It "Get-StatusCakeHelperSSLTest retrieves a SSL test by domain"{
        $result = Get-StatusCakeHelperSSLTest -Domain "https://www.example.com"
        $result.domain | Should -Be "https://www.example.com"
    }

    It "Remove-StatusCakeHelperSSLTest removes a SSL test by ID"{
        Remove-StatusCakeHelperSSLTest -ID $SCSSLTest.Id
        $results = Get-StatusCakeHelperSSLTest
        $results.ID | Should -Not -Contain $SCSSLTest.Id
    }

    It "Remove-StatusCakeHelperSSLTest removes a SSL test by domain"{
        Remove-StatusCakeHelperSSLTest -Domain "https://www.example.org"
        $results = Get-StatusCakeHelperSSLTest
        $results.domain | Should -Not -Contain "https://www.example.org"
    }

}

Describe "StatusCake Maintenance Windows" {

    It "New-StatusCakeHelperMaintenanceWindow creates a maintenance window"{
        $script:SCTest = New-StatusCakeHelperTest -TestName "Pester Test SC Test for Maintenance Window" -TestURL "https://www.example.com" -Checkrate 24000 -TestType HTTP
        $startDate = $(Get-Date).AddHours(1)
        $endDate = $(Get-Date).AddDays(1)

        $startDateString = ($startDate | Get-Date -Format 'yyyy-MM-dd HH:mm:ss').ToString()
        $endDateString = ($endDate | Get-Date -Format 'yyyy-MM-dd HH:mm:ss').ToString()
        $startDateString = $startDateString.substring(0,$startDateString.length-1) + '*'
        $endDateString = $endDateString.substring(0,$endDateString.length-1) + '*'

        $script:mwName = "Pester Test Maintenance Window - $($startDate.ToUniversalTime().ToString())"
        $script:SCMWTest = New-StatusCakeHelperMaintenanceWindow -Name $mwName -Timezone UTC -StartDate $startDate -EndDate $endDate -TestIDs @($SCTest.TestID)

        $SCMWTest.name | Should -Be "Pester Test Maintenance Window - $($startDate.ToUniversalTime().ToString())"
        $SCMWTest.timezone | Should -Be "UTC"
        $SCMWTest.start_utc | Should -BeLike $startDateString -Because "Start time can differ by up a second from when command is sent"
        $SCMWTest.end_utc | Should -BeLike $endDateString -Because "End time can differ by up a second from when command is sent"
        $SCMWTest.raw_tests | Should -Contain $SCTest.TestID
    }

    It "Get-StatusCakeHelperMaintenanceWindow retrieves all maintenance windows"{
        $results = Get-StatusCakeHelperMaintenanceWindow
        $results.count | Should -BeGreaterThan 0
    }

    It "Update-StatusCakeHelperMaintenanceWindow updates the maintenance window" -Skip{
        $result = Update-StatusCakeHelperMaintenanceWindow -ID $SCMWTest.id -RecurEvery 30
        $result.Success | Should Be "True"
    }

    It "Clear-StatusCakeHelperMaintenanceWindow clears a test associated with a maintenance window" -Skip{
        Clear-StatusCakeHelperMaintenanceWindow -ID $SCMWTest.id -TestIDs
        $results = Get-StatusCakeHelperMaintenanceWindow -ID $SCMWTest.id
        $results.raw_tests | Should -BeFalse
    }

    It "Get-StatusCakeHelperMaintenanceWindow retrieves a maintenance window by name"{
        $result = Get-StatusCakeHelperMaintenanceWindow -Name $mwName
        $result | Where-Object {$_.state -eq "Pending"} | Select-Object -ExpandProperty "name" | Should Be $mwName
        $result.id | Should -BeGreaterThan 0
    }

    It "Remove-StatusCakeHelperMaintenanceWindow removes a maintenance window"{
        Remove-StatusCakeHelperTest -TestName "Pester Test SC Test for Maintenance Window"
        Remove-StatusCakeHelperMaintenanceWindow -ID $SCMWTest.id -Series
        $results = Get-StatusCakeHelperMaintenanceWindow
        $results.id | Should -Not -Contain $SCMWTest.id
    }

}

Describe "StatusCake Public Reporting Pages" {

    It "New-StatusCakeHelperPublicReportingPage creates a public reporting page"{
        $script:SCTest = New-StatusCakeHelperTest -TestName "Pester Test SC Test for Public Reporting Page" -TestURL "https://www.example.com" -Tags @("Pester Test") -checkRate 24000 -testType HTTP
        $script:SCPRPage = New-StatusCakeHelperPublicReportingPage -Title "Pester Test Public Reporting Page" -TestIDs @($SCTest.TestID) -SearchIndexing $false
        $SCPRPage.title | Should -Be "Pester Test Public Reporting Page"
        $SCPRPage.tests_or_tags | Should -Contain $SCTest.TestID
    }

    It "Get-StatusCakeHelperPublicReportingPage retrieves all public reporting pages"{
        $results = Get-StatusCakeHelperPublicReportingPage
        $results.count | Should -BeGreaterThan 0
    }

    It "Get-StatusCakeHelperPublicReportingPage retrieves a public reporting page by title"{
        $result = Get-StatusCakeHelperPublicReportingPage -Title "Pester Test Public Reporting Page"
        $result.title | Should -Be "Pester Test Public Reporting Page"
    }

    It "Set-StatusCakeHelperPublicReportingPage updates a public reporting page to use a tag"{
        $result = Set-StatusCakeHelperPublicReportingPage -ID $SCPRPage.id -SearchIndexing $true -TestTags @("Pester Test")
        $result.search_indexing | Should -Be "True"
        $result.tests_or_tags | Should -Contain "Pester Test"
    }

    It "Get-StatusCakeHelperPublicReportingPageDetail retrieves detailed data about a public reporting page"{
        $result = Get-StatusCakeHelperPublicReportingPageDetail -ID $SCPRPage.id
        $result.title | Should -Be "Pester Test Public Reporting Page"
        $result.search_indexing | Should -Be "True"
    }

    It "Copy-StatusCakeHelperPublicReportingPage copies a Public Reporting Page"{
        $result = Copy-StatusCakeHelperPublicReportingPage -ID $SCPRPage.id -NewTitle "Pester Test Public Reporting Page (Copy)"
        $result.title | Should -Be "Pester Test Public Reporting Page (Copy)"
        $result.search_indexing | Should -Be "True"
        $result.tests_or_tags | Should -Contain "Pester Test"
    }

    It "Remove-StatusCakeHelperPublicReportingPage removes a public reporting page"{
        Remove-StatusCakeHelperPublicReportingPage -Title "Pester Test Public Reporting Page (Copy)"
        Remove-StatusCakeHelperPublicReportingPage -ID $SCPRPage.id
        Remove-StatusCakeHelperTest -TestID $SCTest.TestID
        $results = Get-StatusCakeHelperPublicReportingPage
        $results.title | Should -Not -Contain "Pester Test Public Reporting Page (Copy)"
        $results.id | Should -Not -Contain $SCPRPage.id
    }

}