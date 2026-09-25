from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routers import perritos, catalogos, imagenes
from app.config import CORS_ORIGINS

# OJO: no se llama Base.metadata.create_all() aquí. El esquema ya vive
# en db/01_schema.sql (+ 02_catalogos.sql y 03_datos_prueba.sql) y esa
# es la fuente de verdad de la estructura de la base — este backend
# solo se conecta a tablas que ya existen.

app = FastAPI(title="Registro de perritos de la calle")

app.add_middleware(
    CORSMiddleware,
    allow_origins=CORS_ORIGINS,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(perritos.router)
app.include_router(catalogos.router)
app.include_router(imagenes.router)


@app.get("/health")
def health():
    return {"status": "ok"}