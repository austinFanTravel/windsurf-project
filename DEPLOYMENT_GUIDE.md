# LiveWebScraper API Deployment Guide

## Prerequisites

1. Ubuntu server running at 192.168.0.133
2. Domain LiveWebScraper.com pointing to 192.168.0.133
3. Python 3.8 or higher
4. pip and virtualenv installed
5. Nginx (recommended for production)

## Deployment Steps

1. SSH into your Ubuntu server:
```bash
ssh ubuntu@192.168.0.133
```

2. Create a directory for the project:
```bash
mkdir -p /home/ubuntu/livewebscraper
```

3. Clone the repository (replace with your actual repository URL):
```bash
cd /home/ubuntu/livewebscraper
git clone [your-repository-url] .
```

4. Set up Python virtual environment:
```bash
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

5. Copy the systemd service file:
```bash
cp livewebscraper.service /etc/systemd/system/
```

6. Reload systemd and start the service:
```bash
sudo systemctl daemon-reload
sudo systemctl start livewebscraper
sudo systemctl enable livewebscraper
```

7. Check service status:
```bash
sudo systemctl status livewebscraper
```

## Nginx Configuration (Optional but recommended)

1. Install Nginx:
```bash
sudo apt update
sudo apt install nginx
```

2. Create Nginx configuration:
```bash
sudo nano /etc/nginx/sites-available/livewebscraper
```

Add this configuration:
```nginx
server {
    listen 80;
    server_name LiveWebScraper.com;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

3. Enable and restart Nginx:
```bash
sudo ln -s /etc/nginx/sites-available/livewebscraper /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

## Verify Deployment

1. Check if the service is running:
```bash
sudo systemctl status livewebscraper
```

2. Test the API:
```bash
curl http://LiveWebScraper.com/health
```

## Troubleshooting

1. Check application logs:
```bash
sudo journalctl -u livewebscraper -f
```

2. Check Nginx logs:
```bash
sudo tail -f /var/log/nginx/error.log
```

## Security Notes

1. Consider using HTTPS with Let's Encrypt
2. Configure proper firewall rules
3. Use environment variables for sensitive configurations
4. Consider implementing rate limiting
