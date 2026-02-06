# Use Python 3.11 slim base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Upgrade pip and install Flask
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy app folder
COPY app/ ./app/

# Set environment variable for Flask
ENV FLASK_APP=app/app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000

# Expose port 5000
EXPOSE 5000

# Run Flask app
CMD ["flask", "run"]
