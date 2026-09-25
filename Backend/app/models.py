from sqlalchemy import Column, Integer, String, ForeignKey, Numeric, DateTime, Boolean, func
from sqlalchemy.orm import relationship
from app.database import Base


class Raza(Base):
    __tablename__ = "raza"
    id = Column(Integer, primary_key=True)
    nombre = Column(String(100), unique=True, nullable=False)


class Color(Base):
    __tablename__ = "color"
    id = Column(Integer, primary_key=True)
    nombre = Column(String(50), unique=True, nullable=False)


class Perrito(Base):
    __tablename__ = "perrito"
    id = Column(Integer, primary_key=True)
    nombre = Column(String(100), nullable=False)
    raza_id = Column(Integer, ForeignKey("raza.id"), nullable=True)
    foto_archivo = Column(String(255), nullable=False)
    latitud = Column(Numeric(10, 7), nullable=False)
    longitud = Column(Numeric(10, 7), nullable=False)
    fecha_registro = Column(DateTime, server_default=func.now())
    clave_idempotencia = Column(String(100), unique=True, nullable=False)

    raza = relationship("Raza")
    colores = relationship("PerritoColor", cascade="all, delete-orphan")


class PerritoColor(Base):
    __tablename__ = "perrito_color"
    perrito_id = Column(Integer, ForeignKey("perrito.id"), primary_key=True)
    color_id = Column(Integer, ForeignKey("color.id"), primary_key=True)
    es_principal = Column(Boolean, nullable=False, default=False)

    color = relationship("Color")
