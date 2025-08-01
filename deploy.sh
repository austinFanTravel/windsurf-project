#!/bin/bash

# Install system dependencies
sudo apt-get update
sudo apt-get install -y python3-pip python3-venv

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install Python dependencies
pip install -r requirements.txt

# Create systemd service file
sudo tee /etc/systemd/system/livewebscraper.service > /dev/null <<EOL
[Unit]
Description=LiveWebScraper API
After=network.target

[Service]
User=$(whoami)
WorkingDirectory=$(pwd)
Environment="PATH=$(pwd)/venv/bin"
ExecStart=$(pwd)/venv/bin/uvicorn main:app --host 0.0.0.0 --port 8000
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd and start service
sudo systemctl daemon-reload
sudo systemctl enable livewebscraper
sudo systemctl start livewebscraper

# Enable firewall and allow ports
sudo ufw allow 8000
sudo ufw enable
