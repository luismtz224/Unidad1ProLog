USE perritos_calle;

-- ------------------------------------------------------------
-- 1) JOIN: cada perrito con su raza y la lista de sus colores
-- ------------------------------------------------------------
SELECT
    p.id,
    p.nombre,
    COALESCE(r.nombre, 'Sin raza definida / criollo') AS raza,
    MAX(CASE WHEN pc.es_principal THEN c.nombre END)   AS color_principal,
    GROUP_CONCAT(
        CASE WHEN NOT pc.es_principal THEN c.nombre END
        SEPARATOR ', '
    ) AS colores_adicionales,
    p.latitud,
    p.longitud,
    p.fecha_registro
FROM perrito p
LEFT JOIN raza r          ON r.id = p.raza_id
JOIN perrito_color pc     ON pc.perrito_id = p.id
JOIN color c              ON c.id = pc.color_id
GROUP BY p.id, p.nombre, r.nombre, p.latitud, p.longitud, p.fecha_registro
ORDER BY p.fecha_registro DESC;

-- ------------------------------------------------------------
-- 2) Agregación: cuántos perritos hay registrados por color.
-- ------------------------------------------------------------
SELECT
    c.nombre        AS color,
    COUNT(*)        AS total_perritos
FROM perrito_color pc
JOIN color c ON c.id = pc.color_id
GROUP BY c.nombre
ORDER BY total_perritos DESC;

-- ------------------------------------------------------------
-- 3) Agregación: cuántos perritos hay por zona aproximada
-- ------------------------------------------------------------
SELECT
    ROUND(latitud, 2)  AS zona_lat,
    ROUND(longitud, 2) AS zona_lng,
    COUNT(*)           AS total_perritos
FROM perrito
GROUP BY zona_lat, zona_lng
ORDER BY total_perritos DESC;

-- ------------------------------------------------------------
-- 4) Ejemplo de idempotencia: el backend debe correr esto
--    ANTES de insertar. Si ya existe un perrito con esa clave,
--    devuelve el registro existente y no inserta nada nuevo.

-- SELECT id, nombre, fecha_registro
-- FROM perrito
-- WHERE clave_idempotencia = ?;