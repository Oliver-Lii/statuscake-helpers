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

Describe "StatusCake Uptime Tests" {

    It "New-StatusCakeHelperUptimeTest creates a HTTP uptime test"{
        $Script:SCUptimeTest = New-StatusCakeHelperUptimeTest -Name "Pester Test HTTP Uptime Test" -WebsiteURL "https://www.example.com" -CheckRate 86400 -Type HTTP -Confirmation 1 -Tag "Pester Test" -PassThru
        $SCUptimeTest.name | Should -Be "Pester Test HTTP Uptime Test"
        $SCUptimeTest.website_url | Should -Be "https://www.example.com"
        $SCUptimeTest.check_rate | Should -Be 86400
        $SCUptimeTest.test_type | Should -Be "HTTP"
        $SCUptimeTest.confirmation | Should -Be 1
    }

    It "New-StatusCakeHelperUptimeTest creates a DNS uptime test"{
        $Script:SCDNSUptimeTest = New-StatusCakeHelperUptimeTest -Name "Pester Test DNS Check" -WebsiteURL "dns.google" -CheckRate 86400 -Type DNS -Confirmation 1 -Tag "Pester Test" -DNSIPs @("8.8.8.8","8.8.4.4") -DNSServer "1.1.1.1" -PassThru
        $SCDNSUptimeTest.name | Should -Be "Pester Test DNS Check"
        $SCDNSUptimeTest.website_url | Should -Be "dns.google"
        $SCDNSUptimeTest.check_rate | Should -Be 86400
        $SCDNSUptimeTest.test_type | Should -Be "DNS"
        $SCDNSUptimeTest.confirmation | Should -Be 1
        $SCDNSUptimeTest.dns_ips | Should -Contain "8.8.8.8"
        $SCDNSUptimeTest.dns_server | Should -Be "1.1.1.1"
    }

    It "Get-StatusCakeHelperUptimeTest retrieves a uptime test by ID"{
        $result = Get-StatusCakeHelperUptimeTest -ID $SCUptimeTest.id
        $result.id | Should -Be $SCUptimeTest.id
    }

    It "Copy-StatusCakeHelperUptimeTest copies a test"{
        $SCUptimeIDCopy = Copy-StatusCakeHelperUptimeTest -ID $SCUptimeTest.id -NewName "Pester Test HTTP Uptime Test - Copy"
        $result = Get-StatusCakeHelperUptimeTest -ID $SCUptimeIDCopy
        $result.name | Should -Be "Pester Test HTTP Uptime Test - Copy"
        $result.website_url | Should -Be "https://www.example.com"
        $result.check_rate | Should -Be 86400
        $result.test_type | Should -Be "HTTP"
        $result.confirmation | Should -Be 1
    }

    It "Suspend-StatusCakeHelperUptimeTest pauses a test"{
        Suspend-StatusCakeHelperUptimeTest -ID $SCUptimeTest.id
        $test = Get-StatusCakeHelperUptimeTest -ID $SCUptimeTest.id
        $test.paused | Should -Be "True"
    }

    It "Get-StatusCakeHelperUptimePausedTest retrieves paused tests"{
        $result = Get-StatusCakeHelperUptimePausedTest -Minutes 1 -IncludeNotTested
        $result.paused | Should -Not -Contain $False
    }

    It "Get-StatusCakeHelperUptimeTest retrieves the test created by name"{
        $result = Get-StatusCakeHelperUptimeTest -Name "Pester Test HTTP Uptime Test - Copy"
        $result.name | Should -Be "Pester Test HTTP Uptime Test - Copy"
    }

    It "Get-StatusCakeHelperUptimeTest retrieves tests filtered by a tag"{
        $results = Get-StatusCakeHelperUptimeTest -Tag @("Pester Test")
        $results.tags | Sort-Object -Unique | Should -Be "Pester Test"
    }

    It "Get-StatusCakeHelperUptimeAlert retrieves no more than 150 alerts sent for a test"{
        $result = Get-StatusCakeHelperUptimeAlert -ID 5084968 -Limit 150
        $result.count | Should -BeGreaterOrEqual 2
        $result.count | Should -BeLessOrEqual 150
    }

    It "Get-StatusCakeHelperUptimeHistory no more than 150 items of uptime test history"{
        $result = Get-StatusCakeHelperUptimeHistory -ID 3022884 -Limit 150
        $result.count | Should -BeGreaterOrEqual 2
        $result.count | Should -BeLessOrEqual 150
    }

    It "Get-StatusCakeHelperUptimePeriod retrieves no more than 150 uptime check periods"{
        $result = Get-StatusCakeHelperUptimePeriod -ID 3022884 -Limit 150
        $result.count | Should -BeGreaterOrEqual 2
        $result.count | Should -BeLessOrEqual 150
    }

    It "Remove-StatusCakeHelperUptimeTest removes a test by ID"{
        Remove-StatusCakeHelperUptimeTest -ID $SCUptimeTest.id
        Remove-StatusCakeHelperUptimeTest -ID $SCDNSUptimeTest.id
        $testData = Get-StatusCakeHelperUptimeTest
        $testData.id | Should -Not -Contain $SCUptimeTest.id
        $testData.id | Should -Not -Contain $SCDNSUptimeTest.id
    }

    It "Remove-StatusCakeHelperUptimeTest removes a test by name"{
        Remove-StatusCakeHelperUptimeTest -Name "Pester Test HTTP Uptime Test - Copy"
        $testData = Get-StatusCakeHelperUptimeTest
        $testData.name | Should -Not -Contain "Pester Test HTTP Uptime Test - Copy"
    }

}