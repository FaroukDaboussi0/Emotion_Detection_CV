# Use the official Python image from Docker Hub
FROM python:3.10-slim  

# Set the working directory in the container
WORKDIR /MOTION_DETECTION

# Copy the requirements file into the container
COPY requirements.txt .

# Install the required dependencies globally in the container
RUN pip install --no-cache-dir -r requirements.txt

# Download the model (this will be cached globally in the container)
RUN python -c "from transformers import pipeline; pipeline('image-classification', model='trpakov/vit-face-expression')"

# Copy the rest of the application code into the container
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# Command to run the FastAPI application
CMD ["uvicorn", "emotion_detection:app", "--host", "0.0.0.0", "--port", "8000"]
