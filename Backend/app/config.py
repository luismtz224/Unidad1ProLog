import os
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
RUTA_IMAGENES = os.getenv("RUTA_IMAGENES", "./imagenes")
CORS_ORIGINS = os.getenv("CORS_ORIGINS", "http://127.0.0.1:5500").split(",")

os.makedirs(RUTA_IMAGENES, exist_ok=True)