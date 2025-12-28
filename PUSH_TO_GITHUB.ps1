# GitHub Push Script with Token Authentication
# This script pushes files to GitHub using HTTPS with token

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Credit Card Fraud Detection - GitHub Push" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

$repoPath = "C:\Users\mekal\OneDrive\Desktop\credit card"
cd $repoPath

# Check git is initialized
if (!(Test-Path ".git")) {
    Write-Host "Error: Git repository not found!" -ForegroundColor Red
    exit 1
}

Write-Host "✓ Git repository found" -ForegroundColor Green
Write-Host "✓ Remote: $(git config --get remote.origin.url)" -ForegroundColor Green
Write-Host "✓ Branch: $(git rev-parse --abbrev-ref HEAD)" -ForegroundColor Green
Write-Host "`nPreparing to push files..." -ForegroundColor Yellow

# Check for uncommitted changes
$status = git status --porcelain
if ($status) {
    Write-Host "`nFound uncommitted changes. Adding and committing..." -ForegroundColor Yellow
    git add .
    git commit -m "Update: Additional files and configurations"
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "IMPORTANT: GitHub Authentication Required" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "`nYou need a Personal Access Token to push." -ForegroundColor White
Write-Host "Follow these steps:" -ForegroundColor Cyan
Write-Host "`n1. Go to: https://github.com/settings/tokens" -ForegroundColor White
Write-Host "2. Click: Generate new token (classic)" -ForegroundColor White
Write-Host "3. Give it a name: 'credit-card-fraud-detection'" -ForegroundColor White
Write-Host "4. Check: repo and workflow" -ForegroundColor White
Write-Host "5. Click: Generate token" -ForegroundColor White
Write-Host "6. Copy the token" -ForegroundColor White
Write-Host "`nWhen prompted below:" -ForegroundColor Yellow
Write-Host "  - Username: Rishi2818" -ForegroundColor Cyan
Write-Host "  - Password: Paste your token" -ForegroundColor Cyan
Write-Host "`n========================================`n" -ForegroundColor Cyan

# Attempt push
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n========================================" -ForegroundColor Green
    Write-Host "✓ SUCCESS! Files pushed to GitHub!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "`nRepository URL:" -ForegroundColor Cyan
    Write-Host "https://github.com/Rishi2818/credit-card-fraud-detection" -ForegroundColor White
    Write-Host "`nYour files are now live on GitHub! 🚀" -ForegroundColor Green
} else {
    Write-Host "`n========================================" -ForegroundColor Red
    Write-Host "Error: Push failed!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "`nMake sure you:" -ForegroundColor Yellow
    Write-Host "1. Have a valid GitHub Personal Access Token" -ForegroundColor White
    Write-Host "2. Have internet connection" -ForegroundColor White
    Write-Host "3. Entered credentials correctly" -ForegroundColor White
}

Write-Host "`nPress any key to exit..." -ForegroundColor Yellow
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
