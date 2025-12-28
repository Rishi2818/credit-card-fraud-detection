# 🚀 HOW TO RUN THE APPLICATION

## Quick Start - 3 Options

### Option 1: Automatic (Recommended) ⭐
**Double-click this file:**
```
START.bat
```
✅ Automatically starts server
✅ Automatically opens browser
✅ Ready to use instantly

### Option 2: Manual Batch Script
**Double-click this file:**
```
run_server.bat
```
Then manually open:
```
http://localhost:5000
```

### Option 3: PowerShell Script
**Open PowerShell and run:**
```powershell
cd "C:\Users\mekal\OneDrive\Desktop\credit card"
powershell -ExecutionPolicy Bypass -File RUN_APP.ps1
```
Then open:
```
http://localhost:5000
```

### Option 4: Command Line
**Open Command Prompt or PowerShell:**
```bash
cd "C:\Users\mekal\OneDrive\Desktop\credit card"
python backend\app.py
```
Then open browser to:
```
http://localhost:5000
```

---

## 🎯 What Happens When You Run

1. ✅ Virtual environment activates
2. ✅ Flask server starts on port 5000
3. ✅ Browser opens automatically (Option 1 only)
4. ✅ You see the fraud detection interface
5. ✅ Start making predictions!

---

## 📍 Access URLs

- **Local**: `http://localhost:5000`
- **Alternative**: `http://127.0.0.1:5000`

Both work the same way - just pick one!

---

## 🛑 How to Stop

**Press Ctrl+C** in the terminal/command prompt window where the server is running.

---

## 📊 Testing the Application

Once the server is running and browser opens:

1. **Manual Mode** (Default):
   - Type any numbers in the 30 feature fields
   - Click "Analyze Transaction"
   - See fraud prediction instantly!

2. **Random Sample Mode**:
   - Click "Random Sample" tab
   - Click "Generate Random Features"
   - See instant prediction

3. **CSV Upload Mode**:
   - Click "Bulk Upload" tab
   - Drag and drop a CSV file
   - Upload and see results

---

## ⚠️ Troubleshooting

**Server won't start?**
- Make sure you're in the right folder
- Virtual environment may need setup: `python -m venv .venv`
- Check Python is installed: `python --version`

**Browser won't open?**
- Manually go to `http://localhost:5000`
- Check if port 5000 is in use
- Try port 5001 instead (edit app.py line 90)

**Port 5000 already in use?**
Edit `backend/app.py` and change:
```python
app.run(debug=True, port=5000)  # Change 5000 to 5001
```

---

## 📝 Remember

✅ **Option 1 (START.bat)** is the easiest - just double-click!
✅ Server stays running - don't close the window
✅ Browser opens automatically 
✅ Ctrl+C to stop when done

---

**Everything is set up and ready to go!** 🎉
