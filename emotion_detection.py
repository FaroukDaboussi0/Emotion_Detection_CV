from fastapi import FastAPI, File, UploadFile
from transformers import pipeline
from PIL import Image
import io

app = FastAPI()

pipe = pipeline("image-classification", model="trpakov/vit-face-expression")

@app.post("/classify-emotion/")
async def classify_emotion(file: UploadFile = File(...)):
    # Read the image file
    image_bytes = await file.read()
    image = Image.open(io.BytesIO(image_bytes))

    # Classify the image and get the emotion
    results = pipe(image)

    return results
