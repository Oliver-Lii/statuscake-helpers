Param(
    [ValidateNotNullOrEmpty()]
    [string]$StatusCakeUserName = $env:StatusCake_Username,
    [ValidateNotNullOrEmpty()]
    [string]$StatusCakeAPIKey = $env:StatusCake_API_Key
)

Describe 'StatusCake Module Tests' {

    It "Module statuscake-helpers imports without throwing an exception"{
        Remove-Module $env:BHPROJECTNAME -ErrorAction SilentlyContinue
        {Import-Module $env:BHPSModuleManifest -Force } | Should -Not -Throw
    }

}

if(! (Test-StatusCakeHelperAPIAuthSet))
{
    $scUser = $StatusCakeUserName
    $scAPIKey = ConvertTo-SecureString -String $StatusCakeAPIKey -AsPlainText -Force
    $scCredentials = New-Object System.Management.Automation.PSCredential ($scUser, $scAPIKey)
    Set-StatusCakeHelperAPIAuth -Credential $scCredentials -Session
}

Describe "StatusCake Locations" {

    It "Get-StatusCakeHelperLocation retrieves page speed locations"{
        $SCPageSpeedLocations = Get-StatusCakeHelperLocation -Type PageSpeed-Locations
        $SCPageSpeedLocations.count | Should -BeGreaterThan 0
    }

    It "Get-StatusCakeHelperLocation retrieves uptime locations"{
        $SCUptimeLocations = Get-StatusCakeHelperLocation -Type Uptime-Locations
        $SCUptimeLocations.count | Should -BeGreaterThan 0
    }

    It "Get-StatusCakeHelperLocation retrieves an uptime location by region code"{
        $SCUptimeLocations = Get-StatusCakeHelperLocation -Type Uptime-Locations -RegionCode "london"
        $regionCode = $SCUptimeLocations.region_code | Sort-Object -Unique
        $regionCode | Should -Contain "london"
        $regionCode.count | Should -BeExactly 1
    }
}