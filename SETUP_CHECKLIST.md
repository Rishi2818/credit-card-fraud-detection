# ✅ Setup Checklist & Verification Guide

## Pre-Setup Requirements

- [ ] Python 3.8+ installed
- [ ] pip (Python package manager) available
- [ ] Google Chrome, Firefox, Safari, or Edge browser
- [ ] Text editor (VS Code, Notepad++, etc.)
- [ ] Internet connection (for first run)

## Step 1: Verify Project Files

Run this command in PowerShell to verify all files:

```powershell
# Check main directory
Get-ChildItem "C:\Users\mekal\OneDrive\Desktop\credit card" | Select-Object Name

# Check backend
Get-ChildItem "C:\Users\mekal\OneDrive\Desktop\credit card\backend" | Select-Object Name

# Check frontend/templates
Get-ChildItem "C:\Users\mekal\OneDrive\Desktop\credit card\frontend\templates" | Select-Object Name

# Check frontend/static
Get-ChildItem "C:\Users\mekal\OneDrive\Desktop\credit card\frontend\static" | Select-Object Name
```

**Expected Files:**
```
✓ backend/app.py
✓ frontend/templates/index.html
✓ frontend/static/style.css
✓ frontend/static/script.js
✓ requirements.txt
✓ README.md
✓ QUICK_START.md
✓ COLAB_MODEL_EXPORT.py
✓ PROJECT_STRUCTURE.md
```

## Step 2: Install Python Dependencies

```powershell
# Navigate to project directory
cd "C:\Users\mekal\OneDrive\Desktop\credit card"

# Install all required packages
pip install -r requirements.txt
```

**Expected Output:**
```
Successfully installed Flask-2.3.3 Flask-CORS-4.0.0 scikit-learn-1.3.0 ...
```

- [ ] All packages installed successfully
- [ ] No error messages
- [ ] Took ~1-3 minutes

## Step 3: Prepare Your Trained Model (Optional but Recommended)

### Option A: Using Your Colab Model

1. [ ] Go to your Google Colab notebook
2. [ ] Run code from `COLAB_MODEL_EXPORT.py`:
   ```python
   import joblib
   from google.colab import files
   
   joblib.dump(classifier, 'fraud_model.pkl')
   files.download('fraud_model.pkl')
   ```
3. [ ] Download `fraud_model.pkl` file
4. [ ] Place in `backend/` folder:
   ```
   C:\Users\mekal\OneDrive\Desktop\credit card\backend\fraud_model.pkl
   ```
5. [ ] Verify file exists:
   ```powershell
   Test-Path "C:\Users\mekal\OneDrive\Desktop\credit card\backend\fraud_model.pkl"
   ```
   Should return: `True`

- [ ] Model file downloaded
- [ ] Model file placed in correct location
- [ ] File exists and is readable

### Option B: Using Demo Model

- [ ] Skip Step 3A
- [ ] App will create dummy model for testing
- [ ] Replace with real model later

## Step 4: Start Flask Server

```powershell
# Navigate to backend directory
cd "C:\Users\mekal\OneDrive\Desktop\credit card\backend"

# Start Flask server
python app.py
```

**Expected Output:**
```
 * Serving Flask app 'app'
 * Debug mode: on
 * Running on http://127.0.0.1:5000
```

- [ ] Flask started successfully
- [ ] No error messages
- [ ] Server running on port 5000
- [ ] Keep this terminal window open

## Step 5: Test Frontend

In a NEW terminal/browser:

```powershell
# Option 1: Open in default browser
Start-Process "http://localhost:5000"

# Option 2: Manual browser open
# Open browser and go to: http://localhost:5000
```

**Expected Result:**
```
✓ Website loads
✓ Page title: "Credit Card Fraud Detection System"
✓ Header visible with title and subtitle
✓ Input form shows 30 feature fields (V0-V29)
✓ Three mode buttons: Manual Entry, Bulk Upload, Random Sample
✓ Statistics section at bottom
```

- [ ] Website loads without errors
- [ ] All elements visible
- [ ] No JavaScript errors (check F12 console)
- [ ] Page is responsive

## Step 6: Test Prediction (Manual Mode)

1. [ ] Website is open and ready
2. [ ] You're in "Manual Entry" mode (default)
3. [ ] Run this test:
   ```
   - Leave all fields as 0 (or enter any numbers)
   - Click "Analyze Transaction" button
   - Wait for result to appear
   ```
4. [ ] Expected result: See a card with LEGITIMATE or FRAUDULENT prediction
5. [ ] Check statistics: Total count should be 1

**Verification Checklist:**
- [ ] Prediction appears within 2 seconds
- [ ] Result card shows prediction label
- [ ] Probability bars visible
- [ ] Statistics updated
- [ ] No errors in console (F12)

## Step 7: Test CSV Upload Mode

1. [ ] Create sample file `test.csv`:
   ```
   0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
   0.1,-0.5,0.2,0.05,0.1,-0.2,0.3,0,0.1,-0.1,0.2,-0.3,0.1,0,-0.2,0.4,0.1,-0.1,0.2,-0.2,0,0.1,-0.3,0.2,0.1,-0.2,0.3,0,0.1,-0.1
   -0.2,0.4,-0.1,0.3,-0.2,0.1,-0.4,0.2,0,-0.3,0.1,0.2,-0.1,0.4,0,-0.2,0.3,-0.1,0.2,0.1,-0.3,0,0.2,-0.2,0.1,0.3,-0.2,0,-0.1,0.2
   ```
2. [ ] Click "Bulk Upload" tab
3. [ ] Drag-drop the CSV file (or click to select)
4. [ ] Click "Upload & Analyze"
5. [ ] Wait for results

**Verification:**
- [ ] All 3 transactions analyzed
- [ ] Statistics show: Total=3
- [ ] Modal appears with bulk results
- [ ] No errors

## Step 8: Test Random Sample Mode

1. [ ] Click "Random Sample" tab
2. [ ] Click "Generate Random Features"
3. [ ] Random values populate the form fields
4. [ ] Prediction appears
5. [ ] Statistics increment

**Verification:**
- [ ] Random features generated
- [ ] All 30 fields filled
- [ ] Prediction appears
- [ ] Statistics update correctly

## Step 9: Verify Browser Console (F12)

Press `F12` to open Developer Tools:

**Console Tab:**
- [ ] No red error messages
- [ ] No "Failed to fetch" errors
- [ ] Model info logged successfully

**Network Tab:**
- [ ] All requests to `/api/predict` return 200 OK
- [ ] Response JSON contains expected fields

**Application Tab:**
- [ ] Check localStorage (if being used)
- [ ] Check cookies (should be minimal)

## Step 10: Final Verification

### Backend Checklist
```powershell
# Test API endpoints directly

# Test 1: Model Info
Invoke-WebRequest -Uri "http://localhost:5000/api/model-info" | Select-Object Content

# Test 2: Sample Features
Invoke-WebRequest -Uri "http://localhost:5000/api/sample-features" | Select-Object Content

# Test 3: Prediction
$body = @{
    features = @(0, -0.5, 0.2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
} | ConvertTo-Json

Invoke-WebRequest -Uri "http://localhost:5000/api/predict" `
    -Method POST `
    -ContentType "application/json" `
    -Body $body | Select-Object Content
```

- [ ] `/api/model-info` returns valid JSON
- [ ] `/api/sample-features` returns feature list
- [ ] `/api/predict` returns prediction with probability

### Frontend Checklist
- [ ] Page loads in <2 seconds
- [ ] All buttons clickable
- [ ] Form submits without page reload
- [ ] Results appear dynamically
- [ ] Mobile view works (resize browser)

## Troubleshooting Checklist

### If Flask doesn't start:
```powershell
# Check if port 5000 is in use
netstat -ano | findstr :5000

# If in use, kill the process
taskkill /PID <PID> /F

# Or change port in app.py and restart
```
- [ ] Port available or changed
- [ ] Flask starts successfully

### If website doesn't load:
```powershell
# Check if server is running
# Verify URL: http://localhost:5000 (not https)
# Check firewall settings
# Try: http://127.0.0.1:5000
```
- [ ] Server running
- [ ] Correct URL used
- [ ] Browser cache cleared (Ctrl+Shift+Delete)

### If predictions fail:
```powershell
# Check backend console for errors
# Verify feature count = 30
# Check model file exists (if using custom model)
# Check Flask error logs in terminal
```
- [ ] Exactly 30 features sent
- [ ] All features are numbers
- [ ] Model file accessible

### If CSV upload fails:
```
- Ensure CSV is comma-separated
- Each row must have exactly 30 values
- All values must be numbers
- No header row (or has 30 columns)
```
- [ ] CSV format correct
- [ ] All rows have 30 columns

## Documentation Files Reference

| File | Use Case |
|------|----------|
| `README.md` | Full API & feature documentation |
| `QUICK_START.md` | Fast setup (5 steps) |
| `PROJECT_STRUCTURE.md` | File descriptions & API endpoints |
| `COLAB_MODEL_EXPORT.py` | Export code for Colab |
| This file | Comprehensive verification |

## Success Checklist Summary

**All of these should be checked:**
- [ ] All files created in correct locations
- [ ] Dependencies installed without errors
- [ ] Model file placed in backend/ (optional)
- [ ] Flask server starts and runs
- [ ] Frontend loads in browser
- [ ] Manual prediction works
- [ ] CSV upload works
- [ ] Random sample works
- [ ] Statistics update correctly
- [ ] No console errors
- [ ] API endpoints respond correctly
- [ ] Mobile responsive design works

## You're Ready To Go! 🎉

If all checkboxes are checked, your application is:
- ✅ Properly installed
- ✅ Fully functional
- ✅ Ready for production use
- ✅ Ready for sharing with others

## Next Steps

1. **Replace demo model** with your Colab trained model
2. **Test with real data** from your fraud detection dataset
3. **Monitor predictions** and validate accuracy
4. **Adjust thresholds** if needed in frontend
5. **Share with team** or deploy to server

## Support Commands

```powershell
# Stop Flask server: Ctrl+C in terminal
# Restart Flask: Run python app.py again
# Clear browser cache: Ctrl+Shift+Delete
# Check Python version: python --version
# Check pip packages: pip list
# Reinstall dependencies: pip install --upgrade -r requirements.txt
```

---

**Last Updated**: December 2025
**Estimated Setup Time**: 5-10 minutes
**Questions**: Check README.md or QUICK_START.md
