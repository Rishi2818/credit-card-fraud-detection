# 🚀 QUICK START GUIDE

## Step 1: Export Your Model from Google Colab

### In Google Colab:
```python
# Add this to the end of your notebook

import joblib
from google.colab import files

# After your classifier is trained, save it:
joblib.dump(classifier, 'fraud_model.pkl')

# Download the file
files.download('fraud_model.pkl')
```

## Step 2: Place Model File in Backend

1. Download `fraud_model.pkl` from Colab
2. Move it to: `backend/fraud_model.pkl`

## Step 3: Install Dependencies

Open PowerShell/Command Prompt and run:

```bash
cd c:\Users\mekal\OneDrive\Desktop\credit card
pip install -r requirements.txt
```

## Step 4: Start the Flask Server

```bash
cd backend
python app.py
```

You should see:
```
 * Running on http://127.0.0.1:5000
 * Debug mode: on
```

## Step 5: Open the Frontend

1. Open your browser
2. Go to: `http://localhost:5000`
3. Start analyzing transactions!

---

## 📝 Testing Without Your Model (Demo Mode)

If you don't have your trained model yet:

1. Skip Step 2 (no need to place model file)
2. Run the Flask app directly
3. It will create a dummy model for testing
4. Once you have your trained model, replace it

---

## 🎯 Using the Application

### Method 1: Manual Entry
- Type feature values in the form (V0-V29)
- Click "Analyze Transaction"
- See fraud probability

### Method 2: Bulk CSV Upload
- Prepare CSV with 30 features per row
- Drag and drop file
- View bulk results

### Method 3: Random Testing
- Click "Generate Random Features"
- Instantly see prediction
- Good for testing functionality

---

## ❌ Troubleshooting

### "ModuleNotFoundError: No module named 'flask'"
```bash
pip install Flask Flask-CORS
```

### "Address already in use" (Port 5000)
Change port in `backend/app.py`:
```python
app.run(debug=True, port=5001)  # Change 5000 to 5001
```

### Cannot find localhost:5000
- Make sure Flask server is running
- Check no firewall is blocking port 5000
- Try http://127.0.0.1:5000 instead

### Features mismatch error
- Your CSV must have exactly 30 columns
- All values must be numbers (int or float)
- Example valid CSV line: `0.1,-0.5,0.2,0.05,...,0.3`

---

## 📊 Sample CSV Format

Create `sample.csv`:
```
0.1,-0.5,0.2,0.05,0.1,-0.2,0.3,0.0,0.1,-0.1,0.2,-0.3,0.1,0.0,-0.2,0.4,0.1,-0.1,0.2,-0.2,0.0,0.1,-0.3,0.2,0.1,-0.2,0.3,0.0,0.1,-0.1
-0.2,0.4,-0.1,0.3,-0.2,0.1,-0.4,0.2,0.0,-0.3,0.1,0.2,-0.1,0.4,0.0,-0.2,0.3,-0.1,0.2,0.1,-0.3,0.0,0.2,-0.2,0.1,0.3,-0.2,0.0,-0.1,0.2
```

---

## 🔄 Full Workflow Example

```bash
# 1. Open PowerShell/CMD
cd c:\Users\mekal\OneDrive\Desktop\credit card

# 2. Install dependencies
pip install -r requirements.txt

# 3. Start Flask server
cd backend
python app.py

# 4. Open browser
# Visit http://localhost:5000

# 5. Test with sample data
# - Use manual entry mode
# - Enter any numbers in feature fields
# - Click "Analyze Transaction"
# - See prediction result!
```

---

## 💡 Key Files

| File | Purpose |
|------|---------|
| `backend/app.py` | Flask API server |
| `frontend/templates/index.html` | Web interface |
| `frontend/static/style.css` | Styling & layout |
| `frontend/static/script.js` | Frontend logic |
| `backend/fraud_model.pkl` | Your trained model (add this) |
| `requirements.txt` | Python dependencies |

---

## 🎓 Next Steps

1. ✅ Export model from Colab
2. ✅ Place in backend/ folder
3. ✅ Install dependencies
4. ✅ Run Flask server
5. ✅ Open frontend
6. ✅ Test with your data
7. ✅ Share the app URL!

---

## 📞 Common Questions

**Q: Can I run this on a different port?**
A: Yes, change `port=5000` in `backend/app.py`

**Q: Can I use my model from Colab directly?**
A: Yes, download it and save as `fraud_model.pkl` in backend/

**Q: Does it work on mobile?**
A: Yes, the app is fully responsive!

**Q: Can I share this with others?**
A: Yes, they need Python and dependencies installed, then run the Flask server

---

## 🎉 You're All Set!

Your Credit Card Fraud Detection System is ready to use!
