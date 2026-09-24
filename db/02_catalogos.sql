-- ============================================================
-- 02_seed_catalogos.sql
-- Catálogos base: razas y colores.
-- ============================================================
USE perritos_calle;

INSERT INTO raza (nombre) VALUES
    ('Sin raza definida / criollo'),
    ('Labrador Retriever'),
    ('Pastor Alemán'),
    ('Chihuahua'),
    ('Xoloitzcuintle'),
    ('Schnauzer'),
    ('Pitbull / Terrier americano'),
    ('Husky Siberiano'),
    ('Salchicha (Dachshund)'),
    ('Poodle / Caniche'),
    ('Border Collie');

INSERT INTO color (nombre) VALUES
    ('Negro'),
    ('Blanco'),
    ('Café'),
    ('Dorado'),
    ('Gris'),
    ('Atigrado'),
    ('Manchado'),
    ('Crema'),
    ('Rojizo'),
    ('Canela');
