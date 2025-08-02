#!/bin/bash
set -e  # Exit on error

# Define paths
VENV_DIR="venv"
REQUIREMENTS="requirements.txt"

# Create virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
    
    # Activate the virtual environment
    source "$VENV_DIR/bin/activate"
    
    # Upgrade pip and install requirements
    echo "Installing dependencies..."
    pip install --upgrade pip
    
    if [ -f "$REQUIREMENTS" ]; then
        pip install -r "$REQUIREMENTS"
    else
        echo "Warning: $REQUIREMENTS not found. No dependencies installed."
    fi
else
    # Activate existing virtual environment
    source "$VENV_DIR/bin/activate"
fi

# Install gunicorn if not already installed
if ! pip show gunicorn &> /dev/null; then
    echo "Installing gunicorn..."
    pip install gunicorn
fi

# Run the server
echo "Starting server..."
exec gunicorn main:app \
    -w 4 \
    -k uvicorn.workers.UvicornWorker \
    --bind 0.0.0.0:8000 \
    --access-logfile - \
    --error-logfile -
