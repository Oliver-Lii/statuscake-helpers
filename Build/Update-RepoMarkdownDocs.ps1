[CmdletBinding()]
param (
    [string]$GitEmail = $env:BUILD_REQUESTEDFOREMAIL,
    [string]$GitUserName = $env:BUILD_QUEUEDBY,
    [string]$DocBranchName = "BuildService/UpdateDocumentation",
    [string]$ModuleName = $env:BUILD_REPOSITORY_NAME,
    [string]$ArtifactName = "PSModule"
)

git config --global user.email $GitEmail
git config --global user.name $GitUserName

# Get nested paths of scripts from repository
$scriptFiles = Get-ChildItem -Path "$env:SYSTEM_DEFAULTWORKINGDIRECTORY\$ModuleName\Public" -Recurse -Filter "*.ps1"

# Get all the Markdown documentation files from the latest artifact
$mdFiles = Get-ChildItem "$env:BUILD_STAGINGDIRECTORY\$ArtifactName\Documentation" -Filter "*.md"

foreach($item in $scriptFiles)
{
    # Identify documentation folder
    $targetDirectory = $item.DirectoryName -replace "$ModuleName\\Public","Documentation"
    # Setup target file name
    $targetFileName = $item.name -replace "ps1","md"

    # If the destination folder does not exist create it
    if(! (Test-Path $targetDirectory))
    {
        $targetName = $targetDirectory | Split-Path -Leaf
        $targetPath = $targetDirectory | Split-Path -Parent
        New-Item -Path $targetPath -Name $targetName -ItemType Directory | Out-Null
    }
    # Get the matching markdown file name
    $markDownFile = $mdFiles | Where-Object{$_.name -eq $targetFileName}

    if($markDownFile)# Create destination path string
    {
        $destination = Join-Path -Path $targetDirectory -ChildPath $targetFileName
        Move-Item -Path $markDownFile.FullName -Destination $destination -Force
    }
}

git checkout -b "$DocBranchName"
git status
Write-Host "GIT ADD"
git add .
git commit -am "Publish Markdown Documentation [skip ci]"
git checkout master
Write-Host "GIT STATUS"
git status
Write-Host "GIT MERGE"
git merge "$DocBranchName" -m "Merge to master [skip ci]"
Write-Host "GIT STATUS"
git status
Write-Host "GIT PUSH"
git push origin
Write-Host "GIT STATUS"
git status
