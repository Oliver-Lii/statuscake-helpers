Param(
    [ValidateNotNullOrEmpty()]
    [string]$StatusCakeUserName = $env:StatusCake_Username,
    [ValidateNotNullOrEmpty()]
    [string]$StatusCakeAPIKey = $env:StatusCake_API_Key
)

if(! (Test-StatusCakeHelperAPIAuthSet))
{
    $scUser = $StatusCakeUserName
    $scAPIKey = ConvertTo-SecureString -String $StatusCakeAPIKey -AsPlainText -Force
    $scCredentials = New-Object System.Management.Automation.PSCredential ($scUser, $scAPIKey)
    Set-StatusCakeHelperAPIAuth -Credential $scCredentials -Session
}

Describe "StatusCake Page Speed Tests" {

    It "New-StatusCakeHelperPageSpeedTest creates a page speed test"{
        $script:SCPageSpeedTestID = New-StatusCakeHelperPageSpeedTest -Name "Pester Test Page Speed Check" -WebsiteURL "https://www.example.com" -Region UK -Checkrate 86400
        $SCPageSpeedTest = Get-StatusCakeHelperPageSpeedTest -ID $SCPageSpeedTestID
        $SCPageSpeedTest.name | Should -Be "Pester Test Page Speed Check"
        $SCPageSpeedTest.website_url | Should -Be "https://www.example.com"
        $SCPageSpeedTest.check_rate | Should -Be 86400
    }

    It "Get-StatusCakeHelperPageSpeedTest retrieves a page speed test by ID"{
        $result = Get-StatusCakeHelperPageSpeedTest -ID $SCPageSpeedTestID
        $result.name | Should -Be "Pester Test Page Speed Check"
        $result.website_url | Should -Be "https://www.example.com"
        $result.check_rate | Should -Be 86400
    }

    It "Update-StatusCakeHelperPageSpeedTest updates the checkrate"{
        $result = Update-StatusCakeHelperPageSpeedTest -ID $SCPageSpeedTestID -Checkrate 3600
        $result = Get-StatusCakeHelperPageSpeedTest -ID $SCPageSpeedTestID
        $result.check_rate | Should Be 3600
    }

    It "Copy-StatusCakeHelperPageSpeedTest copies a Page Speed Test"{
        $SCPageSpeedTestIDCopy = Copy-StatusCakeHelperPageSpeedTest -ID $SCPageSpeedTestID -NewName "Pester Test Page Speed Check - Copy" -Region UK
        $result = Get-StatusCakeHelperPageSpeedTest -ID $SCPageSpeedTestIDCopy
        $result.name | Should -Be "Pester Test Page Speed Check - Copy"
        $result.website_url | Should -Be "https://www.example.com"
        $result.check_rate | Should -Be 3600
    }

    It "Get-StatusCakeHelperPageSpeedTest retrieves all Page Speed Tests"{
        $results = Get-StatusCakeHelperPageSpeedTest
        $results.count | Should -BeGreaterThan 2
    }

    It "Get-StatusCakeHelperPageSpeedTest retrieves a Page Speed test by name"{
        $result = Get-StatusCakeHelperPageSpeedTest -Name "Pester Test Page Speed Check - Copy"
        $result.name | Should -Be "Pester Test Page Speed Check - Copy"
    }

    It "Get-StatusCakeHelperPageSpeedTestHistory retrieves the history of the first 29 page speed checks"{
        $result = Get-StatusCakeHelperPageSpeedTestHistory -ID 37700 -Limit 29
        $result.count | Should -BeGreaterThan 28
    }

    It "Get-StatusCakeHelperPageSpeedTestHistory retrieves the history of two page speed checks"{
        $result = Get-StatusCakeHelperPageSpeedTestHistory -ID 37700 -Limit 2
        $result.count | Should -Be  2
    }

    It "Remove-StatusCakeHelperPageSpeedTest removes a test by ID"{
        Remove-StatusCakeHelperPageSpeedTest -ID $SCPageSpeedTestID
        $results = Get-StatusCakeHelperPageSpeedTest
        $results.name | Should -Not -Contain "Pester Test Page Speed Check"
    }

    It "Remove-StatusCakeHelperPageSpeedTest removes a test by name"{
        Remove-StatusCakeHelperPageSpeedTest -Name "Pester Test Page Speed Check - Copy"
        $results = Get-StatusCakeHelperPageSpeedTest
        $results.name | Should -Not -Contain "Pester Test Page Speed Check - Copy"
    }

}
