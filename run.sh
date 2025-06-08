#!/bin/bash

# Check if .env virtual environment exists
if [ ! -d ".env" ]; then
    echo "Creating virtual environment in .env..."
    python3 -m venv .env
fi

# Activate the virtual environment
source .env/bin/activate

echo "Virtual environment activated."

# Install dependencies
pip install --upgrade pip
if [ -f requirements.txt ]; then
    pip install -r requirements.txt
fi

echo "Project is ready."
# Add your project start command below, e.g.:
# python main.py

# Start FastAPI app with uvicorn
uvicorn main:app --host 0.0.0.0 --port 8000
