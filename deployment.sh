#!/bin/bash

# Install dependencies
pip install -r requirements.txt

# Run the server with uvicorn
gunicorn main:app -w 4 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000
