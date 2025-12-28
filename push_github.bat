@echo off
REM GitHub Push Script for Credit Card Fraud Detection

echo.
echo ==========================================
echo Credit Card Fraud Detection - GitHub Push
echo ==========================================
echo.

setlocal enabledelayedexpansion

set "projectPath=C:\Users\mekal\OneDrive\Desktop\credit card"
set "githubRepo=https://github.com/Rishi2818/credit-card-fraud-detection.git"

echo [1/4] Navigating to project...
cd /d "%projectPath%"
if errorlevel 1 (
    echo Error: Could not change to project directory
    pause
    exit /b 1
)
echo OK - In: %CD%
echo.

echo [2/4] Initializing Git...
git init
git config user.name "Rishi2818"
git config user.email "rishi@github.com"
echo OK - Git configured
echo.

echo [3/4] Staging and committing files...
git add .
if errorlevel 1 (
    echo Error: Could not stage files
    pause
    exit /b 1
)
echo OK - Files staged
echo.

git commit -m "Add credit card fraud detection system - Frontend, Backend, and Documentation"
if errorlevel 1 (
    echo Error: Could not commit files
    pause
    exit /b 1
)
echo OK - Committed
echo.

echo [4/4] Setting remote and pushing...
git remote add origin %githubRepo% 2>nul
git branch -M main 2>nul

echo.
echo ==========================================
echo GITHUB AUTHENTICATION REQUIRED
echo ==========================================
echo.
echo You need to authenticate with GitHub.
echo.
echo Option A: Personal Access Token (Recommended)
echo   1. Go to: https://github.com/settings/tokens
echo   2. Click "Generate new token (classic)"
echo   3. Name: credit-card-fraud-detection
echo   4. Check: repo and workflow
echo   5. Generate and COPY the token
echo.
echo Option B: GitHub Password
echo   Use your GitHub password (not recommended)
echo.
echo When prompted:
echo   Username: Rishi2818
echo   Password: Paste your token above
echo.
echo ==========================================
echo.

echo Pushing files to GitHub...
echo.

git push -u origin main

if errorlevel 1 (
    echo.
    echo ==========================================
    echo ERROR: Push failed
    echo ==========================================
    echo.
    echo Make sure you:
    echo   1. Have a valid GitHub Personal Access Token
    echo   2. Have internet connection
    echo   3. Entered credentials correctly
    echo.
) else (
    echo.
    echo ==========================================
    echo SUCCESS! Files pushed to GitHub!
    echo ==========================================
    echo.
    echo Your repository:
    echo https://github.com/Rishi2818/credit-card-fraud-detection
    echo.
    echo Files uploaded:
    echo   - Backend (Flask API)
    echo   - Frontend (HTML, CSS, JavaScript)
    echo   - Documentation
    echo   - Configuration files
    echo   - Total: 21 files
    echo.
)

echo Press any key to exit...
pause >nul
