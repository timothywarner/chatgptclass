#!/bin/bash

# Step 1: Log in to GitHub Container Registry
docker login ghcr.io -u timothywarner
# Note: You'll be prompted for a password, use your personal access token with read:packages scope

# Step 2: Pull the Docker image
docker pull ghcr.io/timothywarner/my-flask-app:latest
# Replace 'my-flask-app:latest' with your actual image name and tag

# Step 3: Run the Docker image
docker run -p 5000:5000 ghcr.io/timothywarner/my-flask-app:latest
# This maps port 5000 of the container to port 5000 on your host machine

# Step 4: Access the application
# If it's a web application, access it via http://localhost:5000 in a web browser
