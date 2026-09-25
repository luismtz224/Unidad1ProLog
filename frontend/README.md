# Frontend

Página web del proyecto "Registro de perritos de la calle". Se hizo solo con
HTML, CSS y JavaScript, sin frameworks ni pasos de compilación. El único
recurso externo es Leaflet (con mapas de OpenStreetMap), que se carga desde
internet.

## Archivos

| Archivo | Para qué sirve |
|---|---|
| `index.html` | La estructura de la página: las pestañas Registrar, Mapa y Lista, y la vista de detalle. |
| `style.css` | Los estilos, incluido el modo claro y oscuro. |
| `app.js` | Toda la lógica: formulario, validaciones, cámara, mapa y llamadas al backend. |

## Qué hace

- **Registrar:** formulario con nombre (obligatorio), foto (obligatoria, con la
  cámara o desde la galería), raza (opcional), de 1 a 3 colores sin repetir (el
  primero es el principal) y ubicación (obligatoria, tocando el mapa o con "usar
  mi ubicación").
- **Mapa:** todos los perritos registrados en un mapa.
- **Lista:** fichas de cada perrito y, al tocar una, su detalle, donde también se
  puede eliminar el registro.
- **Modo oscuro o claro:** se guarda la preferencia en el navegador.

## Cómo correrlo

El frontend necesita que estén corriendo, en este orden, la base de datos y el
backend (ver `Backend/README.md`). Luego:

1. Abre la carpeta `frontend/` con un servidor local en el **puerto 5500**.
   Con Live Server de VS Code basta con "Go Live". Sin VS Code:

   ```bash
   cd frontend
   python -m http.server 5500
   ```

2. Entra a `http://127.0.0.1:5500` o `http://localhost:5500`.

No abras `index.html` con doble clic (`file://`): el navegador bloquea las
peticiones al backend por CORS. El backend solo
acepta los orígenes que estén en `CORS_ORIGINS` de su `.env`, que por defecto son
los dos del puerto 5500.

## Conexión con el backend

La dirección del backend está en dos constantes al inicio de `app.js`:

```js
const API_BASE = "http://localhost:8000";
const API_URL = `${API_BASE}/api`;
```

Si el backend cambia de puerto o de máquina, es el único lugar que se modifica.
Las peticiones que usa el frontend son:

| Acción | Petición |
|---|---|
| Cargar la lista (al abrir y tras registrar) | `GET /api/perritos/` |
| Registrar un perrito | `POST /api/perritos/` |
| Eliminar un perrito | `DELETE /api/perritos/{id}` |
| Ver una foto | `GET /api/imagenes/{archivo}` |

El `POST` manda este objeto (los nombres coinciden con la base de datos):

```json
{
  "clave_idempotencia": "uuid generado al cargar el formulario",
  "nombre": "Canela",
  "raza": "Chihuahua",
  "colorPrincipal": "Café",
  "coloresAdicionales": ["Blanco"],
  "latitud": 25.4383,
  "longitud": -100.9737,
  "foto": "data:image/jpeg;base64,..."
}
```

`raza` es `null` si no se elige ninguna. El `id` y la fecha de registro los pone
la base de datos.

**Idempotencia:** cada vez que se carga el formulario se genera una
`clave_idempotencia` con `crypto.randomUUID()`. Si el usuario envía dos veces o
reintenta después de un error de conexión, se manda la misma clave y el backend
regresa el mismo registro en lugar de crear otro. La clave solo se cambia cuando
el registro se guarda con éxito.

## Catálogos

Las listas `RAZAS` y `COLORES` de `app.js` son una copia escrita a mano de las
tablas `raza` y `color` de la base de datos (`db/02_catalogos.sql`). Si se agrega
o cambia algo en la base, hay que actualizarlo también en `app.js`. Los colores
llevan además su código hex para dibujar los círculos, y eso solo existe en el
frontend.

## Enfoque funcional

El ticker de nombres y los círculos de color de cada ficha se generan con
`.map()` sobre los datos, en vez de ciclos `for`.
