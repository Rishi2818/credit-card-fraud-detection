// Global state
let predictions = [];
let stats = {
    legitimate: 0,
    fraud: 0,
    total: 0
};

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    initializeFeatures();
    setupEventListeners();
    loadModelInfo();
});

/**
 * Initialize feature input fields
 */
function initializeFeatures() {
    const container = document.getElementById('features-container');
    container.innerHTML = '';

    for (let i = 0; i < 30; i++) {
        const div = document.createElement('div');
        div.className = 'feature-input';
        div.innerHTML = `
            <label for="feature-${i}">V${i}</label>
            <input type="number" id="feature-${i}" placeholder="0.0" step="0.01" value="0">
        `;
        container.appendChild(div);
    }
}

/**
 * Setup event listeners
 */
function setupEventListeners() {
    // Mode toggle buttons
    document.querySelectorAll('.mode-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            switchMode(this.dataset.mode);
        });
    });

    // Predict button
    document.getElementById('predict-btn').addEventListener('click', predictManual);

    // CSV upload
    const uploadArea = document.getElementById('upload-area');
    const csvInput = document.getElementById('csv-input');
    const uploadBtn = document.getElementById('upload-btn');

    uploadArea.addEventListener('click', () => csvInput.click());
    uploadArea.addEventListener('dragover', handleDragOver);
    uploadArea.addEventListener('dragleave', handleDragLeave);
    uploadArea.addEventListener('drop', handleDrop);

    csvInput.addEventListener('change', function() {
        if (this.files.length > 0) {
            uploadBtn.style.display = 'block';
        }
    });

    uploadBtn.addEventListener('click', predictCSV);

    // Random button
    document.getElementById('random-btn').addEventListener('click', predictRandom);

    // Modal close button
    const modal = document.getElementById('result-modal');
    const closeBtn = document.querySelector('.close');
    closeBtn.addEventListener('click', () => {
        modal.style.display = 'none';
    });

    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });
}

/**
 * Switch between input modes
 */
function switchMode(mode) {
    // Update buttons
    document.querySelectorAll('.mode-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    document.querySelector(`[data-mode="${mode}"]`).classList.add('active');

    // Update visible mode
    document.querySelectorAll('.input-mode').forEach(el => {
        el.classList.remove('active');
    });
    document.getElementById(`${mode}-mode`).classList.add('active');
}

/**
 * Get features from input fields
 */
function getFeatures() {
    const features = [];
    for (let i = 0; i < 30; i++) {
        const value = parseFloat(document.getElementById(`feature-${i}`).value);
        features.push(isNaN(value) ? 0 : value);
    }
    return features;
}

/**
 * Manual prediction
 */
async function predictManual() {
    const features = getFeatures();
    await makePrediction(features);
}

/**
 * Random prediction
 */
function predictRandom() {
    const features = Array.from({ length: 30 }, () => {
        return +(Math.random() * 2 - 1).toFixed(2); // Random values between -1 and 1
    });

    // Update input fields with random values
    features.forEach((value, index) => {
        document.getElementById(`feature-${index}`).value = value;
    });

    makePrediction(features);
}

/**
 * CSV prediction
 */
async function predictCSV() {
    const file = document.getElementById('csv-input').files[0];
    if (!file) {
        alert('Please select a file');
        return;
    }

    const reader = new FileReader();
    reader.onload = async function(e) {
        try {
            const csv = e.target.result;
            const lines = csv.trim().split('\n');
            
            // Skip header if present
            const startIndex = lines[0].split(',').length === 30 ? 0 : 1;
            
            for (let i = startIndex; i < lines.length; i++) {
                const features = lines[i].split(',').map(val => parseFloat(val.trim()));
                if (features.length === 30 && features.every(f => !isNaN(f))) {
                    await makePrediction(features, true);
                }
            }
            
            updateStats();
            showBulkResults();
        } catch (error) {
            alert('Error processing CSV: ' + error.message);
        }
    };
    reader.readAsText(file);
}

/**
 * Make prediction via API
 */
async function makePrediction(features, bulkMode = false) {
    if (!bulkMode) {
        showLoading(true);
    }

    try {
        const response = await fetch('/api/predict', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ features: features })
        });

        const data = await response.json();

        if (data.success) {
            predictions.push(data);
            updateStats();
            
            if (!bulkMode) {
                showLoading(false);
                displayResult(data);
            }
        } else {
            if (!bulkMode) {
                showLoading(false);
                alert('Prediction error: ' + data.error);
            }
        }
    } catch (error) {
        if (!bulkMode) {
            showLoading(false);
            alert('Error making prediction: ' + error.message);
        }
    }
}

/**
 * Display prediction result
 */
function displayResult(data) {
    const resultContainer = document.getElementById('result-container');
    const isFraud = data.raw_prediction === 1;

    const resultHTML = `
        <div class="result-card">
            <div class="result-header">
                <div class="result-badge ${isFraud ? 'fraud' : 'legitimate'}">
                    <i class="fas ${isFraud ? 'fa-exclamation-triangle' : 'fa-check-circle'}"></i>
                </div>
                <div class="result-label">
                    <h3>${data.prediction}</h3>
                    <p>${isFraud ? 'High Risk Transaction' : 'Safe Transaction'}</p>
                </div>
            </div>

            <div class="probability-bar">
                <div class="bar-label">
                    <span>Fraud Probability</span>
                    <span style="color: var(--danger-color); font-weight: 700;">${data.fraud_probability}%</span>
                </div>
                <div class="progress-container">
                    <div class="progress-bar fraud" style="width: ${data.fraud_probability}%">
                        ${data.fraud_probability > 10 ? data.fraud_probability + '%' : ''}
                    </div>
                    <div class="progress-bar legitimate" style="width: ${data.legitimate_probability}%; background: linear-gradient(90deg, #059669, #047857);">
                        ${data.legitimate_probability > 10 ? data.legitimate_probability + '%' : ''}
                    </div>
                </div>
            </div>

            <div style="margin-top: 20px; padding-top: 20px; border-top: 2px solid var(--border-color);">
                <p style="color: var(--text-light); font-size: 0.9em;">
                    <strong>Confidence:</strong> This transaction has a ${isFraud ? 'high' : 'low'} probability of being fraudulent based on the Random Forest model analysis.
                </p>
            </div>
        </div>
    `;

    resultContainer.innerHTML = resultHTML;
}

/**
 * Show bulk results
 */
function showBulkResults() {
    const fraudCount = predictions.filter(p => p.raw_prediction === 1).length;
    const legitimateCount = predictions.length - fraudCount;

    const modal = document.getElementById('result-modal');
    const modalBody = document.getElementById('modal-body');

    const avgFraudProb = predictions.reduce((sum, p) => sum + p.fraud_probability, 0) / predictions.length;

    modalBody.innerHTML = `
        <h2 style="margin-bottom: 20px;">Bulk Analysis Results</h2>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 20px;">
            <div style="background: var(--success-light); padding: 15px; border-radius: 8px;">
                <p style="color: var(--text-light); font-size: 0.9em;">Legitimate</p>
                <p style="font-size: 2em; font-weight: 700; color: var(--secondary-color);">${legitimateCount}</p>
            </div>
            <div style="background: var(--danger-light); padding: 15px; border-radius: 8px;">
                <p style="color: var(--text-light); font-size: 0.9em;">Fraudulent</p>
                <p style="font-size: 2em; font-weight: 700; color: var(--danger-color);">${fraudCount}</p>
            </div>
        </div>
        <p style="color: var(--text-light);">
            <strong>Total Transactions:</strong> ${predictions.length}<br>
            <strong>Average Fraud Probability:</strong> ${avgFraudProb.toFixed(2)}%<br>
            <strong>Fraud Detection Rate:</strong> ${((fraudCount / predictions.length) * 100).toFixed(2)}%
        </p>
    `;

    modal.style.display = 'block';
}

/**
 * Update statistics
 */
function updateStats() {
    stats.total = predictions.length;
    stats.fraud = predictions.filter(p => p.raw_prediction === 1).length;
    stats.legitimate = predictions.length - stats.fraud;

    document.getElementById('legitimate-count').textContent = stats.legitimate;
    document.getElementById('fraud-count').textContent = stats.fraud;
    document.getElementById('total-count').textContent = stats.total;

    const fraudRate = stats.total > 0 ? ((stats.fraud / stats.total) * 100).toFixed(1) : 0;
    document.getElementById('fraud-rate').textContent = fraudRate + '%';
}

/**
 * Show/hide loading spinner
 */
function showLoading(show) {
    const loading = document.getElementById('loading');
    const resultContainer = document.getElementById('result-container');

    if (show) {
        loading.style.display = 'flex';
        resultContainer.style.display = 'none';
    } else {
        loading.style.display = 'none';
        resultContainer.style.display = 'block';
    }
}

/**
 * Drag and drop handlers
 */
function handleDragOver(e) {
    e.preventDefault();
    e.stopPropagation();
    e.currentTarget.style.background = '#f0f4ff';
}

function handleDragLeave(e) {
    e.preventDefault();
    e.stopPropagation();
    e.currentTarget.style.background = 'var(--light-bg)';
}

function handleDrop(e) {
    e.preventDefault();
    e.stopPropagation();
    e.currentTarget.style.background = 'var(--light-bg)';

    const files = e.dataTransfer.files;
    if (files.length > 0 && files[0].type === 'text/csv') {
        document.getElementById('csv-input').files = files;
        document.getElementById('upload-btn').style.display = 'block';
    } else {
        alert('Please drop a CSV file');
    }
}

/**
 * Load model information
 */
async function loadModelInfo() {
    try {
        const response = await fetch('/api/model-info');
        const data = await response.json();
        console.log('Model loaded:', data);
    } catch (error) {
        console.error('Error loading model info:', error);
    }
}

// Export functions for testing
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        getFeatures,
        makePrediction,
        updateStats
    };
}
