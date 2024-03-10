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

Describe "StatusCake Heartbeat Tests" {

    It "New-StatusCakeHelperHeartbeatTest creates a Heartbeat Test"{
        $script:SCHeartbeatTestID = New-StatusCakeHelperHeartbeatTest -Name "Pester Test Heartbeat Check" -Period 172000 -Tags "Pester Test"
        $SCHeartbeatTest = Get-StatusCakeHelperHeartbeatTest -ID $SCHeartbeatTestID
        $SCHeartbeatTest.name | Should -Be "Pester Test Heartbeat Check"
        $SCHeartbeatTest.period | Should -Be 172000
        $SCHeartbeatTest.tags | Should -Contain "Pester Test"
    }

    It "Get-StatusCakeHelperHeartbeatTest retrieves an Heartbeat test by ID"{
        $result = Get-StatusCakeHelperHeartbeatTest -ID $SCHeartbeatTestID
        $result.id | Should -Be $SCHeartbeatTestID
        $result.name | Should -Be "Pester Test Heartbeat Check"
    }

    It "Update-StatusCakeHelperHeartbeatTest updates the period"{
        Update-StatusCakeHelperHeartbeatTest -ID $SCHeartbeatTestID -Period 86400
        $result = Get-StatusCakeHelperHeartbeatTest -ID $SCHeartbeatTestID
        $result.period | Should -Be 86400
    }

    It "Copy-StatusCakeHelperHeartbeatTest copies a Heartbeat Test"{
        $SCHeartbeatTestIDCopy = Copy-StatusCakeHelperHeartbeatTest -ID $SCHeartbeatTestID -NewName "Pester Test Heartbeat Check Copy"
        $result = Get-StatusCakeHelperHeartbeatTest -ID $SCHeartbeatTestIDCopy
        $result.name | Should -Be "Pester Test Heartbeat Check Copy"
        $result.period | Should -Be 86400
    }

    It "Get-StatusCakeHelperHeartbeatTest retrieves all Heartbeat Tests"{
        $results = Get-StatusCakeHelperHeartbeatTest
        $results.count | Should -BeGreaterThan 1
    }

    It "Get-StatusCakeHelperHeartbeatTest retrieves an Heartbeat test by name"{
        $result = Get-StatusCakeHelperHeartbeatTest -Name "Pester Test Heartbeat Check Copy"
        $result.name | Should -Be "Pester Test Heartbeat Check Copy"
    }

    It "Remove-StatusCakeHelperHeartbeatTest removes an Heartbeat test by ID"{
        Remove-StatusCakeHelperHeartbeatTest -ID $SCHeartbeatTestID
        $results = Get-StatusCakeHelperHeartbeatTest
        $results.id | Should -Not -Contain $SCHeartbeatTestID
    }

    It "Remove-StatusCakeHelperHeartbeatTest removes a Heartbeat test by name"{
        Remove-StatusCakeHelperHeartbeatTest -Name "Pester Test Heartbeat Check Copy"
        $results = Get-StatusCakeHelperHeartbeatTest
        $results.name | Should -Not -Contain "Pester Test Heartbeat Check Copy"
    }

}
