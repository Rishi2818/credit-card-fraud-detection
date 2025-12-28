from flask import Flask, render_template, request, jsonify
from flask_cors import CORS
import numpy as np
import pickle
import joblib
import os
from sklearn.ensemble import RandomForestClassifier
import json

app = Flask(__name__, static_folder='../frontend/static', template_folder='../frontend/templates')
CORS(app)

# Global model variable
model = None

def load_or_create_model():
    """Load saved model or create a dummy one for demonstration"""
    global model
    model_path = 'fraud_model.pkl'
    
    if os.path.exists(model_path):
        try:
            model = joblib.load(model_path)
            print("Model loaded successfully")
        except Exception as e:
            print(f"Error loading model: {e}")
            model = RandomForestClassifier(n_estimators=641, random_state=0)
    else:
        # Create a dummy model for testing
        print("Creating dummy model for testing")
        model = RandomForestClassifier(n_estimators=641, random_state=0)
        # Generate dummy training data (30 features as per your dataset)
        X_dummy = np.random.randn(100, 30)
        y_dummy = np.random.randint(0, 2, 100)
        model.fit(X_dummy, y_dummy)

@app.route('/')
def index():
    """Render the main page"""
    return render_template('index.html')

@app.route('/api/predict', methods=['POST'])
def predict():
    """
    API endpoint for fraud detection prediction
    Expects JSON with 30 transaction features
    """
    try:
        data = request.get_json()
        
        # Extract features from request
        features = data.get('features', [])
        
        if not features or len(features) != 30:
            return jsonify({
                'success': False,
                'error': f'Expected 30 features, got {len(features)}'
            }), 400
        
        # Convert to numpy array and reshape for prediction
        X = np.array(features).reshape(1, -1)
        
        # Make prediction
        prediction = model.predict(X)[0]
        probability = model.predict_proba(X)[0]
        
        # Prepare response
        is_fraud = int(prediction) == 1
        fraud_probability = float(probability[1]) * 100
        
        return jsonify({
            'success': True,
            'prediction': 'FRAUDULENT' if is_fraud else 'LEGITIMATE',
            'fraud_probability': round(fraud_probability, 2),
            'legitimate_probability': round((1 - probability[1]) * 100, 2),
            'raw_prediction': int(prediction)
        })
    
    except Exception as e:
        return jsonify({
            'success': False,
            'error': str(e)
        }), 500

@app.route('/api/model-info', methods=['GET'])
def model_info():
    """Get information about the model"""
    return jsonify({
        'model_type': 'Random Forest Classifier',
        'n_estimators': 641,
        'n_features': 30,
        'model_status': 'loaded' if model else 'not loaded'
    })

@app.route('/api/sample-features', methods=['GET'])
def sample_features():
    """Get sample feature names and ranges"""
    features_info = {
        'count': 30,
        'features': [
            {'name': f'Feature_{i}', 'type': 'float', 'description': f'Transaction feature {i}'} 
            for i in range(30)
        ],
        'note': 'Features should be normalized/scaled values between -1 and 1'
    }
    return jsonify(features_info)

if __name__ == '__main__':
    load_or_create_model()
    app.run(debug=True, port=5000)
