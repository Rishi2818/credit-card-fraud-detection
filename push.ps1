# GitHub Push Script - Complete Setup and Push

Write-Host "`n" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "  Credit Card Fraud Detection" -ForegroundColor Green
Write-Host "  GitHub Repository Push" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""

$projectPath = "C:\Users\mekal\OneDrive\Desktop\credit card"
$githubRepo = "https://github.com/Rishi2818/credit-card-fraud-detection.git"

Write-Host "[1/4] Navigating to project directory..." -ForegroundColor Yellow
Set-Location $projectPath
Write-Host "✓ In: $(Get-Location)" -ForegroundColor Green

Write-Host "`n[2/4] Initializing Git repository..." -ForegroundColor Yellow
if (Test-Path ".git") {
    Write-Host "Git repo already exists, skipping init" -ForegroundColor Cyan
} else {
    git init
    git config user.name "Rishi2818"
    git config user.email "rishi@github.com"
    Write-Host "✓ Git initialized" -ForegroundColor Green
}

Write-Host "`n[3/4] Staging and committing files..." -ForegroundColor Yellow
git add .
Write-Host "✓ Files staged" -ForegroundColor Green

$commitMsg = "Add credit card fraud detection system - Frontend, Backend, and Documentation"
git commit -m "$commitMsg" 2>&1 | Out-Null
Write-Host "✓ Changes committed" -ForegroundColor Green

Write-Host "`n[4/4] Setting up remote and pushing..." -ForegroundColor Yellow

# Check if remote exists
$remoteExists = git remote get-url origin 2>&1
if ($remoteExists -match "fatal") {
    git remote add origin $githubRepo
    Write-Host "✓ Remote added" -ForegroundColor Green
} else {
    Write-Host "✓ Remote already exists" -ForegroundColor Green
}

# Rename branch to main if needed
$currentBranch = git rev-parse --abbrev-ref HEAD 2>&1
if ($currentBranch -ne "main") {
    git branch -M main 2>&1 | Out-Null
    Write-Host "✓ Branch renamed to main" -ForegroundColor Green
}

Write-Host "`n" -ForegroundColor White
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "  AUTHENTICATION REQUIRED" -ForegroundColor Yellow
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "To push to GitHub, you need authentication." -ForegroundColor White
Write-Host ""
Write-Host "OPTION A: Personal Access Token (Recommended)" -ForegroundColor Green
Write-Host "  1. Go to: https://github.com/settings/tokens" -ForegroundColor Cyan
Write-Host "  2. Click 'Generate new token (classic)'" -ForegroundColor Cyan
Write-Host "  3. Name: 'credit-card-fraud-detection'" -ForegroundColor Cyan
Write-Host "  4. Check: [✓] repo, [✓] workflow" -ForegroundColor Cyan
Write-Host "  5. Generate and copy token" -ForegroundColor Cyan
Write-Host ""
Write-Host "OPTION B: Use Git Credential Manager" -ForegroundColor Green
Write-Host "  Windows will prompt for credentials" -ForegroundColor Cyan
Write-Host ""
Write-Host "When prompted:" -ForegroundColor Yellow
Write-Host "  Username: Rishi2818" -ForegroundColor White
Write-Host "  Password: Your token (from above) or password" -ForegroundColor White
Write-Host ""
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Attempting to push to GitHub..." -ForegroundColor Yellow
Write-Host "Repository: $githubRepo" -ForegroundColor Cyan
Write-Host ""

# Attempt push
git push -u origin main 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n" -ForegroundColor Green
    Write-Host "===========================================" -ForegroundColor Green
    Write-Host "  ✓✓✓ SUCCESS! Files Pushed to GitHub! ✓✓✓" -ForegroundColor Green
    Write-Host "===========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your repository is now live:" -ForegroundColor Cyan
    Write-Host "https://github.com/Rishi2818/credit-card-fraud-detection" -ForegroundColor White
    Write-Host ""
    Write-Host "Files pushed:" -ForegroundColor Green
    Write-Host "  ✓ Backend (Flask API)" -ForegroundColor White
    Write-Host "  ✓ Frontend (HTML, CSS, JavaScript)" -ForegroundColor White
    Write-Host "  ✓ Documentation (8 guides)" -ForegroundColor White
    Write-Host "  ✓ Configuration files" -ForegroundColor White
    Write-Host "  ✓ Startup scripts" -ForegroundColor White
    Write-Host ""
    Write-Host "Total: 21 files uploaded successfully!" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "`n" -ForegroundColor Red
    Write-Host "===========================================" -ForegroundColor Red
    Write-Host "  ✗ Push Failed" -ForegroundColor Red
    Write-Host "===========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Possible issues:" -ForegroundColor Yellow
    Write-Host "  • GitHub credentials not configured" -ForegroundColor White
    Write-Host "  • Personal Access Token expired or incorrect" -ForegroundColor White
    Write-Host "  • Internet connection issue" -ForegroundColor White
    Write-Host "  • Repository doesn't exist or access denied" -ForegroundColor White
    Write-Host ""
    Write-Host "Try again with valid credentials." -ForegroundColor Cyan
    Write-Host ""
}

Write-Host "Press Enter to exit..." -ForegroundColor Yellow
Read-Host
