$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleRoot = "$here\..\statuscake-helpers"
$DefaultsFile = "$here\statuscake-helpers.Pester.Defaults.json"

if(Test-Path $DefaultsFile)
{
    $defaults=@{}
    (Get-Content $DefaultsFile | Out-String | ConvertFrom-Json).psobject.properties | ForEach-Object{$defaults."$($_.Name)" = $_.Value}

    # Prompt for credentials
    $StatusCakeAuth = @{
        Username = if($defaults.Username){$defaults.Username}else{Read-Host "Username"}  
        ApiKey = if($defaults.ApiKey){$defaults.Apikey}else{Read-Host "ApiKey"}
    }
    $scAPIKey = ConvertTo-SecureString $StatusCakeAuth.ApiKey -AsPlainText -Force
    $scCredentials = New-Object System.Management.Automation.PSCredential ($StatusCakeAuth.Username, $scAPIKey)
    Set-StatusCakeHelperAPIAuth -Credentials $scCredentials | Out-Null
}
else
{
    Write-Error "$DefaultsFile does not exist. Created example file. Please populate with your values";

    # Write example file
    @{
        Username = 'UsernameOfPrimaryStatusCakeAccount';
        ApiKey = "APIKeyOfPrimaryStatusCakeAccount";

    } | ConvertTo-Json | Set-Content $DefaultsFile
    return;
}

Describe "StatusCake Tests" {

    It "Get-StatusCakeHelperAllTests retrieves all tests"{
        Get-StatusCakeHelperAllTests | Should Be $true
    }

    It "New-StatusCakeHelperTest creates a test"{
        $script:SCTest = New-StatusCakeHelperTest -TestName "Pester Test StatusCake Test" -TestURL "https://www.example.com" -checkRate 300 -testType HTTP
        $scTest.Success | Should Be "True"
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
    
    It "Get-StatusCakeHelperAllContactGroups retrieves all contact groups"{
        Get-StatusCakeHelperAllContactGroups | Should Be $true
    }

    It "New-StatusCakeHelperContactGroup creates a contact group"{
        $script:SCContactGroup = New-StatusCakeHelperContactGroup -GroupName "Pester Test Contact Group" -Mobile "+12345678910"
        $SCContactGroup.Success | Should Be "True"
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

    It "Remove-StatusCakeHelperContactGroup removes a test"{
        $result = Remove-StatusCakeHelperContactGroup -ContactID $SCContactGroup.InsertID -PassThru
        $result.Success | Should Be "True"
    }    

    It "Remove-StatusCakeHelperContactGroup removes a test by name"{
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
        Get-StatusCakeHelperAllPageSpeedTests | Should Be $true
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

    It "Remove-StatusCakeHelperPageSpeedTest removes a test"{
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
        Get-StatusCakeHelperAllSSLTests | Should Be $true
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

    It "Remove-StatusCakeHelperSSLTest removes a SSL test"{
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
        Get-StatusCakeHelperAllMaintenanceWindows | Should Be $true
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
        $result | Should Be $true
    }   

    It "Remove-StatusCakeHelperMaintenanceWindow removes a maintenance window"{
        Remove-StatusCakeHelperTest -TestName "Pester Test SC Test for MW"
        $result = Remove-StatusCakeHelperMaintenanceWindow -id $SCMWTest.data.new_id -Series $true -PassThru
        $result.Success | Should Be "True"
    }    
   
}
