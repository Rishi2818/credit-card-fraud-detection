# Project Structure & File Guide

## 📁 Complete Directory Layout

```
c:\Users\mekal\OneDrive\Desktop\credit card\
├── backend/
│   ├── app.py                          # Flask API server (main backend)
│   └── fraud_model.pkl                 # [ADD] Your trained model from Colab
│
├── frontend/
│   ├── templates/
│   │   └── index.html                  # HTML web interface
│   └── static/
│       ├── style.css                   # CSS styling
│       └── script.js                   # JavaScript functionality
│
├── Copy_of_credit_card_fraud_detection.ipynb  # Your original Colab notebook
├── requirements.txt                    # Python package dependencies
├── README.md                           # Full documentation
├── QUICK_START.md                      # Quick setup guide
├── COLAB_MODEL_EXPORT.py              # Script to export model from Colab
└── PROJECT_STRUCTURE.md                # This file
```

## 📄 File Descriptions

### Backend Files

#### `backend/app.py` (Main API Server)
- **Purpose**: Flask REST API server
- **Key Functions**:
  - Load trained ML model
  - `/` - Serve main web page
  - `/api/predict` - Make fraud predictions
  - `/api/model-info` - Get model details
  - `/api/sample-features` - Get feature information
- **Default Port**: 5000
- **Start Command**: `python app.py`

#### `backend/fraud_model.pkl` (Trained Model) - YOU MUST ADD THIS
- **Purpose**: Your trained Random Forest model from Colab
- **How to Get**: 
  1. Train model in Colab
  2. Use joblib.dump(classifier, 'fraud_model.pkl')
  3. Download the file
  4. Place in backend/ folder

### Frontend Files

#### `frontend/templates/index.html` (Web Interface)
- **Purpose**: Main web page structure
- **Features**:
  - Header with branding
  - Input section for transactions
  - Result display area
  - Statistics dashboard
  - Modal for bulk results
  - Responsive layout
- **Import**: CSS and JavaScript files

#### `frontend/static/style.css` (Styling)
- **Purpose**: Complete visual styling
- **Includes**:
  - Color scheme (blue/green/red)
  - Responsive grid layouts
  - Animations and transitions
  - Mobile-first design
  - Form styling
  - Result card styling
- **Size**: ~700 lines of CSS

#### `frontend/static/script.js` (Frontend Logic)
- **Purpose**: All JavaScript functionality
- **Key Functions**:
  - `initializeFeatures()` - Create input fields
  - `makePrediction()` - API call to backend
  - `displayResult()` - Show prediction results
  - `updateStats()` - Update statistics
  - CSV upload handling
  - Drag & drop support
- **Size**: ~400 lines of JavaScript

### Configuration & Documentation

#### `requirements.txt` (Dependencies)
- **Purpose**: Python package list
- **Packages**:
  - Flask 2.3.3
  - Flask-CORS 4.0.0
  - scikit-learn 1.3.0
  - numpy, pandas, joblib
  - Plus others for data science
- **Install**: `pip install -r requirements.txt`

#### `README.md` (Full Documentation)
- **Contains**:
  - Complete project description
  - API endpoint documentation
  - Feature explanations
  - Troubleshooting guide
  - Data format specifications
  - Learning resources

#### `QUICK_START.md` (Setup Guide)
- **Contains**:
  - 5-step quick setup
  - Without detailed explanations
  - Perfect for getting started fast
  - Common troubleshooting

#### `COLAB_MODEL_EXPORT.py` (Export Script)
- **Purpose**: Template for saving model in Colab
- **Usage**: Copy-paste into Colab notebook
- **Output**: fraud_model.pkl file

## 🔌 API Endpoints

### POST /api/predict
```
Request:  { "features": [30 float values] }
Response: { "success": true, "prediction": "FRAUDULENT", "fraud_probability": 75.5 }
```

### GET /api/model-info
```
Response: { "model_type": "Random Forest", "n_estimators": 641, ... }
```

### GET /api/sample-features
```
Response: { "count": 30, "features": [...] }
```

## 🎯 Feature Summary

### Input Modes
1. **Manual Entry**: Type 30 feature values
2. **CSV Upload**: Upload multiple transactions
3. **Random Sample**: Generate test features

### Output Display
- Fraud/Legitimate classification
- Probability scores (0-100%)
- Confidence indicators
- Progress bars

### Statistics Tracking
- Total transactions analyzed
- Fraud count
- Legitimate count
- Overall fraud rate

## 🚀 Execution Flow

```
User Opens Browser
    ↓
Loads http://localhost:5000
    ↓
Flask server renders index.html
    ↓
JavaScript loads CSS & initializes interface
    ↓
User enters features OR uploads CSV
    ↓
JavaScript calls /api/predict
    ↓
Backend loads model & makes prediction
    ↓
Response sent to frontend
    ↓
JavaScript displays results
    ↓
Statistics updated
```

## 💾 Data Format

### Single Prediction (Manual)
```
30 floating-point numbers between -1 and 1
Example: 0.1, -0.5, 0.2, 0.05, ...
```

### Bulk Prediction (CSV)
```
V0, V1, V2, ..., V29  (Optional header)
0.1, -0.5, 0.2, ..., 0.3
0.2, -0.4, 0.1, ..., 0.25
...
```

## 🔄 Model Integration

### Step 1: Train in Colab
- Use your notebook: `Copy_of_credit_card_fraud_detection.ipynb`
- Train RandomForestClassifier with your data

### Step 2: Export from Colab
```python
import joblib
joblib.dump(classifier, 'fraud_model.pkl')
# Download the file
```

### Step 3: Add to Backend
- Place `fraud_model.pkl` in `backend/` folder
- app.py will automatically load it

### Step 4: Deploy
- Run Flask app
- All predictions use your trained model

## 📊 Statistics Tracked

| Metric | Display | Purpose |
|--------|---------|---------|
| Legitimate Count | Live update | Tracks safe transactions |
| Fraud Count | Live update | Tracks suspicious transactions |
| Total Analyzed | Live update | Running transaction count |
| Fraud Rate | Percentage | Overall fraud percentage |

## 🎨 UI Components

| Component | File | Purpose |
|-----------|------|---------|
| Header | index.html | Branding & title |
| Mode Toggle | index.html + script.js | Switch input methods |
| Feature Inputs | index.html + script.js | Enter transaction data |
| Result Card | style.css + script.js | Display predictions |
| Statistics | style.css + script.js | Show summary stats |
| Modal | index.html + style.css | Bulk results popup |

## 🔧 Configuration Options

### Change Port
Edit `backend/app.py` line ~90:
```python
app.run(debug=True, port=8000)  # Change from 5000
```

### Change Debug Mode
Edit `backend/app.py` line ~90:
```python
app.run(debug=False, port=5000)  # Set to False for production
```

### Customize Colors
Edit `frontend/static/style.css` lines 6-17:
```css
:root {
    --primary-color: #2563eb;  /* Change these */
    --secondary-color: #059669;
    /* ... */
}
```

## 📦 Dependency Versions

- **Flask**: 2.3.3+
- **scikit-learn**: 1.3.0+
- **Python**: 3.8+
- **NumPy**: 1.24.3+
- **Pandas**: 2.0.3+

## 🎓 Learning Paths

### To Understand Backend:
1. Read `backend/app.py` comments
2. Check API endpoints section above
3. Review Flask documentation

### To Understand Frontend:
1. Check `frontend/templates/index.html` structure
2. Review `frontend/static/style.css` styling
3. Trace JavaScript in `frontend/static/script.js`

### To Understand Full Flow:
1. Review execution flow diagram above
2. Trace request/response cycle
3. Check API documentation

## 🐛 Common Modifications

### Add Custom Feature Names
Edit `frontend/static/script.js` line 17:
```javascript
div.innerHTML = `<label>Custom Name</label>...`
```

### Add Backend Validation
Edit `backend/app.py` in `/api/predict` function

### Add More Predictions Modes
Edit `frontend/templates/index.html` and `script.js`

## 📈 Performance Notes

- Model prediction: ~10-50ms
- CSV parsing: ~100ms per 100 rows
- Frontend rendering: <100ms
- No database - all in-memory

## 🔒 Security Considerations

- CORS enabled for development
- No authentication in demo
- Model path not exposed
- Inputs validated on backend
- No sensitive data storage

---

**Last Updated**: December 2025
**Version**: 1.0
**Status**: Ready to Use
