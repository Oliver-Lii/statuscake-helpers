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

Describe "StatusCake SSL Tests" {

    It "New-StatusCakeHelperSSLTest creates a SSL Test"{
        $script:SCSSLTestID = New-StatusCakeHelperSSLTest -WebsiteURL "https://www.example.com" -Checkrate 2073600
        $SCSSLTest = Get-StatusCakeHelperSSLTest -ID $SCSSLTestID
        $SCSSLTest.website_url | Should -Be "https://www.example.com"
        $SCSSLTest.check_rate | Should -Be 2073600
    }

    It "Get-StatusCakeHelperSSLTest retrieves an SSL test by ID"{
        $result = Get-StatusCakeHelperSSLTest -ID $SCSSLTestID
        $result.website_url | Should -Be "https://www.example.com"
    }

    It "Update-StatusCakeHelperSSLTest updates the checkrate"{
        Update-StatusCakeHelperSSLTest -ID $SCSSLTestID -Checkrate 86400
        $result = Get-StatusCakeHelperSSLTest -ID $SCSSLTestID
        $result.check_rate | Should -Be 86400
    }

    It "Copy-StatusCakeHelperSSLTest copies a SSL Test"{
        $SCSSLTestIDCopy = Copy-StatusCakeHelperSSLTest -ID $SCSSLTestID -NewWebsiteURL "https://www.example.org"
        $result = Get-StatusCakeHelperSSLTest -ID $SCSSLTestIDCopy
        $result.website_url | Should -Be "https://www.example.org"
        $result.check_rate | Should -Be 86400
    }

    It "Get-StatusCakeHelperSSLTest retrieves all SSL Tests"{
        $results = Get-StatusCakeHelperSSLTest
        $results.count | Should -BeGreaterThan 2
    }

    It "Get-StatusCakeHelperSSLTest retrieves an SSL test by website_url"{
        $result = Get-StatusCakeHelperSSLTest -WebsiteURL "https://www.example.com"
        $result.website_url | Should -Be "https://www.example.com"
    }

    It "Remove-StatusCakeHelperSSLTest removes an SSL test by ID"{
        Remove-StatusCakeHelperSSLTest -ID $SCSSLTestID
        $results = Get-StatusCakeHelperSSLTest
        $results.id | Should -Not -Contain $SCSSLTestID
    }

    It "Remove-StatusCakeHelperSSLTest removes a SSL test by website_url"{
        Remove-StatusCakeHelperSSLTest -WebsiteURL "https://www.example.org"
        $results = Get-StatusCakeHelperSSLTest
        $results.website_url | Should -Not -Contain "https://www.example.org"
    }

}
