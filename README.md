# LiveWebScraper API

A simple API server for LiveWebScraper.com

## Setup

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Run the server:
```bash
uvicorn main:app --host 0.0.0.0 --port 8000
```

## Endpoints

- `GET /`: Welcome message
- `GET /health`: Health check endpoint

## Deployment

The API is deployed on an Ubuntu server at IP 192.168.0.133 with domain LiveWebScraper.com
