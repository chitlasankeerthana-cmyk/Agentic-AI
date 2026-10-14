# Use a lightweight official Python image
FROM python:3.11-slim

# Set system working directory
WORKDIR /app

# Install system dependencies if needed (e.g., for PDF processing wrappers)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .
# Expose the port FastAPI will run on
EXPOSE 8000

# Run Uvicorn using the settings Render expects
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
