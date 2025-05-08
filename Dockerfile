# Use a slim Python base image
FROM python:3.9-slim

# Set work directory
WORKDIR /app

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    && apt-get clean

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all source code
COPY . .

# Expose the Flask port
EXPOSE 5000

# Default command to run the app
CMD ["python", "app.py"]
