# Registro de perritos de la calle

Proyecto 1 — Programación lógica y funcional.

## 1. Integrantes y roles

| Nombre | Rol |
|---|---|
| Luis Fernando Martínez Muñiz | Frontend |
| [Nombre] | Backend |
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
uvicorn app.main:app --reload --port 8000
```
Queda disponible en: `http://127.0.0.1:8000`

**Frontend:**
```bash
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

## 8. Endpoints de la API

[PENDIENTE - Backend: lista completa de endpoints]

## 9. Capturas de pantalla

[PENDIENTE - Frontend: agregar capturas reales del formulario, el mapa y la lista, ya con datos de prueba corriendo contra la base y el backend, antes de la entrega]

## 10. Problemas comunes y cómo resolverlos

| Problema | Solución |
|---|---|
| Error de conexión a la base de datos | Verificar que `DATABASE_URL` en `.env` tenga el usuario, contraseña, host y nombre de base correctos, y que MySQL esté corriendo |
| Falla al cargar los scripts `.sql` | Confirmar que se corrieron en orden: `01_schema.sql` → `02_catalogos.sql` → `03_datos_prueba.sql` |
| El frontend abre pero la lista/mapa se quedan vacíos y no registra nada | Revisa la consola del navegador: si dice error de CORS o de conexión, confirma que el backend esté corriendo y que `CORS_ORIGINS` en el `.env` del backend incluya el origen exacto (protocolo + host + puerto) desde donde abriste el frontend |
| Desde el celular no carga nada, aunque desde la compu sí | El backend debe correr con `--host 0.0.0.0` (no solo `127.0.0.1`) y el `.env` debe incluir la IP local del celular en `CORS_ORIGINS` — ver sección 7 |
| La cámara en vivo o "usar mi ubicación" no funcionan desde el celular | Es normal si se accede por `http://` y no por `localhost`: el navegador exige HTTPS para esas dos APIs. El sitio cae solo al respaldo (cámara nativa / pin manual) — ver sección 7 |

[PENDIENTE - Backend: agregar sus propios casos comunes]

## 11. Paradigmas

**Declarativo (SQL):** el filtrado, ordenamiento y agregación de datos ocurre en SQL, no con ciclos. Ver `db/04_consultas.sql`: una consulta con JOIN (perrito + sus colores) y dos consultas de agregación (perritos por color, perritos por zona).

**Idempotencia del registro (diseño de base de datos):** la tabla `perrito` tiene la columna `clave_idempotencia` como `UNIQUE`. Esto permite que, si el mismo formulario se envía dos veces con la misma clave, la base rechace el segundo intento de insertar un registro duplicado.

[PENDIENTE - Backend: explicar cómo usa esa clave antes de insertar (dónde está ese código, qué hace exactamente)]

**Dónde se genera la clave de idempotencia (frontend):** en `frontend/app.js`, la variable `claveIdempotencia` se llena con `crypto.randomUUID()` en cuanto carga la página, y se manda tal cual en el `POST` de cada intento de registro. Solo se rota (se genera una nueva) después de que el registro se guarda con éxito — así, si el mismo formulario se reenvía por un doble tap o un reintento de conexión, viaja la misma clave y el backend lo detecta como el mismo intento.

**Enfoque funcional (frontend):** varias partes usan `.map()`/`.filter()` en vez de ciclos `for`, por ejemplo: la lista de nombres del ticker animado, los círculos de color de cada ficha de perrito y del detalle, y quitar un perrito de la lista local tras eliminarlo (`PERRITOS.filter(x => x.id !== currentDetailId)`).

[PENDIENTE - Backend: identificar los demás paradigmas usados (orientado a objetos, imperativo) y dónde está ese código]

## 12. Despliegue (punto extra)

[PENDIENTE - si el equipo va por el punto extra: dónde correría cada pieza, HTTPS, variables de producción, puertos, respaldo, systemd + nginx/Caddy]