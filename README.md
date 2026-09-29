# Registro de perritos de la calle

Proyecto 1 — Programación lógica y funcional.

## 1. Integrantes y roles

| Nombre | Rol |
|---|---|
| Luis Fernando Martínez Muñiz | Frontend |
| Ángel Imanol Velázquez Hernández | Backend |
| Sofía Cortés | DBA |

## 2. Requisitos previos

Necesitas instalar 3 cosas **antes** de tocar el proyecto. Si ya las tienes, salta a la sección 3.

| Herramienta | Versión | Cómo comprobar que ya la tienes |
|---|---|---|
| Git | cualquiera | `git --version` |
| Python | 3.14.x | `python --version` (en Linux/Mac suele ser `python3 --version`) |
| MySQL Server | 8.0 o más nuevo | `mysql --version` |

Además, un navegador moderno (Chrome, Firefox, Safari). El frontend es HTML/CSS/JS plano: no necesita instalar nada más.

> **Ojo:** el proyecto usa **MySQL**, no PostgreSQL. Si ya tienes PostgreSQL instalado no sirve, hay que instalar MySQL aparte.

### 2.1 Instalar Python

- **Windows:** descarga el instalador desde https://www.python.org/downloads/. En la **primera pantalla** del instalador marca la casilla **"Add python.exe to PATH"** antes de darle "Install Now". Si se te pasó, vuelve a correr el instalador, elige "Modify" y márcala.
- **Linux (Ubuntu/Debian):** `sudo apt install python3 python3-venv python3-pip`

Cierra y vuelve a abrir la terminal y comprueba con `python --version`. Debe salir `Python 3.14.x`.

### 2.2 Instalar MySQL

**Windows:**

1. Descarga **MySQL Installer** desde https://dev.mysql.com/downloads/installer/.
2. En el instalador elige **"Server only"** (solo el servidor) y ve dando "Next".
3. Cuando te pida la **contraseña de `root`**, escribe una que **no vayas a olvidar y anótala**: la vas a usar en la sección 4. Para un proyecto de clase puedes usar algo simple como `root1234`.
4. Deja marcada la opción de iniciar MySQL como servicio de Windows y termina la instalación.

**Windows — agregar `mysql` al PATH (paso que casi siempre falta):** el instalador **no** lo hace solo. Sin esto, CMD y Git Bash responden `'mysql' no se reconoce como un comando`.

1. Busca en la carpeta `C:\Program Files\MySQL\MySQL Server 8.0\bin` (si instalaste otra versión, el número cambia: 8.4, 9.0…). Debe contener un archivo `mysql.exe`. Copia esa ruta.
2. Presiona la tecla Windows y escribe **"Editar las variables de entorno del sistema"**, ábrelo.
3. Botón **"Variables de entorno…"**.
4. En la lista de arriba (variables de usuario) selecciona **`Path`** → **"Editar…"** → **"Nuevo"** → pega la ruta → **Aceptar** en todas las ventanas.
5. **Cierra todas las terminales y abre una nueva** (si no, no toma el cambio).
6. Comprueba: `mysql --version`. Debe salir algo como `mysql  Ver 8.0.xx`.

**Linux (Ubuntu/Debian):**

```bash
sudo apt install mysql-server
sudo systemctl start mysql
mysql --version
```

En Linux, `root` de MySQL normalmente entra con `sudo`: en la sección 4, donde dice `mysql -u root -p`, usa `sudo mysql` (no pedirá contraseña).

**Mac:** `brew install mysql` y luego `brew services start mysql`.

## 3. Antes de empezar: cómo usar esta guía

- **Terminal:** en **Windows** usa **CMD** o **Git Bash** (no PowerShell: algunos comandos cambian). En Linux/Mac usa la terminal normal.
- **Corre los comandos UNO POR UNO.** No copies y pegues todo el bloque de golpe: varios pasos dependen de que hayas escrito algo antes (por ejemplo, editar el `.env`). Copia una línea, pégala, dale Enter, mira que no haya error y hasta entonces sigue con la siguiente.
- **Los comandos que cambian según el sistema** vienen separados en **Windows (CMD)**, **Windows (Git Bash)** y **Linux / Mac**. Usa solo el tuyo.
- Los ✅ dicen **qué debes ver** si el paso salió bien. Si no lo ves, no sigas: ve a la sección 10.
- Vas a necesitar **dos terminales abiertas al mismo tiempo** al final (una para el backend y otra para el frontend).

**Mapa de la instalación:**

1. Clonar el repositorio (esta sección)
2. Crear la base de datos (sección 4)
3. Configurar el `.env` y la carpeta de fotos (sección 5)
4. Instalar y correr el backend, luego el frontend (sección 6)

### Paso 1: Clonar el repositorio

Abre la terminal en la carpeta donde quieras guardar el proyecto (por ejemplo, Documentos) y corre:

```bash
git clone https://github.com/luismtz224/Unidad1ProLog.git
```
```bash
cd Unidad1ProLog
```

✅ Debes ver que la ruta de la terminal termina en `Unidad1ProLog`. **Esta carpeta es "la raíz del proyecto"**: todos los comandos de las secciones 4 y 5 se corren desde aquí. Si abres otra terminal más adelante, vuelve a entrar con `cd` a esta carpeta.

## 4. Creación de la base de datos y carga de datos

Todo esto vive en la carpeta `db/`. Corre los comandos **desde la raíz del proyecto** y **en este orden**. Cada uno te pide la contraseña de `root` (la que pusiste al instalar MySQL; al escribirla no se ve nada, es normal).

### Paso 2: Crear la base, las tablas y los datos de prueba

**Windows (CMD):**
```bat
mysql -u root -p < db\01_schema.sql
```
```bat
mysql -u root -p < db\02_catalogos.sql
```
```bat
mysql -u root -p < db\03_datos_prueba.sql
```

**Windows (Git Bash) / Linux / Mac:**
```bash
mysql -u root -p < db/01_schema.sql
```
```bash
mysql -u root -p < db/02_catalogos.sql
```
```bash
mysql -u root -p < db/03_datos_prueba.sql
```
(En Linux, si `root` no deja entrar con contraseña, usa `sudo mysql < db/01_schema.sql` y así con los otros dos.)

✅ Si todo salió bien, **no imprime nada** y regresa al cursor. Si algo falla, MySQL lo avisa con un mensaje `ERROR`. Esto crea la base `perritos_calle`, sus 4 tablas (`raza`, `color`, `perrito`, `perrito_color`), carga el catálogo (11 razas, 10 colores) y 15 perritos de prueba con foto.

### Paso 3: Crear el usuario de la aplicación (obligatorio)

El backend no entra a la base como `root`, entra con un usuario propio llamado `perritos_app` (es el que trae el `.env.example`). **Sin este paso el backend no puede conectarse.**

Entra a MySQL (te pide la contraseña de `root`):

```bash
mysql -u root -p
```

Cuando el prompt cambie a `mysql>`, pega **estas líneas una por una** (cada una termina en `;` y con Enter se ejecuta). Cambia `perritos123` por la contraseña que quieras, pero **usa solo letras y números** (nada de `@`, `:`, `/`, `#`, `%`, espacios): esos símbolos rompen la `DATABASE_URL` del `.env`.

```sql
CREATE USER 'perritos_app'@'localhost' IDENTIFIED BY 'perritos123';
```
```sql
GRANT SELECT, INSERT, UPDATE, DELETE ON perritos_calle.* TO 'perritos_app'@'localhost';
```
```sql
FLUSH PRIVILEGES;
```
```sql
exit
```

✅ Cada línea responde `Query OK`. **Anota la contraseña que elegiste**: la necesitas en la sección 5.

### Paso 4: Comprobar que la base quedó bien

```bash
mysql -u perritos_app -p -e "SELECT COUNT(*) FROM perritos_calle.perrito;"
```

Escribe la contraseña de `perritos_app` (`perritos123` si no la cambiaste).

✅ Debe mostrar un `15`. Si sale `Access denied`, la contraseña o el usuario están mal: repite el paso 3.

## 5. Configuración (variables de entorno y carpeta de fotos)

Todo desde la **raíz del proyecto**.

### Paso 5: Crear tu archivo `.env`

El repositorio trae `.env.example`, que es una plantilla. Tu copia se llama `.env` y va **en la raíz del proyecto, al lado de `.env.example`** (no dentro de `Backend/`).

**Windows (CMD):**
```bat
copy .env.example .env
```

**Windows (Git Bash) / Linux / Mac:**
```bash
cp .env.example .env
```

✅ Si haces `dir` (CMD) o `ls -a` (Git Bash/Linux), deben aparecer `.env` y `.env.example`.

### Paso 6: Crear la carpeta de fotos y copiar las fotos de prueba

Las fotos de los perritos **no se guardan dentro del repositorio**: viven en una carpeta tuya, y el backend las lee de ahí. Los 15 perritos de prueba ya traen su foto asignada, así que hay que crear esa carpeta y copiar las fotos que vienen en `Backend/images/`. **Si te saltas este paso, la lista sale pero las fotos no cargan.**

Elige dónde quieres la carpeta. Estas rutas son solo ejemplo; puede ser cualquier otra **fuera** del repositorio:

**Windows (CMD):**
```bat
mkdir C:\perritos_imagenes
```
```bat
copy Backend\images\* C:\perritos_imagenes\
```

**Windows (Git Bash):**
```bash
mkdir /c/perritos_imagenes
```
```bash
cp Backend/images/* /c/perritos_imagenes/
```

**Linux / Mac:**
```bash
mkdir -p ~/perritos_imagenes
```
```bash
cp Backend/images/* ~/perritos_imagenes/
```

✅ Debe haber 19 archivos `.jpg` en esa carpeta (`perro_01.jpg` … `perro_15.jpg` y 4 más con nombres largos). Comprueba con `dir C:\perritos_imagenes` (CMD) o `ls ~/perritos_imagenes` (Linux/Mac).

Además crea una carpeta para respaldos (solo la usa `db/backup.sh`; el proyecto corre sin ella, pero la variable debe tener algún valor):

**Windows:** `mkdir C:\perritos_respaldos`  
**Linux / Mac:** `mkdir -p ~/perritos_respaldos`

### Paso 7: Llenar el `.env`

Abre el `.env` con un editor de texto. Desde la terminal:

**Windows (CMD o Git Bash):** `notepad .env`  
**Linux:** `nano .env` (guardas con `Ctrl+O`, Enter, y sales con `Ctrl+X`)

Deja **solo estas 4 líneas** (borra o ignora las que empiezan con `#`) y cambia lo que dice **← cambia esto**:

**Windows** (usa `/` en las rutas, **no** `\`, aunque estemos en Windows):
```
DATABASE_URL=mysql+pymysql://perritos_app:perritos123@localhost:3306/perritos_calle
RUTA_IMAGENES=C:/perritos_imagenes
RUTA_RESPALDOS=C:/perritos_respaldos
CORS_ORIGINS=http://127.0.0.1:5500,http://localhost:5500
```

**Linux / Mac** (pon tu usuario real en lugar de `tuusuario`; `~` no funciona dentro del `.env`):
```
DATABASE_URL=mysql+pymysql://perritos_app:perritos123@localhost:3306/perritos_calle
RUTA_IMAGENES=/home/tuusuario/perritos_imagenes
RUTA_RESPALDOS=/home/tuusuario/perritos_respaldos
CORS_ORIGINS=http://127.0.0.1:5500,http://localhost:5500
```

Qué es cada línea:

| Variable | Qué poner |
|---|---|
| `DATABASE_URL` | El usuario y la contraseña del **paso 3**. La forma es `mysql+pymysql://USUARIO:CONTRASEÑA@localhost:3306/perritos_calle`. **← cambia `perritos123` si elegiste otra contraseña.** |
| `RUTA_IMAGENES` | La carpeta que creaste en el **paso 6**. Tiene que ser exactamente esa. |
| `RUTA_RESPALDOS` | La carpeta de respaldos del paso 6. |
| `CORS_ORIGINS` | Déjala tal cual. Son las direcciones desde donde el frontend puede hablar con el backend. Solo se cambia para probar desde el celular (sección 7). |

Guarda el archivo y **ciérralo**. El frontend no usa variables de entorno propias: la dirección del backend (`API_BASE` en `app.js`) se arma sola a partir del host desde el que se abrió la página, así que no hay nada que configurar a mano ni siquiera para probarlo desde el celular (ver sección 7).

✅ Revisa que no haya espacios alrededor del `=` y que la contraseña sea la misma del paso 3.

## 6. Cómo ejecutar el backend y el frontend

Aquí ya necesitas **dos terminales**. La primera queda ocupada con el backend, por eso el frontend va en otra.

### Terminal 1: el backend

**Paso 8: entrar a la carpeta del backend y crear el entorno virtual.** El entorno virtual (`venv`) es una carpeta donde se instalan las librerías de Python solo para este proyecto. Se crea **una sola vez**.

```bash
cd Backend
```
```bash
python -m venv venv
```
(En Linux/Mac, si `python` no existe, usa `python3 -m venv venv`.)

✅ Aparece una carpeta nueva `venv` dentro de `Backend`.

**Paso 9: activar el entorno virtual.** Esto se hace **cada vez que abras una terminal nueva** para correr el backend.

**Windows (CMD):**
```bat
venv\Scripts\activate
```

**Windows (Git Bash):**
```bash
source venv/Scripts/activate
```

**Linux / Mac:**
```bash
source venv/bin/activate
```

✅ Al inicio de la línea de la terminal aparece `(venv)`. Si no aparece, no está activado.

**Paso 10: instalar las librerías** (solo la primera vez; tarda un par de minutos):

```bash
pip install -r requirements.txt
```

✅ Termina con `Successfully installed …` y sin la palabra `ERROR` en rojo.

**Paso 11: arrancar el backend.**

```bash
uvicorn app.main:app --reload --port 8000
```

✅ Debe salir `Uvicorn running on http://127.0.0.1:8000` y **la terminal se queda ocupada: es normal, no la cierres.** Para apagarlo después: `Ctrl+C`.

Comprobación: abre en el navegador `http://127.0.0.1:8000/health`. Debe mostrar `{"status":"ok"}`. Con `http://127.0.0.1:8000/api/perritos/` deben salir los 15 perritos de prueba.

> Si al arrancar sale un error largo que menciona `DATABASE_URL`, `Could not parse rfc1738 URL` o `Access denied`, revisa el `.env` (paso 7) y la contraseña del usuario `perritos_app` (paso 3). Detalles en la sección 10.

### Terminal 2: el frontend

Abre **otra terminal nueva** (deja la del backend corriendo). Esta empieza en cualquier carpeta, así que primero entra a la raíz del proyecto con `cd` (por ejemplo `cd Documentos\Unidad1ProLog` o donde lo hayas clonado).

**Paso 12: entrar a la carpeta del frontend y servirlo.**

```bash
cd frontend
```
```bash
python -m http.server 5500
```
(En Linux/Mac, si `python` no existe, usa `python3 -m http.server 5500`.)

✅ Debe salir `Serving HTTP on … port 5500`. Esta terminal también se queda ocupada.

**Paso 13: abrir la página.** En el navegador entra a:

```
http://127.0.0.1:5500
```
(o `http://localhost:5500`). Con Live Server de VS Code también sirve: abre `frontend/index.html` y dale "Go Live" (usa el mismo puerto 5500).

✅ **Debes ver el mapa y los 15 perritos con su foto.** Si la lista sale vacía, revisa que el backend siga corriendo. Si salen los perritos pero sin foto, revisa el paso 6 y que `RUTA_IMAGENES` del `.env` sea esa misma carpeta (después de cambiar el `.env` hay que apagar el backend con `Ctrl+C` y volver a correr el paso 11).

No abras `index.html` con doble clic (`file://`): el navegador bloquea las peticiones al backend por CORS.

**La próxima vez que quieras usarlo** ya no repites la instalación: solo abres 2 terminales. En la primera haces `cd Backend`, activas el venv (paso 9) y corres el paso 11. En la segunda haces `cd frontend` y corres el paso 12.

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
