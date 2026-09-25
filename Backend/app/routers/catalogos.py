from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database import get_db
from app import models

router = APIRouter(prefix="/api", tags=["catalogos"])


@router.get("/razas")
def listar_razas(db: Session = Depends(get_db)):
    # Se excluye "Sin raza definida / criollo": en el <select> del
    # formulario esa opción ya es el valor vacío inicial (ver app.js,
    # arreglo RAZAS no la incluye tampoco).
    razas = db.query(models.Raza).filter(
        models.Raza.nombre != "Sin raza definida / criollo"
    ).order_by(models.Raza.nombre).all()
    return [r.nombre for r in razas]


@router.get("/colores")
def listar_colores(db: Session = Depends(get_db)):
    # Solo nombres: el hex de cada swatch (HEX_POR_COLOR en app.js) es
    # una decisión de estilo del frontend, no vive en la base de datos.
    colores = db.query(models.Color).order_by(models.Color.nombre).all()
    return [c.nombre for c in colores]
