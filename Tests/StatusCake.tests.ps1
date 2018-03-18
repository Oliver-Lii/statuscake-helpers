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
    Set-StatusCakeHelperAPIAuth -Credentials $scCredentials
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
        $scTest.Success| Should Be "True"
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
   
} 

Describe "StatusCake Contact Groups" {
    
    It "Get-StatusCakeHelperAllContactGroups retrieves all contact groups"{
        Get-StatusCakeHelperAllContactGroups | Should Be $true
    }

    It "New-StatusCakeHelperContactGroup creates a contact group"{
        $script:SCContactGroup = New-StatusCakeHelperContactGroup -GroupName "Pester Test Contact Group" -Mobile "+12345678910"
        $SCContactGroup.Success| Should Be "True"
    }

    It "Set-StatusCakeHelperContactGroup adds a email address"{
        $result = Set-StatusCakeHelperContactGroup -ContactID $SCContactGroup.InsertID -Email @("pestertest@example.com")
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
   
} 