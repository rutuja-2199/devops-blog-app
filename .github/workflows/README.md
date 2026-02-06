# GitHub Actions Workflow - Build and Push Docker Image

## Overview

This workflow automates the process of building and pushing the Flask app Docker image to Docker Hub whenever the application code changes.

- **Trigger**: Push to `main` branch
- **Affected paths**: `app/**` or `Dockerfile`
- **Docker Hub repository**: `rutujacvbuddy/flask-app`

---

## Workflow Steps

1. **Checkout repository**
   - Uses the official `actions/checkout@v3` action
   - Pulls the latest code from GitHub

2. **Login to Docker Hub**
   - Uses `docker/login-action@v3`
   - Uses secrets:
     - `DOCKER_HUB_USERNAME`
     - `DOCKER_HUB_ACCESS_TOKEN`
   - Token must have write/push access

3. **Build Docker Image**
   - Uses `docker build -t <dockerhub-username>/flask-app:latest .`
   - Dockerfile is located at the root of the repository

4. **Push Docker Image**
   - Pushes image to Docker Hub repository `rutujacvbuddy/flask-app:latest`
   - Image can be pulled by k3s or other Kubernetes clusters

---

## Secrets Required

| Secret Name                  | Description                       |
|-------------------------------|-----------------------------------|
| `DOCKER_HUB_USERNAME`         | Docker Hub username               |
| `DOCKER_HUB_ACCESS_TOKEN`     | Docker Hub access token (write)  |

---

## Notes

- Only triggers when `app/` or `Dockerfile` changes
- Docker image is built with Flask 2.3.3 directly in the Dockerfile
- Container exposes port `5000` for the Flask app
