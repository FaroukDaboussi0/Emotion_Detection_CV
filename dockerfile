# Use the official Python image from the Docker Hub
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /MOTION_DETECTION

# Copy the requirements file into the container
COPY requirements.txt .

# Install virtualenv
RUN pip install virtualenv

# Create and activate the virtual environment
RUN python -m venv venv
RUN . venv/bin/activate

# Install the dependencies in the virtual environment
RUN . venv/bin/activate && pip install --no-cache-dir -r requirements.txt

# Download the model in the virtual environment
RUN . venv/bin/activate && python -c "from transformers import pipeline; pipeline('image-classification', model='trpakov/vit-face-expression')"

# Copy the rest of the application code into the container
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# Command to run the FastAPI application
CMD ["sh", "-c", ". venv/bin/activate && uvicorn emotion_detection:app --host 0.0.0.0 --port 8000"]
