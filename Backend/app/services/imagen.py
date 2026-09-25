import base64
import re
import uuid
import os
from io import BytesIO
from fastapi import HTTPException
from PIL import Image
from app.config import RUTA_IMAGENES

# app.js manda la foto como "data:image/jpeg;base64,AAAA..." (canvas.toDataURL
# en la cámara, FileReader.readAsDataURL en la subida de galería).
PATRON_DATA_URL = re.compile(r"^data:image/(?P<formato>\w+);base64,(?P<datos>.+)$")


def guardar_foto_base64(data_url: str) -> str:
    match = PATRON_DATA_URL.match(data_url or "")
    if not match:
        raise HTTPException(400, "Falta la foto")

    try:
        contenido = base64.b64decode(match.group("datos"))
    except Exception:
        raise HTTPException(400, "El archivo no es una imagen válida")

    # Se valida abriendo y decodificando la imagen de verdad, no solo
    # confiando en el prefijo "data:image/..." que mandó el navegador.
    try:
        img = Image.open(BytesIO(contenido))
        img.verify()
        formato_real = img.format.lower()
    except Exception:
        raise HTTPException(400, "El archivo no es una imagen válida")

    if formato_real not in ("jpeg", "png", "webp"):
        raise HTTPException(400, "Formato no soportado (usa JPG, PNG o WEBP)")

    extension = "jpg" if formato_real == "jpeg" else formato_real
    nombre_archivo = f"{uuid.uuid4().hex}.{extension}"
    ruta = os.path.join(RUTA_IMAGENES, nombre_archivo)
    with open(ruta, "wb") as f:
        f.write(contenido)

    return nombre_archivo
