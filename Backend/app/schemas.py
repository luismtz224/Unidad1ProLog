from pydantic import BaseModel, field_validator
from typing import List, Optional


class PerritoIn(BaseModel):
    """Coincide exactamente con el objeto 'registro' que arma app.js
    al hacer submit del formulario (ver el fetch comentado en app.js)."""
    clave_idempotencia: str
    nombre: str
    raza: Optional[str] = None            # nombre de la raza, o null
    colorPrincipal: str                    # nombre del color
    coloresAdicionales: List[str] = []     # 0 a 2 nombres de color
    latitud: float
    longitud: float
    foto: str                              # data URL base64 (data:image/...;base64,....)

    @field_validator("nombre")
    @classmethod
    def nombre_no_vacio(cls, v):
        if not v.strip():
            raise ValueError("El nombre no puede estar vacío")
        if len(v) > 100:
            raise ValueError("El nombre no puede tener más de 100 caracteres")
        return v.strip()

    @field_validator("colorPrincipal")
    @classmethod
    def color_principal_no_vacio(cls, v):
        if not v.strip():
            raise ValueError("Falta el color principal")
        return v

    @field_validator("coloresAdicionales")
    @classmethod
    def maximo_dos_adicionales(cls, v):
        if len(v) > 2:
            raise ValueError("Máximo 3 colores en total (1 principal + 2 adicionales)")
        return v

    @field_validator("latitud")
    @classmethod
    def lat_en_rango(cls, v):
        if not -90 <= v <= 90:
            raise ValueError("Latitud fuera de rango")
        return v

    @field_validator("longitud")
    @classmethod
    def lng_en_rango(cls, v):
        if not -180 <= v <= 180:
            raise ValueError("Longitud fuera de rango")
        return v