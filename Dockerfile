# Use official Python 3.14 slim image
FROM python:3.14-slim

# Set work directory
WORKDIR /app

# Install system dependencies for psycopg3
RUN apt-get update && apt-get install -y gcc libpq-dev && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app files
COPY . .

# Expose Flask port
EXPOSE 5000

# Set environment variables
ENV FLASK_APP=wsgi.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_ENV=production

# Run app with Gunicorn
CMD ["gunicorn", "-b", "0.0.0.0:5000", "wsgi:app"]
