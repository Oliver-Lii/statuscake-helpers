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

Describe "StatusCake Contact Groups" {

    It "New-StatusCakeHelperContactGroup creates a contact group"{
        $script:SCContactID = New-StatusCakeHelperContactGroup -Name "Pester Test Contact Group" -Mobile "+12345678910"
        $SCContactID | Should -BeGreaterThan 0
    }

    It "Get-StatusCakeHelperContactGroup retrieves a contact group by ID"{
        $result = Get-StatusCakeHelperContactGroup -ID $SCContactID
        $result.name | Should -Be "Pester Test Contact Group"
        $result.mobile_numbers | Should -Be "+12345678910"
    }

    It "Update-StatusCakeHelperContactGroup adds an email address by ID"{
        Update-StatusCakeHelperContactGroup -ID $SCContactID -Email @("pestertest@example.com")
        $result = Get-StatusCakeHelperContactGroup -ID $SCContactID
        $result.email_addresses | Should -Contain "pestertest@example.com"
    }

    It "Copy-StatusCakeHelperContactGroup copies a contact"{
        $SCContactIDCopy = Copy-StatusCakeHelperContactGroup -ID $SCContactID -NewName "Pester Test Contact Group - Copy"
        $result = Get-StatusCakeHelperContactGroup -ID $SCContactIDCopy
        $result.name | Should -Be "Pester Test Contact Group - Copy"
        $result.mobile_numbers | Should -Contain "+12345678910"
        $result.email_addresses | Should -Contain "pestertest@example.com"
    }

    It "Get-StatusCakeHelperContactGroup retrieves a contact by group name"{
        $result = Get-StatusCakeHelperContactGroup -Name "Pester Test Contact Group"
        $result.name | Should -Be "Pester Test Contact Group"
    }

    It "Update-StatusCakeHelperContactGroup adds a email address by name"{
        Update-StatusCakeHelperContactGroup -Name "Pester Test Contact Group - Copy" -Email @("pestertest@example.org")
        $result = Get-StatusCakeHelperContactGroup -Name "Pester Test Contact Group - Copy"
        $result.email_addresses | Should -Contain "pestertest@example.org"
    }

    It "Get-StatusCakeHelperContactGroup retrieves all contact groups"{
        $result = Get-StatusCakeHelperContactGroup
        $result.count | Should -BeGreaterOrEqual 2
    }

    It "Remove-StatusCakeHelperContactGroup removes a contact by ID"{
        Remove-StatusCakeHelperContactGroup -ID $SCContactID
        $results = Get-StatusCakeHelperContactGroup
        $results.id | Should -Not -Contain $SCContactGroup.ContactID
    }

    It "Remove-StatusCakeHelperContactGroup removes a contact by name"{
        Remove-StatusCakeHelperContactGroup -Name "Pester Test Contact Group - Copy"
        $results = Get-StatusCakeHelperContactGroup
        $results.name | Should -Not -Contain "Pester Test Contact Group - Copy"
    }

}
