# Registro de perritos de la calle

Proyecto 1 — Programación lógica y funcional.

## 1. Integrantes y roles

| Nombre | Rol |
|---|---|
| [Nombre] | Frontend |
| [Nombre] | Backend |
| Sofía Cortés | DBA |

## 2. Requisitos previos

| Herramienta | Versión |
|---|---|
| MySQL | 8.0+ |
| Python | 3.14.x |
| [PENDIENTE - Frontend: herramientas y versión exacta] | |

## 3. Instalación (pasos en orden)

```bash
# 1. Clonar el repositorio
git clone https://github.com/luismtz224/Unidad1ProLog.git
cd Unidad1ProLog

# 2. Crear la base de datos (ver sección 4)

# 3. Configurar variables de entorno (ver sección 5)

# 4. Instalar y correr el backend
cd Backend
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000

# 5. Instalar y correr el frontend
[PENDIENTE - Frontend: comandos exactos]
```

## 4. Creación de la base de datos y carga de datos

Todo esto vive en la carpeta `db/`. Se corre en este orden:

```bash
mysql -u root -p < db/01_schema.sql
mysql -u root -p < db/02_catalogos.sql
mysql -u root -p < db/03_datos_prueba.sql
```

Esto crea la base `perritos_calle`, sus 4 tablas (`raza`, `color`, `perrito`, `perrito_color`), carga el catálogo (11 razas, 10 colores) y 15 perritos de prueba con foto.

(Opcional, recomendado) Crear un usuario de aplicación en vez de usar `root`:
```sql
CREATE USER 'perritos_app'@'%' IDENTIFIED BY 'una_contraseña_fuerte';
GRANT SELECT, INSERT, UPDATE, DELETE ON perritos_calle.* TO 'perritos_app'@'%';
FLUSH PRIVILEGES;
```

## 5. Configuración (variables de entorno)

Copiar la plantilla y llenar con valores reales:
```bash
cp .env.example .env
```

Estos 3 valores **no vienen predefinidos** — cada quien los decide al momento de instalar:

| Variable | ¿De dónde sale el valor? |
|---|---|
| `DATABASE_URL` | `mysql+pymysql://[USUARIO]:[CONTRASEÑA]@localhost:3306/[NOMBRE_DE_LA_BASE]` |
| `RUTA_IMAGENES` | Una carpeta que tú creas en tu propia computadora, **fuera** de este repositorio (ej. `C:/perritos_imagenes` en Windows, o `/var/data/perritos/imagenes` en Linux/Mac). |
| `RUTA_RESPALDOS` | Otra carpeta que tú eliges, donde se van a guardar los archivos que genere `backup.sh`. |

Variables del backend:

| Variable | ¿De dónde sale el valor? |
|---|---|
| `CORS_ORIGINS` | Direcciones desde donde el frontend puede llamar al backend. Ejemplo: `http://127.0.0.1:5500,http://localhost:5500` |

[PENDIENTE - Frontend: agregar aquí sus propias variables, si tiene]

## 6. Cómo ejecutar el backend y el frontend

**Backend:**
```bash
cd Backend
uvicorn app.main:app --reload --port 8000
```
Queda disponible en: `http://127.0.0.1:8000`

[PENDIENTE - Frontend: comandos para correrlo y en qué URL queda]

## 7. Cómo probarlo desde un celular en la misma red

[PENDIENTE - Frontend/Backend: explicar cómo conectarse desde el celular usando la IP local de la compu, y recordar que la cámara y ubicación solo funcionan con HTTPS o localhost]

## 8. Endpoints de la API

[PENDIENTE - Backend: lista completa de endpoints]

## 9. Capturas de pantalla

[PENDIENTE - Frontend: agregar capturas del formulario, el mapa, la lista]

## 10. Problemas comunes y cómo resolverlos

| Problema | Solución |
|---|---|
| Error de conexión a la base de datos | Verificar que `DATABASE_URL` en `.env` tenga el usuario, contraseña, host y nombre de base correctos, y que MySQL esté corriendo |
| Falla al cargar los scripts `.sql` | Confirmar que se corrieron en orden: `01_schema.sql` → `02_catalogos.sql` → `03_datos_prueba.sql` |

[PENDIENTE - Backend/Frontend: agregar sus propios casos comunes]

## 11. Paradigmas

**Declarativo (SQL):** el filtrado, ordenamiento y agregación de datos ocurre en SQL, no con ciclos. Ver `db/04_consultas.sql`: una consulta con JOIN (perrito + sus colores) y dos consultas de agregación (perritos por color, perritos por zona).

**Idempotencia del registro (diseño de base de datos):** la tabla `perrito` tiene la columna `clave_idempotencia` como `UNIQUE`. Esto permite que, si el mismo formulario se envía dos veces con la misma clave, la base rechace el segundo intento de insertar un registro duplicado.

[PENDIENTE - Backend: explicar cómo usa esa clave antes de insertar (dónde está ese código, qué hace exactamente)]
[PENDIENTE - Frontend: dónde se genera la clave de idempotencia, y cualquier transformación funcional con map/filter/reduce]
[PENDIENTE - Backend: identificar los demás paradigmas usados (orientado a objetos, imperativo) y dónde está ese código]

## 12. Despliegue (punto extra)

[PENDIENTE - si el equipo va por el punto extra: dónde correría cada pieza, HTTPS, variables de producción, puertos, respaldo, systemd + nginx/Caddy]