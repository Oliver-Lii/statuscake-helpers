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

Describe "StatusCake Maintenance Windows" {

    It "New-StatusCakeHelperMaintenanceWindow creates a maintenance window"{
        $script:SCTestID = New-StatusCakeHelperUptimeTest -Name "Pester Test SC Test for Maintenance Window" -WebsiteURL "https://www.example.com" -CheckRate 86400 -Type HTTP
        $startDate = $(Get-Date).AddHours(24)
        $endDate = $(Get-Date).AddHours(25)

        $script:mwName = "Pester Test Maintenance Window - $($startDate.ToUniversalTime().ToString())"
        $script:SCMWTestID = New-StatusCakeHelperMaintenanceWindow -Name $mwName -Timezone UTC -StartDate $startDate -EndDate $endDate -UptimeID @($SCTestID) -RepeatInterval 1m
        $SCMWTest = Get-StatusCakeHelperMaintenanceWindow -ID $SCMWTestID

        $SCMWTest.name | Should -Be "Pester Test Maintenance Window - $($startDate.ToUniversalTime().ToString())"
        $SCMWTest.timezone | Should -Be "UTC"
        $mwStartTimeSpan = New-TimeSpan $startDate $SCMWTest.start_at
        $mwEndTimeSpan = New-TimeSpan $endDate $SCMWTest.end_at
        $mwStartTimeSpan.Seconds | Should -BeLessOrEqual 2 -Because "Start time can differ by up a second from when command is sent"
        $mwEndTimeSpan.Seconds | Should -BeLessOrEqual 2 -Because "End time can differ by up a second from when command is sent"
        $SCMWTest.tests | Should -Contain $SCTestID
    }

    It "Update-StatusCakeHelperMaintenanceWindow updates the maintenance window"{
        Update-StatusCakeHelperMaintenanceWindow -ID $SCMWTestID -RepeatInterval 2w
        $result = Get-StatusCakeHelperMaintenanceWindow -ID $SCMWTestID
        $result.repeat_interval | Should -Be 2w
    }

    It "Clear-StatusCakeHelperMaintenanceWindow clears a test associated with a maintenance window" -skip{
        Clear-StatusCakeHelperMaintenanceWindow -ID $SCMWTestID -UptimeID
        $results = Get-StatusCakeHelperMaintenanceWindow -ID $SCMWTestID
        $results.tests | Should -BeFalse
    }

    It "Get-StatusCakeHelperMaintenanceWindow retrieves a maintenance window by name"{
        $result = Get-StatusCakeHelperMaintenanceWindow -Name $mwName
        $result.name  | Should -Be $mwName
        $result.id | Should -BeGreaterThan 0
    }

    It "Get-StatusCakeHelperMaintenanceWindow retrieves all maintenance windows"{
        $results = Get-StatusCakeHelperMaintenanceWindow
        $results.count | Should -BeGreaterThan 1
    }

    It "Remove-StatusCakeHelperMaintenanceWindow removes a maintenance window"{
        Remove-StatusCakeHelperUptimeTest -Name "Pester Test SC Test for Maintenance Window"
        Remove-StatusCakeHelperMaintenanceWindow -ID $SCMWTestID
        $results = Get-StatusCakeHelperMaintenanceWindow
        $results.id | Should -Not -Contain $SCMWTestID
    }

}
