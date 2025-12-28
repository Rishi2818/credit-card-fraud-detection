# Credit Card Fraud Detection System - Startup Script
# Run this to start the application

Write-Host "`n" -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "Credit Card Fraud Detection System" -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "`nStarting Flask Server...`n" -ForegroundColor Yellow

# Activate virtual environment
cd "C:\Users\mekal\OneDrive\Desktop\credit card"
& ".\.venv\Scripts\Activate.ps1"

# Start Flask
Write-Host "`nLaunching application..." -ForegroundColor Green
python backend\app.py

Write-Host "`nServer stopped." -ForegroundColor Yellow
