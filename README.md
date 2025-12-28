# Credit Card Fraud Detection System

A full-stack web application for detecting fraudulent credit card transactions using machine learning (Random Forest Classifier).

## 🎯 Features

- **Interactive Dashboard**: Beautiful, responsive UI for transaction analysis
- **Multiple Input Methods**:
  - Manual feature entry for single transactions
  - Bulk CSV upload for multiple transactions
  - Random sample generation for testing
- **Real-time Predictions**: Machine learning powered fraud detection
- **Detailed Results**: Probability scores and confidence metrics
- **Statistics Dashboard**: Track fraud patterns across all analyzed transactions
- **Mobile Responsive**: Works seamlessly on desktop, tablet, and mobile

## 📁 Project Structure

```
credit card/
├── backend/
│   ├── app.py                 # Flask API server
│   └── fraud_model.pkl        # Trained model (optional)
├── frontend/
│   ├── templates/
│   │   └── index.html        # Main web interface
│   └── static/
│       ├── style.css         # Styling
│       └── script.js         # JavaScript functionality
├── Copy_of_credit_card_fraud_detection.ipynb  # Original Colab notebook
└── requirements.txt          # Python dependencies
```

## 🚀 Quick Start

### 1. Install Dependencies

```bash
pip install -r requirements.txt
```

### 2. Prepare Your Model

**Option A: Using the trained model from Colab**
- Train your model in Google Colab and save it:
```python
import joblib
joblib.dump(classifier, 'fraud_model.pkl')
```
- Download the `fraud_model.pkl` file and place it in the `backend/` folder

**Option B: Use built-in dummy model**
- The app includes a dummy model for testing if no saved model is found

### 3. Run the Application

Navigate to the backend folder and start the Flask server:

```bash
cd backend
python app.py
```

The application will start on `http://localhost:5000`

## 📊 Using the Application

### Manual Mode
1. Enter feature values (V0-V29) for your transaction
2. Click "Analyze Transaction"
3. View fraud probability and confidence score

### Bulk Upload Mode
1. Prepare a CSV file with 30 features per row (no headers recommended)
2. Drag and drop or select the CSV file
3. Click "Upload & Analyze"
4. View aggregated results

### Random Sample Mode
1. Click "Generate Random Features"
2. Random transaction features will be generated and analyzed
3. Useful for testing and demonstration

## 🔧 API Endpoints

### POST /api/predict
Predict fraud for a single transaction

**Request:**
```json
{
  "features": [0.1, -0.5, 0.2, ..., 0.3]  // Array of 30 float values
}
```

**Response:**
```json
{
  "success": true,
  "prediction": "FRAUDULENT",
  "fraud_probability": 75.45,
  "legitimate_probability": 24.55,
  "raw_prediction": 1
}
```

### GET /api/model-info
Get information about the trained model

**Response:**
```json
{
  "model_type": "Random Forest Classifier",
  "n_estimators": 641,
  "n_features": 30,
  "model_status": "loaded"
}
```

### GET /api/sample-features
Get information about feature structure

## 🔄 Integrating Your Colab Model

### Step 1: Save Model in Colab

```python
# In your Colab notebook
import joblib

# After training your RandomForestClassifier
joblib.dump(classifier, 'fraud_model.pkl')

# Download the file from Colab
from google.colab import files
files.download('fraud_model.pkl')
```

### Step 2: Place Model in Backend

Move the downloaded `fraud_model.pkl` to the `backend/` folder

### Step 3: Restart the Application

The app will automatically load your trained model on startup

## 📈 Expected Performance

Based on your Colab notebook:
- **Model**: Random Forest Classifier (641 estimators)
- **Features**: 30 PCA-transformed features
- **Accuracy**: ~99%
- **Precision**: High
- **Recall**: High
- **Dataset**: Credit Card Fraud Detection (imbalanced → balanced with oversampling)

## 🛠️ Customization

### Change Port
Edit `backend/app.py`:
```python
if __name__ == '__main__':
    load_or_create_model()
    app.run(debug=True, port=8000)  # Change port here
```

### Modify Styling
Edit `frontend/static/style.css` to customize colors and themes

### Add Features
Edit `frontend/static/script.js` for new functionality

## 🔐 Security Notes

- The app includes CORS support for development
- In production, configure CORS appropriately in `app.py`
- Never expose your model's source code or training data
- Validate all inputs on both client and server

## 📦 Requirements

- Python 3.8+
- Flask 2.3.3+
- scikit-learn 1.3.0+
- Modern web browser (Chrome, Firefox, Safari, Edge)

## 🐛 Troubleshooting

### Port Already in Use
```bash
# Change the port in app.py or find process using port 5000
# Windows:
netstat -ano | findstr :5000

# Kill the process:
taskkill /PID <PID> /F
```

### Model Not Loading
- Ensure `fraud_model.pkl` is in the `backend/` folder
- Check file permissions
- The app will create a dummy model if file is missing

### CORS Issues
- Make sure Flask-CORS is installed: `pip install Flask-CORS`
- Check backend is running on localhost:5000

### Features Mismatch
- Your model must have exactly 30 features
- CSV should have 30 columns (or 31 with header row)

## 📝 Data Format

**CSV Format for Bulk Upload:**
```
0.1,-0.5,0.2,0.05,...,0.3
0.2,-0.4,0.1,0.02,...,0.25
...
```

Features should be normalized/scaled values, typically between -1 and 1.

## 🎓 Learning Resources

- [Random Forest Classifier](https://scikit-learn.org/stable/modules/ensemble.html#random-forests)
- [Credit Card Fraud Detection Dataset](https://www.kaggle.com/mlg-ulb/creditcardfraud)
- [Flask Documentation](https://flask.palletsprojects.com/)
- [Machine Learning Best Practices](https://scikit-learn.org/stable/modules/model_evaluation.html)

## 📄 License

This project is provided as-is for educational purposes.

## 💡 Tips for Best Results

1. **Feature Scaling**: Ensure features are properly scaled (standardized)
2. **Data Quality**: Invalid features may produce unexpected results
3. **Model Training**: Use balanced dataset for better fraud detection
4. **Testing**: Always test with known fraudulent/legitimate samples
5. **Monitoring**: Track fraud detection rates over time

## 🤝 Support

For issues or questions:
1. Check the troubleshooting section above
2. Review console logs in your browser (F12)
3. Check Flask console output for backend errors
4. Verify all dependencies are installed correctly

---

**Created**: 2025
**Framework**: Flask + Vanilla JavaScript
**ML Model**: Random Forest Classifier
