# Base de datos

Modelo de datos del proyecto "Registro de perritos de la calle". Se hizo con
MySQL puro, en scripts `.sql` planos, sin ORM ni migraciones automáticas: la
estructura la define este esquema, y el backend solo se conecta a las tablas
que ya existen (no las genera él).

## Archivos

| Archivo | Para qué sirve |
|---|---|
| `01_schema.sql` | Crea la base `perritos_calle` y las 4 tablas, con sus llaves foráneas. |
| `02_catalogos.sql` | Carga el catálogo: 11 razas (incluye "Sin raza definida / criollo") y 10 colores. |
| `03_datos_prueba.sql` | Inserta 15 perritos de prueba, con ubicación real, foto y de 1 a 3 colores cada uno. |
| `04_consultas.sql` | Consultas de referencia: JOIN (perrito + colores), dos agregaciones, e idempotencia. |
| `backup.sh` / `restore.sh` | Respaldo y restauración de la base y de la carpeta de imágenes. |
| `ER_diagrama.png` / `ER_diagrama_mermaid.png` | Diagrama entidad-relación. |
| `fotos_prueba/` | 15 fotos reales de perros, con licencia libre, para los datos de prueba. |

## Qué hace

- **`raza` y `color`:** catálogos independientes, cada uno con `id` y `nombre`.
- **`perrito`:** un registro por perrito — nombre, raza (opcional), nombre del
  archivo de foto, ubicación (latitud/longitud), fecha de registro automática, y
  `clave_idempotencia`.
- **`perrito_color`:** tabla puente entre `perrito` y `color`, de 1 a 3 filas por
  perrito, marcando cuál es el color principal (`es_principal`). Su llave
  primaria compuesta `(perrito_id, color_id)` evita que se repita un color.

## Cómo correrlo

```bash
mysql -u root -p < db/01_schema.sql
mysql -u root -p < db/02_catalogos.sql
mysql -u root -p < db/03_datos_prueba.sql
```

(Opcional, recomendado) Usuario de aplicación en vez de `root`:
```sql
CREATE USER 'perritos_app'@'%' IDENTIFIED BY 'una_contraseña_fuerte';
GRANT SELECT, INSERT, UPDATE, DELETE ON perritos_calle.* TO 'perritos_app'@'%';
FLUSH PRIVILEGES;
```

## Conexión con el backend

El backend se conecta con la variable `DATABASE_URL` de su `.env`:

```
DATABASE_URL=mysql+pymysql://perritos_app:contraseña@localhost:3306/perritos_calle
```

Los nombres de tabla y columna en `models.py` (backend) coinciden exactamente
con este esquema — si algo cambia aquí, hay que avisar para que se actualice
allá también.

## Catálogos

Las razas y colores de `02_catalogos.sql` son la fuente real. El frontend
mantiene una copia escrita a mano en `app.js` (`RAZAS`, `COLORES`) — si se
agrega o cambia algo aquí, hay que avisar para que también se actualice ahí.

## Idempotencia

La columna `clave_idempotencia` en `perrito` es `UNIQUE`. El frontend genera
esa clave con `crypto.randomUUID()` al cargar el formulario; el backend, antes
de insertar, busca si ya existe un perrito con esa clave (consulta 4 en
`04_consultas.sql`) y si existe regresa ese mismo registro en vez de crear uno
nuevo. Así, un doble envío o un reintento de conexión no genera un perrito
duplicado.

## Enfoque declarativo

El filtrado, ordenamiento y las agregaciones (perritos por color, por zona)
se resuelven en SQL, no con ciclos. Ver `04_consultas.sql`: la consulta con
JOIN, y las dos de agregación.

## Reglas que valida el backend, no la base

Máximo 3 colores por perrito y exactamente un color principal **no** están
forzados a nivel de base de datos — se validan del lado del servidor. Lo que
sí garantiza la base por sí sola: que no se repita un color (llave primaria
compuesta), que no haya perritos duplicados (`UNIQUE` en la clave de
idempotencia), y que no se asigne una raza o color fuera del catálogo (llaves
foráneas).
