import os
from fastapi import APIRouter, HTTPException
from fastapi.responses import FileResponse
from app.config import RUTA_IMAGENES

router = APIRouter(prefix="/api/imagenes", tags=["imagenes"])


@router.get("/{nombre_archivo}")
def obtener_imagen(nombre_archivo: str):
    nombre_seguro = os.path.basename(nombre_archivo)
    ruta = os.path.join(RUTA_IMAGENES, nombre_seguro)
    if not os.path.isfile(ruta):
        raise HTTPException(404, "Imagen no encontrada")
    return FileResponse(ruta)