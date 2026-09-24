USE perritos_calle;

-- Perrito 1: Firulais
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Firulais', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_01.jpg', 25.4483, -100.9937, '38dc689d-a721-461a-8c64-b6f82931c0aa');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Perrito 2: Toby
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Toby', (SELECT id FROM raza WHERE nombre = 'Labrador Retriever'), 'perro_02.jpg', 25.4233, -100.9437, '563899e5-9e15-4877-bd83-fcf79636925b');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);

-- Perrito 3: Luna
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Luna', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_03.jpg', 25.4633, -100.9637, 'f9c93b71-7f00-45e5-8360-8ed5c890d9c3');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), FALSE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Perrito 4: Rocky
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Rocky', (SELECT id FROM raza WHERE nombre = 'Pitbull / Terrier americano'), 'perro_04.jpg', 25.4083, -100.9837, '9fef29d0-a5a6-4e3b-be27-3e2ea3d3a68e');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Atigrado'), TRUE);

-- Perrito 5: Manchas
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Manchas', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_05.jpg', 25.4433, -100.9287, 'd28d8f24-23eb-410c-9d16-d71646508435');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Manchado'), FALSE);

-- Perrito 6: Canela
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Canela', (SELECT id FROM raza WHERE nombre = 'Chihuahua'), 'perro_06.jpg', 25.4183, -100.9587, '04788a68-b791-4b3b-be97-3499f1dc016f');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Canela'), TRUE);

-- Perrito 7: Bruno
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Bruno', (SELECT id FROM raza WHERE nombre = 'Pastor Alemán'), 'perro_07.jpg', 25.4783, -101.0037, '5388fa23-00bc-4388-8a61-0a27f66621b8');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Perrito 8: Nala
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Nala', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_08.jpg', 25.4303, -101.0137, '4cbbbd1d-dba8-49ff-9753-1c98906f6396');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Gris'), TRUE);

-- Perrito 9: Max
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Max', (SELECT id FROM raza WHERE nombre = 'Schnauzer'), 'perro_09.jpg', 25.4563, -100.9687, '7aa33c91-3574-4bae-9825-45a548f9a12b');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Gris'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Perrito 10: Pelusa
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Pelusa', (SELECT id FROM raza WHERE nombre = 'Poodle / Caniche'), 'perro_10.jpg', 25.4263, -100.9517, 'e993f385-eeda-4ff8-8a8f-7eff1d4aed6c');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Crema'), TRUE);

-- Perrito 11: Sombra
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Sombra', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_11.jpg', 25.4703, -100.9557, '683aa007-51dd-4cd3-b1d5-f8491912180e');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);

-- Perrito 12: Kiara
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Kiara', (SELECT id FROM raza WHERE nombre = 'Husky Siberiano'), 'perro_12.jpg', 25.4133, -100.9957, '06ca3a1b-a9fe-496c-b746-53120d477abf');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Gris'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), FALSE);

-- Perrito 13: Duque
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Duque', (SELECT id FROM raza WHERE nombre = 'Xoloitzcuintle'), 'perro_13.jpg', 25.4403, -100.9857, '181167f8-93b5-4960-b9e5-9dddd797561b');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Perrito 14: Rex
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Rex', (SELECT id FROM raza WHERE nombre = 'Border Collie'), 'perro_14.jpg', 25.4033, -100.9657, '1c2d685e-d9ef-470f-8e33-13e933e19993');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Perrito 15: Coco
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, clave_idempotencia) VALUES ('Coco', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_15.jpg', 25.4533, -101.0087, '027a9d60-1bcf-4e5d-af3e-8155272d5114');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Rojizo'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);
