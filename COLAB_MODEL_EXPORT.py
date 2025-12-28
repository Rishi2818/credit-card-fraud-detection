"""
Model Export Script
Run this in your Google Colab notebook to save your trained model

Instructions:
1. Copy this entire script to a cell in your Colab notebook
2. Make sure your classifier is trained (as in your notebook)
3. Run this cell
4. Download the fraud_model.pkl file
5. Place it in the backend/ folder of this project
"""

import joblib
import pickle
from google.colab import files

def save_model(classifier, model_name='fraud_model'):
    """
    Save the trained Random Forest classifier to disk
    
    Args:
        classifier: Trained sklearn classifier
        model_name: Name of the model file (without extension)
    """
    
    # Method 1: Using joblib (Recommended)
    joblib.dump(classifier, f'{model_name}.pkl')
    print(f"✓ Model saved as {model_name}.pkl using joblib")
    
    # Optional: Also save with pickle
    # with open(f'{model_name}_backup.pkl', 'wb') as f:
    #     pickle.dump(classifier, f)
    # print(f"✓ Backup saved as {model_name}_backup.pkl using pickle")
    
    return f'{model_name}.pkl'

def save_model_info(classifier, output_file='model_info.txt'):
    """
    Save model information and statistics
    
    Args:
        classifier: Trained sklearn classifier
        output_file: File to save information to
    """
    with open(output_file, 'w') as f:
        f.write("=" * 50 + "\n")
        f.write("FRAUD DETECTION MODEL INFORMATION\n")
        f.write("=" * 50 + "\n\n")
        
        f.write(f"Model Type: {type(classifier).__name__}\n")
        f.write(f"Number of Estimators: {classifier.n_estimators}\n")
        f.write(f"Number of Features: {classifier.n_features_in_}\n")
        f.write(f"Number of Classes: {classifier.n_classes_}\n")
        f.write(f"Random State: {classifier.random_state}\n")
        f.write(f"Max Depth: {classifier.max_depth}\n")
        f.write(f"Min Samples Split: {classifier.min_samples_split}\n")
        f.write(f"Min Samples Leaf: {classifier.min_samples_leaf}\n\n")
        
        f.write("=" * 50 + "\n")
        f.write("FEATURE IMPORTANCE (Top 10)\n")
        f.write("=" * 50 + "\n\n")
        
        # Get feature importances
        importances = classifier.feature_importances_
        top_indices = sorted(range(len(importances)), key=lambda i: importances[i], reverse=True)[:10]
        
        for rank, idx in enumerate(top_indices, 1):
            f.write(f"{rank}. Feature V{idx}: {importances[idx]:.4f}\n")
        
        f.write("\n" + "=" * 50 + "\n")
        f.write("USAGE IN FLASK APP\n")
        f.write("=" * 50 + "\n\n")
        f.write("1. Place 'fraud_model.pkl' in the backend/ folder\n")
        f.write("2. Ensure Flask app can find it (check app.py)\n")
        f.write("3. Send POST requests to /api/predict with 30 features\n")
        f.write("4. App will return fraud probability and prediction\n")

# ===== COPY AND RUN THIS IN YOUR COLAB NOTEBOOK =====
# Make sure your trained classifier is in a variable called 'classifier'

"""
# After training your model in Colab, run these lines:

model_path = save_model(classifier, 'fraud_model')
save_model_info(classifier)

# Download the files
files.download('fraud_model.pkl')
files.download('model_info.txt')

print("\n✓ All files ready for download!")
print("✓ Download fraud_model.pkl and place in backend/ folder")
print("✓ Download model_info.txt to review model details")
"""

# ===== TO USE THIS SCRIPT IN COLAB =====
"""
# Paste and run this in a Colab cell after training:

import joblib
from google.colab import files

# Assuming your trained classifier is in variable 'classifier'
joblib.dump(classifier, 'fraud_model.pkl')

# Download it
files.download('fraud_model.pkl')
"""
