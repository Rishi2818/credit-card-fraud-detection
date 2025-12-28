@echo off
REM Credit Card Fraud Detection - Auto Start with Browser
REM This script starts the server and opens the browser automatically

echo.
echo ========================================
echo Credit Card Fraud Detection System
echo ========================================
echo.

cd /d "C:\Users\mekal\OneDrive\Desktop\credit card"

REM Activate virtual environment
call .venv\Scripts\activate.bat

REM Give it a moment before opening browser
echo Starting server... please wait
timeout /t 2 /nobreak

REM Open browser (this runs in background while server continues)
start http://localhost:5000

REM Start Flask server
echo.
echo ✓ Browser opening at http://localhost:5000
echo ✓ Server starting on port 5000
echo.
echo Press CTRL+C to stop the server
echo.

python backend\app.py
