@{
    # Defaults for all dependencies
    PSDependOptions  = @{
        Target     = 'CurrentUser'
        Parameters = @{
            # Use a local repository for offline support
            Repository         = 'PSGallery'
            SkipPublisherCheck = $true
        }
    }

    # Common modules
    BuildHelpers     = '2.0.11'
    InjectionHunter  = '1.0.0'
    Pester           = '4.6.0'
    PlatyPS          = '0.14.0'
    psake            = '4.7.4'
    PSDeploy         = '1.0.1'
    PSScriptAnalyzer = '1.18.3'
}
