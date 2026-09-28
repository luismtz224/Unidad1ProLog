# Registro de perritos de la calle

Proyecto 1 — Programación lógica y funcional.

## 1. Integrantes y roles

| Nombre | Rol |
|---|---|
| Luis Fernando Martínez Muñiz | Frontend |
| Ángel Imanol Velázquez Hernández | Backend |
| Sofía Cortés | DBA |

## 2. Requisitos previos

| Herramienta | Versión |
|---|---|
| MySQL | 8.0+ |
| Python | 3.14.x |
| Un navegador moderno (Chrome, Firefox, Safari) y un servidor estático local (Live Server de VS Code, o `python -m http.server`) | — (el frontend es HTML/CSS/JS plano, no necesita instalar nada) |

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

# 5. Instalar y correr el frontend (no necesita instalar nada, es HTML/CSS/JS plano)
cd frontend
python -m http.server 5500
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

El frontend no usa variables de entorno propias: la dirección del backend (`API_BASE` en `app.js`) se arma sola a partir del host desde el que se abrió la página, así que no hay nada que configurar a mano ni siquiera para probarlo desde el celular (ver sección 7).

## 6. Cómo ejecutar el backend y el frontend

**Backend:**
```bash
cd Backend
python -m venv
pip install requeriments.txt
uvicorn app.main:app --reload --port 8000
```
Queda disponible en: `http://127.0.0.1:8000`

**Frontend:**
```bash
cd ..
cd frontend
python -m http.server 5500
```
Queda disponible en: `http://127.0.0.1:5500` o `http://localhost:5500`. Con Live Server de VS Code basta con abrir `frontend/index.html` y darle "Go Live" (también en el puerto 5500).

No abras `index.html` con doble clic (`file://`): el navegador bloquea las peticiones al backend por CORS.

## 7. Cómo probarlo desde un celular en la misma red

Para probarlo desde un celular (iPhone, Android) conectado a la **misma red WiFi** que la compu:

1. **Averigua la IP local de tu compu.** En Windows: `ipconfig` en una terminal, busca "Dirección IPv4" (algo como `192.168.1.23`). En Mac/Linux: `ifconfig` o `ip addr`.

2. **Corre el backend escuchando en toda la red, no solo en tu compu:**
   ```bash
   uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
   ```
   El `--host 0.0.0.0` es necesario: sin él, el backend por defecto solo acepta conexiones desde la propia compu (`127.0.0.1`) y el celular nunca va a poder llegar a él.

3. **Agrega la IP del celular^ a `CORS_ORIGINS` en tu `.env`** (misma IP del paso 1, puerto 5500 del frontend):
   ```
   CORS_ORIGINS=http://127.0.0.1:5500,http://localhost:5500,http://192.168.1.23:5500
   ```
   (^ en realidad es la IP de la compu vista desde el celular — el origen desde el que el navegador del celular va a pedir la página). Reinicia el backend después de cambiar el `.env`.

4. **Corre el frontend igual que en la sección 6** (`python -m http.server 5500` ya escucha en toda la red por defecto, no hace falta tocarle nada).

5. **En el celular**, abre el navegador (Safari en iPhone, Chrome en Android) y entra a:
   ```
   http://192.168.1.23:5500
   ```
   (la IP del paso 1, nunca `localhost`). `app.js` toma ese mismo host para hablar con el backend en el puerto 8000 — no hay que configurar nada más en el frontend.

**Limitación de HTTPS:** como se accede por `http://` y no por `localhost`, el navegador bloquea la cámara en vivo (`getUserMedia`) y la geolocalización por ser un origen no seguro. El sitio ya lo maneja solo, sin que el usuario note un error feo:
- Si la cámara en vivo no abre, cae automáticamente al selector de archivo con `capture="environment"`, que en el celular abre la cámara nativa del sistema (esa sí funciona por HTTP).
- Si "usar mi ubicación" falla, se puede poner el pin a mano tocando el mapa.

Para tener HTTPS real (y que la cámara/ubicación funcionen sin caer al respaldo) haría falta un túnel o certificado — ver sección 12 (Despliegue).

**Nota — idempotencia sin HTTPS:** `crypto.randomUUID()` tampoco existe en un origen no seguro. El frontend usa una función `generarUUID()` con respaldo (arma el UUID a mano si `crypto.randomUUID` no está disponible), así que registrar un perrito funciona igual por `http://` desde el celular.

## 8. Endpoints de la API

Base: `http://127.0.0.1:8000`. Con el backend corriendo, la documentación interactiva (Swagger) queda en `http://127.0.0.1:8000/docs`.

| Método | Ruta | Descripción | Respuestas |
| ------ | ---- | ----------- | ---------- |
| GET | `/health` | Comprueba que el backend está vivo | 200 `{"status": "ok"}` |
| GET | `/api/razas` | Nombres de las razas del catálogo (no incluye "Sin raza definida / criollo": en el formulario esa opción es el valor vacío) | 200 lista de strings |
| GET | `/api/colores` | Nombres de los colores del catálogo | 200 lista de strings |
| GET | `/api/perritos/` | Todos los perritos, del más reciente al más antiguo | 200 lista de perritos |
| GET | `/api/perritos/{id}` | Detalle de un perrito | 200 · 404 si no existe |
| POST | `/api/perritos/` | Registra un perrito (idempotente, ver abajo) | 200 · 400 · 422 |
| DELETE | `/api/perritos/{id}` | Elimina el perrito y sus colores asociados | 200 `{"ok": true}` · 404 |
| GET | `/api/imagenes/{nombre_archivo}` | Devuelve la foto guardada en `RUTA_IMAGENES` | 200 imagen · 404 |

Usa siempre la barra final en `/api/perritos/`: sin ella FastAPI responde con una redirección 307.

### POST `/api/perritos/`

Cuerpo (JSON):

```json
{
  "clave_idempotencia": "3f9c1c2e-6f0b-4c53-9d0a-2b6a8f6a1e11",
  "nombre": "Firulais",
  "raza": "Labrador Retriever",
  "colorPrincipal": "Canela",
  "coloresAdicionales": ["Blanco"],
  "latitud": 19.4326,
  "longitud": -99.1332,
  "foto": "data:image/jpeg;base64,/9j/4AAQSkZJRg..."
}
```

Respuesta (misma forma que devuelven los GET de perritos):

```json
{
  "id": 16,
  "nombre": "Firulais",
  "raza": "Labrador Retriever",
  "colorPrincipal": "Canela",
  "coloresAdicionales": ["Blanco"],
  "latitud": 19.4326,
  "longitud": -99.1332,
  "foto": "/api/imagenes/8f1d0c5a2b7e4c1f9a3d6e0b4c2a1f7d.jpg",
  "fecha_registro": "2026-09-28T14:30:00"
}
```

Reglas:

- `nombre` no puede ir vacío y `colorPrincipal` es obligatorio.
- `raza` es opcional: `null` se guarda como `NULL`. Si viene, debe existir en el catálogo.
- `coloresAdicionales` admite máximo 2 (3 colores en total) y no se puede repetir ningún color. Todos deben existir en el catálogo.
- `foto` es una data URL en base64 (`data:image/...;base64,...`). El backend la abre con Pillow para comprobar que de verdad es una imagen y solo acepta JPG, PNG y WEBP. Se guarda en `RUTA_IMAGENES` con un nombre generado con UUID.
- `latitud` y `longitud` deben estar en rango válido (latitud entre -90 y 90, longitud entre -180 y 180).
- **Idempotencia:** si llega una `clave_idempotencia` que ya existe, no se crea nada nuevo: se responde 200 con el mismo registro (mismo `id`).

Errores:

| Código | Cuándo pasa |
| ------ | ----------- |
| 400 | Raza o color que no está en el catálogo, color repetido, foto ausente, foto que no es una imagen válida o formato no soportado |
| 404 | Perrito o imagen inexistente |
| 422 | El cuerpo no cumple el esquema (nombre vacío, más de 2 colores adicionales, campos faltantes o de tipo incorrecto) |

## 9. Capturas de pantalla

<img width="1920" height="1080" alt="{CB8E83FA-5914-4D2D-8C04-CCB65AAC3F1E}" src="https://github.com/user-attachments/assets/e6b5b99f-40a8-48a4-a250-80cc36a93957" />
<img width="1920" height="1080" alt="{9F0A0612-3DDD-46BF-85CD-8CE94C2CFB46}" src="https://github.com/user-attachments/assets/b2edac4c-5fbc-450f-9bdd-606e61723c6e" />
<img width="1920" height="1080" alt="{7114D974-E4BB-4CB8-8FD7-6225EE23B173}" src="https://github.com/user-attachments/assets/3163a814-059a-4b36-b00c-cc1ae94fef9d" />
<img width="1920" height="1080" alt="{22FED340-1A8F-461E-8366-AB8DF30FC9C0}" src="https://github.com/user-attachments/assets/b2231804-b2bd-49b1-bd7b-4a4b85aba0d2" />
<img width="1920" height="1080" alt="{1E95F26C-5926-438A-8D26-4EC4C40FC02C}" src="https://github.com/user-attachments/assets/4246aba6-7c5d-4d4c-b3e4-95894b18733f" />

## 10. Problemas comunes y cómo resolverlos

| Problema | Solución |
| -------- | -------- |
| Error de conexión a la base de datos | Verificar que `DATABASE_URL` en `.env` tenga el usuario, contraseña, host y nombre de base correctos, y que MySQL esté corriendo |
| Falla al cargar los scripts `.sql` | Confirmar que se corrieron en orden: `01_schema.sql` → `02_catalogos.sql` → `03_datos_prueba.sql` |
| El frontend abre pero la lista/mapa se quedan vacíos y no registra nada | Revisa la consola del navegador: si dice error de CORS o de conexión, confirma que el backend esté corriendo y que `CORS_ORIGINS` en el `.env` del backend incluya el origen exacto (protocolo + host + puerto) desde donde abriste el frontend |
| Desde el celular no carga nada, aunque desde la compu sí | El backend debe correr con `--host 0.0.0.0` (no solo `127.0.0.1`) y el `.env` debe incluir la IP local de la compu en `CORS_ORIGINS` — ver sección 7 |
| La cámara en vivo o "usar mi ubicación" no funcionan desde el celular | Es normal si se accede por `http://` y no por `localhost`: el navegador exige HTTPS para esas dos APIs. El sitio cae solo al respaldo (cámara nativa / pin manual) — ver sección 7 |
| `ModuleNotFoundError: No module named 'app'` al correr `uvicorn` | Se está corriendo desde la carpeta equivocada. Entra a `Backend/` y ejecuta ahí `uvicorn app.main:app --reload --port 8000` |
| Error de SQLAlchemy al arrancar (`Could not parse rfc1738 URL`, `NoneType`…) | `DATABASE_URL` está vacía o no se está leyendo. Revisa que exista el archivo `.env` (copiado de `.env.example`) y que la variable tenga valor |
| `'cryptography' package is required for sha256_password or caching_sha2_password` | MySQL 8 usa ese método de autenticación y falta la librería. Corre `pip install -r requirements.txt` de nuevo |
| Las fotos de los perritos de prueba no se ven (404 en `/api/imagenes/...`) | `RUTA_IMAGENES` debe apuntar a una carpeta que contenga los archivos. Copia ahí el contenido de `Backend/images/` (las fotos `perro_01.jpg` … `perro_15.jpg`) |
| `POST /api/perritos` responde 307 o se pierde el cuerpo | La ruta está definida con barra final: usa `/api/perritos/` |
| Al registrar sale "La raza '…' no existe en el catálogo" o "Color(es) no encontrados" | Los nombres que manda el frontend deben ser idénticos a los de las tablas `raza` y `color`. Confirma que `02_catalogos.sql` se corrió y que las listas del frontend no se desfasaron del catálogo |
| Al registrar sale "El archivo no es una imagen válida" o "Formato no soportado" | Sube una foto JPG, PNG o WEBP real (no basta con renombrar la extensión: el backend la abre y la valida) |
| Error 422 al registrar | El cuerpo no cumple el esquema: nombre vacío, más de 2 colores adicionales o campos faltantes. El detalle viene en la respuesta y en `/docs` |
| `Address already in use` / el puerto 8000 está ocupado | Ya hay otro proceso en ese puerto. Ciérralo o arranca con otro puerto (`--port 8001`) y ajusta `API_BASE` y `CORS_ORIGINS` en consecuencia |

## 11. Paradigmas

**Declarativo (SQL):** el filtrado, ordenamiento y agregación de datos ocurre en SQL, no con ciclos. Ver `db/04_consultas.sql`: una consulta con JOIN (perrito + sus colores) y dos consultas de agregación (perritos por color, perritos por zona).

**Idempotencia del registro (diseño de base de datos):** la tabla `perrito` tiene la columna `clave_idempotencia` como `UNIQUE`. Esto permite que, si el mismo formulario se envía dos veces con la misma clave, la base rechace el segundo intento de insertar un registro duplicado.

**Idempotencia del registro (backend):** el código está en `Backend/app/routers/perritos.py`, función `registrar` (el `POST /api/perritos/`). Funciona en tres capas:

1. Antes de insertar, busca un perrito con la misma `clave_idempotencia`. Si existe, devuelve ese mismo registro (mismo `id`) sin crear nada ni guardar otra foto.
2. Si no existe, valida el cuerpo (raza, colores, foto) e inserta el perrito y sus filas de `perrito_color` en una sola transacción: `flush()` para obtener el `id`, luego los colores y al final `commit()`.
3. Si dos envíos idénticos llegan casi al mismo tiempo y la restricción `UNIQUE` de la base rechaza al segundo (`IntegrityError`), hace `rollback()` y devuelve el registro del que ganó la carrera, en vez de un error de duplicado.

**Dónde se genera la clave de idempotencia (frontend):** en `frontend/app.js`, la variable `claveIdempotencia` se llena con `generarUUID()` en cuanto carga la página, y se manda tal cual en el `POST` de cada intento de registro. `generarUUID()` usa `crypto.randomUUID()` cuando está disponible, y arma el UUID a mano si no (esa API no existe en orígenes no seguros, como al probar por `http://` desde el celular — ver sección 7). La clave solo se rota (se genera una nueva) después de que el registro se guarda con éxito — así, si el mismo formulario se reenvía por un doble tap o un reintento de conexión, viaja la misma clave y el backend lo detecta como el mismo intento.

**Enfoque funcional (frontend):** varias partes usan `.map()`/`.filter()` en vez de ciclos `for`, por ejemplo: la lista de nombres del ticker animado, los círculos de color de cada ficha de perrito y del detalle, y quitar un perrito de la lista local tras eliminarlo (`PERRITOS.filter(x => x.id !== currentDetailId)`).

**Enfoque funcional (backend):** `serializar()` en `Backend/app/routers/perritos.py` convierte un perrito de la base en el diccionario de respuesta sin modificar nada. Se apoya en comprensiones de listas en lugar de ciclos: `[serializar(p) for p in perritos]`, `[r.nombre for r in razas]` (en `catalogos.py`) y los colores adicionales (`[pc.color.nombre for pc in p.colores if not pc.es_principal]`). Los colores repetidos se detectan comparando `len(set(nombres))` contra `len(nombres)`.

**Orientado a objetos (backend):** los datos se modelan con clases. En `Backend/app/models.py`, `Raza`, `Color`, `Perrito` y `PerritoColor` son clases de SQLAlchemy mapeadas a las tablas, con relaciones (`relationship`) y borrado en cascada de los colores de un perrito. En `Backend/app/schemas.py`, `PerritoIn` es una clase de Pydantic que define la forma del cuerpo del `POST` y encapsula sus validaciones (`@field_validator`).

**Imperativo (backend):** el flujo paso a paso de `registrar` (buscar, validar, insertar, confirmar la transacción) y de `guardar_foto_base64` en `Backend/app/services/imagen.py` (decodificar el base64, verificar la imagen con Pillow, generar un nombre con UUID y escribir el archivo en disco) son secuencias de instrucciones con condicionales que modifican estado.

## 12. Despliegue (punto extra)

[PENDIENTE - si el equipo va por el punto extra: dónde correría cada pieza, HTTPS, variables de producción, puertos, respaldo, systemd + nginx/Caddy]
