# This runs all PSScriptAnalyzer rules as Pester tests to enable visibility when publishing test results
# Vars
$ScriptAnalyzerSettingsPath = Join-Path -Path $env:BHProjectPath -ChildPath 'PSScriptAnalyzerSettings.psd1'
$ScriptAnalyzerInjectionHunterPath = "$((Get-Module -Name InjectionHunter -ListAvailable | Select-Object -First 1 -ExpandProperty Path) -replace 'psd1','psm1')"

Describe 'Testing against PSSA rules' {
    Context 'PSSA Standard Rules' {
        $analysis = Invoke-ScriptAnalyzer -Path $env:BHModulePath -Recurse -Settings $ScriptAnalyzerSettingsPath
        $scriptAnalyzerRules = Get-ScriptAnalyzerRule

        forEach ($rule in $scriptAnalyzerRules) {
            It "Should pass $rule" {
                If ($analysis.RuleName -contains $rule) {
                    $analysis | Where-Object RuleName -EQ $rule -OutVariable 'failures' | Out-Default
                    $failures.Count | Should Be 0
                }
            }
        }
    }
    Context 'PSSA Injection Hunter Rules'{
        $analysis = Invoke-ScriptAnalyzer -Path $env:BHModulePath -Recurse -Settings $ScriptAnalyzerSettingsPath -CustomRulePath $ScriptAnalyzerInjectionHunterPath -ExcludeRule PS*
        $injectionHunterFunctions = Get-ScriptAnalyzerRule -CustomRulePath $ScriptAnalyzerInjectionHunterPath
        #Get-ScriptAnalyzer on Injection Hunter module returns rule names matching function names and not rule names from DiagnosticRecord object
        #Generate rule names to check from the function names
        $injectionHunterRules = $injectionHunterFunctions | ForEach-Object {$_.RuleName -replace "Measure-","InjectionRisk."}

        forEach ($rule in $injectionHunterRules) {
            It "Should pass $rule" {
                If ($analysis.RuleName -contains $rule) {
                    $analysis | Where-Object RuleName -EQ $rule -OutVariable 'failures' | Out-Default
                    $failures.Count | Should Be 0
                }
            }
        }
    }
}
