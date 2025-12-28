@echo off
echo.
echo ========================================
echo Credit Card Fraud Detection System
echo ========================================
echo.
echo Starting Flask Server...
echo.
cd /d "C:\Users\mekal\OneDrive\Desktop\credit card"
call .venv\Scripts\activate.bat
python backend\app.py
pause
