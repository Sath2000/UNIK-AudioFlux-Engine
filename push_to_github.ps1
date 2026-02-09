<#
push_to_github.ps1

Usage: run this script from PowerShell. It will:
- prompt you for a GitHub Personal Access Token (PAT)
- create the repository `UNIK-AudioFlux-Engine` under your account via the GitHub API
- initialize git if needed, add a remote, commit any files, set branch to `main`, and push

Notes:
- The script will not store the PAT. When `git push` prompts for credentials, use your GitHub username and the PAT as the password.
- Ensure you run this from the project folder or move the script into the project and run it there.
#>

Set-StrictMode -Version Latest

# Change to the script directory so it works when invoked from anywhere
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $scriptDir

$repoName = 'UNIK-AudioFlux-Engine'
$owner = 'sath2000'

Write-Host "Working directory: $PWD"

# Prompt for PAT securely
$token = Read-Host -AsSecureString "Paste GitHub Personal Access Token (will not be stored on disk)"
$plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($token))

Write-Host "Creating repository $owner/$repoName via GitHub API..."
$body = @{ name = $repoName; private = $false } | ConvertTo-Json
try {
    Invoke-RestMethod -Headers @{ Authorization = "token $plain"; "User-Agent" = "PSScript"; "Accept" = "application/vnd.github.v3+json" } -Method POST -Uri "https://api.github.com/user/repos" -Body $body -ErrorAction Stop
    Write-Host "Repository created (or already exists)."
} catch {
    if ($_.Exception.Response -and ($_.Exception.Response.StatusCode.Value__ -eq 422)) {
        Write-Host "Repository may already exist. Continuing..."
    } else {
        Write-Error "Failed to create repository: $_"
        exit 1
    }
}

# Initialize git repository if needed
if (-not (Test-Path .git)) {
    Write-Host "Initializing git repository..."
    git init
}

Write-Host "Adding files and committing (if there are changes)..."
git add .
try { git commit -m "Initial commit" -q } catch { Write-Host "No changes to commit or commit failed (ok to continue)." }

Write-Host "Setting branch to main..."
git branch -M main

Write-Host "Adding remote origin..."
try { git remote remove origin -q } catch {}
git remote add origin https://github.com/$owner/$repoName.git

Write-Host "About to push to origin/main. When prompted, enter username '$owner' and use your PAT as the password."
git push -u origin main

Write-Host "Done. If the push failed due to authentication, ensure your PAT has 'repo' scope and try again."

# Clean up sensitive string from memory
[Runtime.InteropServices.Marshal]::ZeroFreeBSTR([Runtime.InteropServices.Marshal]::SecureStringToBSTR($token)) | Out-Null
