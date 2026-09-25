from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session, joinedload
from sqlalchemy.exc import IntegrityError
from app.database import get_db
from app import models
from app.schemas import PerritoIn
from app.services.imagen import guardar_foto_base64

router = APIRouter(prefix="/api/perritos", tags=["perritos"])


def serializar(p: models.Perrito) -> dict:
    """Misma forma que los objetos del arreglo PERRITOS mock en app.js,
    para que conectar el fetch() real sea un cambio mínimo."""
    principal = next((pc.color.nombre for pc in p.colores if pc.es_principal), None)
    adicionales = [pc.color.nombre for pc in p.colores if not pc.es_principal]
    return {
        "id": p.id,
        "nombre": p.nombre,
        "raza": p.raza.nombre if p.raza else None,
        "colorPrincipal": principal,
        "coloresAdicionales": adicionales,
        "latitud": float(p.latitud),
        "longitud": float(p.longitud),
        "foto": f"/api/imagenes/{p.foto_archivo}",
        "fecha_registro": p.fecha_registro.isoformat(),
    }


@router.get("/")
def listar(db: Session = Depends(get_db)):
    perritos = db.query(models.Perrito).options(
        joinedload(models.Perrito.raza),
        joinedload(models.Perrito.colores).joinedload(models.PerritoColor.color),
    ).order_by(models.Perrito.fecha_registro.desc()).all()
    return [serializar(p) for p in perritos]


@router.get("/{perrito_id}")
def detalle(perrito_id: int, db: Session = Depends(get_db)):
    p = db.get(models.Perrito, perrito_id)
    if not p:
        raise HTTPException(404, "Perrito no encontrado")
    return serializar(p)


@router.post("/")
def registrar(payload: PerritoIn, db: Session = Depends(get_db)):
    # Idempotencia: si la clave ya existe, se regresa el mismo registro
    # (mismo id, misma respuesta), sin crear uno nuevo.
    existente = db.query(models.Perrito).filter_by(
        clave_idempotencia=payload.clave_idempotencia
    ).first()
    if existente:
        return serializar(existente)

    # Raza es opcional: null en el payload se guarda como NULL (raza_id),
    # no se fuerza al renglón "Sin raza definida / criollo" del catálogo.
    raza_id = None
    if payload.raza:
        raza = db.query(models.Raza).filter_by(nombre=payload.raza).first()
        if not raza:
            raise HTTPException(400, f"La raza '{payload.raza}' no existe en el catálogo")
        raza_id = raza.id

    nombres_colores = [payload.colorPrincipal] + payload.coloresAdicionales
    if len(set(nombres_colores)) != len(nombres_colores):
        raise HTTPException(400, "No se puede repetir un color")

    colores_db = db.query(models.Color).filter(
        models.Color.nombre.in_(nombres_colores)
    ).all()
    mapa_colores = {c.nombre: c.id for c in colores_db}
    faltantes = [n for n in nombres_colores if n not in mapa_colores]
    if faltantes:
        raise HTTPException(
            400, f"Color(es) no encontrados en el catálogo: {', '.join(faltantes)}"
        )

    nombre_archivo = guardar_foto_base64(payload.foto)

    nuevo = models.Perrito(
        nombre=payload.nombre,
        raza_id=raza_id,
        foto_archivo=nombre_archivo,
        latitud=payload.latitud,
        longitud=payload.longitud,
        clave_idempotencia=payload.clave_idempotencia,
    )
    db.add(nuevo)
    try:
        db.flush()  # asigna nuevo.id sin cerrar la transacción todavía
        for idx, nombre_color in enumerate(nombres_colores):
            db.add(models.PerritoColor(
                perrito_id=nuevo.id,
                color_id=mapa_colores[nombre_color],
                es_principal=(idx == 0),
            ))
        db.commit()
    except IntegrityError:
        # Envío duplicado casi simultáneo: recupera el que ganó la carrera
        # en vez de responder con un error de duplicado.
        db.rollback()
        existente = db.query(models.Perrito).filter_by(
            clave_idempotencia=payload.clave_idempotencia
        ).first()
        return serializar(existente)

    db.refresh(nuevo)
    return serializar(nuevo)


@router.delete("/{perrito_id}")
def eliminar(perrito_id: int, db: Session = Depends(get_db)):
    p = db.get(models.Perrito, perrito_id)
    if not p:
        raise HTTPException(404, "Perrito no encontrado")
    db.delete(p)
    db.commit()
    return {"ok": True}
