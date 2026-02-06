# Use Python 3.11 slim base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Upgrade pip and install Flask
RUN python -m pip install --upgrade pip && python -m pip install Flask==2.3.6

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
