-- ============================================================
-- 05_datos_muestra.sql  (GENERADO por db/generar_datos_muestra.py)
-- 120 avistamientos de muestra para el Proyecto 2.
-- No editar a mano: modifica el generador y vuelve a generarlo.
-- ============================================================
USE perritos_calle;

-- Muestra 1: Rocko
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Rocko', (SELECT id FROM raza WHERE nombre = 'Xoloitzcuintle'), 'perro_01.jpg', 25.4296701, -100.9975797, '2026-08-22 12:36:00', '0f0eec61-7faf-57ee-9f2d-25cff8282a29');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);

-- Muestra 2: Papelito
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Papelito', NULL, 'perro_02.jpg', 25.4330010, -100.9982181, '2026-08-26 16:24:00', '557ebc79-2897-587a-86ea-1b893af2502b');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 3: Cactus
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Cactus', (SELECT id FROM raza WHERE nombre = 'Poodle / Caniche'), 'perro_10.jpg', 25.4544399, -100.9854703, '2026-08-27 14:02:00', '8b742fb1-d378-517f-8dae-808d9be3356e');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Crema'), TRUE);

-- Muestra 4: Pelos
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Pelos', (SELECT id FROM raza WHERE nombre = 'Pastor Alemán'), 'perro_04.jpg', 25.5415714, -100.9513433, '2026-08-27 15:50:00', 'd93b79d0-e15a-549a-9049-28c47dd00bb2');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);

-- Muestra 5: Taco
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Taco', NULL, 'perro_05.jpg', 25.4304964, -100.9936616, '2026-08-28 14:12:00', '855c036f-8fc5-5d4f-af8b-6707b4eec184');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 6: Zorro
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Zorro', NULL, 'perro_12.jpg', 25.4238848, -100.9928354, '2026-08-29 13:45:00', 'e7050570-cc5e-5519-921d-6aa189d5b60c');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 7: Elote
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Elote', (SELECT id FROM raza WHERE nombre = 'Salchicha (Dachshund)'), 'perro_13.jpg', 25.5390365, -100.9566341, '2026-08-30 11:10:00', '0939b688-d593-5540-813a-8d2426b23486');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);

-- Muestra 8: Manchitas
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Manchitas', (SELECT id FROM raza WHERE nombre = 'Salchicha (Dachshund)'), 'perro_13.jpg', 25.5395444, -100.9567565, '2026-09-04 17:10:00', 'ea4902df-09de-5c50-a0db-bd4def19ae12');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);

-- Muestra 9: Flaca
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Flaca', (SELECT id FROM raza WHERE nombre = 'Pastor Alemán'), 'perro_07.jpg', 25.3542758, -101.0292980, '2026-09-04 17:56:00', 'b152ed91-079e-56a1-8e4e-4bccff98b518');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 10: Lija
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Lija', NULL, 'perro_14.jpg', 25.4236864, -100.9933981, '2026-09-05 16:02:00', 'f87568ad-d66e-5599-af03-fb8319a0a91c');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 11: Canica
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Canica', NULL, 'perro_08.jpg', 25.5419906, -100.9575938, '2026-09-07 12:36:00', '46a841f7-0d5d-5176-9975-d5944321791b');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Rojizo'), TRUE);

-- Muestra 12: Firu
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Firu', NULL, 'perro_04.jpg', 25.4299874, -100.9971883, '2026-09-08 10:57:00', '47307c6c-1bf1-5467-8b40-421a55704736');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Gris'), TRUE);

-- Muestra 13: Orejas
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Orejas', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_07.jpg', 25.4235770, -100.9949112, '2026-09-08 12:25:00', '79669e7d-cb56-5134-bc5b-9b30849db1a9');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 14: Borrador
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Borrador', NULL, 'perro_14.jpg', 25.3496742, -101.0276890, '2026-09-09 14:08:00', '237e0176-3304-569c-b95a-8194131623f8');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 15: Mezquite
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Mezquite', NULL, 'perro_05.jpg', 25.5472863, -100.9463700, '2026-09-10 16:56:00', 'eb3d3f15-51b9-5fa2-90ac-9c9854e5d774');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);

-- Muestra 16: Gaspar
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Gaspar', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_13.jpg', 25.4301869, -100.9934580, '2026-09-10 17:00:00', '24bbba89-c6e1-50db-a3bf-f2fb66155aa5');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), FALSE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 17: Mostaza
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Mostaza', (SELECT id FROM raza WHERE nombre = 'Pitbull / Terrier americano'), 'perro_10.jpg', 25.3604469, -101.0330393, '2026-09-10 19:30:00', '35038235-7ed5-5dcc-9c70-e9fb32783302');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 18: Fiera
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Fiera', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_11.jpg', 25.4223853, -100.9912641, '2026-09-11 11:50:00', '7c933634-aa82-5cf1-829c-dbf3ec34dcae');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Muestra 19: Cometa
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Cometa', (SELECT id FROM raza WHERE nombre = 'Pitbull / Terrier americano'), 'perro_06.jpg', 25.4242711, -100.9923226, '2026-09-11 18:03:00', '15f0cfa1-ed37-5d80-a15c-e1a5fae6dc35');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 20: Tamal
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Tamal', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_14.jpg', 25.4199322, -100.9929241, '2026-09-12 09:34:00', '169035dd-c130-53ea-addd-90595473b8bb');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), FALSE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Muestra 21: Brocha
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Brocha', (SELECT id FROM raza WHERE nombre = 'Xoloitzcuintle'), 'perro_14.jpg', 25.4239354, -100.9946718, '2026-09-12 14:21:00', '5c36a089-89c7-5267-bf0f-91e744c8a6b1');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Crema'), TRUE);

-- Muestra 22: Lupe
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Lupe', NULL, 'perro_11.jpg', 25.4556557, -100.9852691, '2026-09-13 17:21:00', '67b4bfca-5e0c-5ee1-b5b4-341cd0c53404');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 23: Pinta
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Pinta', (SELECT id FROM raza WHERE nombre = 'Border Collie'), 'perro_06.jpg', 25.4238562, -100.9930883, '2026-09-14 12:58:00', 'ff7917dc-2995-59c6-a892-ccce2a4fff07');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Gris'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 24: Estrella
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Estrella', (SELECT id FROM raza WHERE nombre = 'Poodle / Caniche'), 'perro_08.jpg', 25.4317646, -100.9946187, '2026-09-14 15:17:00', 'd8351d71-fd9e-531f-8c67-1c3e1344b4d8');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);

-- Muestra 25: Cenizo
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Cenizo', NULL, 'perro_01.jpg', 25.5415202, -100.9509109, '2026-09-15 15:14:00', 'eb2dcae9-bd48-544b-9a53-a59f184d313b');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Crema'), FALSE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 26: Trueno
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Trueno', NULL, 'perro_06.jpg', 25.4565286, -100.9803736, '2026-09-15 18:42:00', '4696588c-c534-579a-9377-f1dc4f302cd0');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 27: Compás
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Compás', NULL, 'perro_04.jpg', 25.5414315, -100.9470867, '2026-09-16 13:40:00', '984e96f8-8876-54b0-9ca1-2a5f784f4e84');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 28: Pirata
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Pirata', (SELECT id FROM raza WHERE nombre = 'Poodle / Caniche'), 'perro_09.jpg', 25.4236484, -100.9921751, '2026-09-16 17:44:00', 'aa5630ac-58b3-53d2-bdac-d86da21be178');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 29: Gato
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Gato', NULL, 'perro_12.jpg', 25.3554912, -101.0392423, '2026-09-18 09:01:00', '2c6fdfad-5890-5f2b-b4fb-39e0ae8b3e9a');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);

-- Muestra 30: Maya
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Maya', NULL, 'perro_07.jpg', 25.4201794, -100.9939026, '2026-09-18 11:28:00', '946571b9-1b50-5b80-a975-4505f5246f59');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), FALSE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Muestra 31: Tuerca
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Tuerca', (SELECT id FROM raza WHERE nombre = 'Husky Siberiano'), 'perro_12.jpg', 25.4278702, -100.9957651, '2026-09-18 18:54:00', '9b05af23-cb89-57e6-90ca-0405412eb3a0');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 32: Peque
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Peque', NULL, 'perro_07.jpg', 25.5399497, -100.9511154, '2026-09-19 08:02:00', 'eeb89034-d5d8-5f1e-89a9-43b454c1eea8');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Gris'), TRUE);

-- Muestra 33: Galleta
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Galleta', NULL, 'perro_15.jpg', 25.4233882, -100.9926316, '2026-09-19 10:09:00', '783c2f3f-b2c2-5ae8-800a-3f508c94ccf2');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);

-- Muestra 34: Pelón
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Pelón', NULL, 'perro_05.jpg', 25.3561814, -101.0302712, '2026-09-19 10:42:00', '1ae9e11c-d97e-5c32-9cd3-05bdd0496689');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 35: Cuaderno
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Cuaderno', NULL, 'perro_03.jpg', 25.3532695, -101.0326021, '2026-09-19 13:21:00', 'ad3b6457-720f-5712-92c8-4e8fc82648e1');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), FALSE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Muestra 36: Canela
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Canela', NULL, 'perro_10.jpg', 25.3569374, -101.0339754, '2026-09-19 15:58:00', 'a7eb21fb-596a-59a7-af40-cedd91d03797');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 37: Tuerto
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Tuerto', NULL, 'perro_02.jpg', 25.4264680, -101.0008131, '2026-09-20 09:42:00', 'b78af9d5-e348-56f0-b9fb-9fc60a78253f');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Manchado'), TRUE);

-- Muestra 38: Ceniza
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Ceniza', (SELECT id FROM raza WHERE nombre = 'Salchicha (Dachshund)'), 'perro_08.jpg', 25.4264363, -100.9958192, '2026-09-20 10:53:00', 'd624ecef-f63a-51ad-9c11-8e058670394e');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 39: Chato
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Chato', NULL, 'perro_10.jpg', 25.3570967, -101.0339192, '2026-09-20 16:58:00', '302fb70b-1536-5211-a009-ed676a40a3c4');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 40: Greñas
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Greñas', (SELECT id FROM raza WHERE nombre = 'Labrador Retriever'), 'perro_07.jpg', 25.4302045, -100.9915053, '2026-09-20 17:55:00', '7c04c817-fe07-5419-8d49-8a22d8e51cd3');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Atigrado'), TRUE);

-- Muestra 41: Mora
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Mora', NULL, 'perro_11.jpg', 25.4307619, -100.9975416, '2026-09-20 18:27:00', 'd78b6f63-eabf-53e0-9798-cee46a0bd07d');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Canela'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 42: Clavito
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Clavito', NULL, 'perro_13.jpg', 25.4274540, -101.0010729, '2026-09-21 08:03:00', '4585fd38-9521-54bf-a01d-ed5a9628abb5');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Manchado'), TRUE);

-- Muestra 43: Nopal
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Nopal', NULL, 'perro_13.jpg', 25.5428600, -100.9494375, '2026-09-21 10:24:00', '70a6efa1-2d8b-5a7e-8c79-688e30417584');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 44: Flaquito
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Flaquito', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_14.jpg', 25.4188820, -100.9925341, '2026-09-21 11:34:00', '34c1b7be-324a-54d5-a2f5-0266ba244866');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), FALSE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 45: Chato
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Chato', (SELECT id FROM raza WHERE nombre = 'Husky Siberiano'), 'perro_12.jpg', 25.4309844, -100.9967968, '2026-09-21 13:18:00', '73e651a5-9f5c-530c-9631-d354fe511fc6');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Crema'), TRUE);

-- Muestra 46: Sarape
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Sarape', NULL, 'perro_06.jpg', 25.5397844, -100.9455272, '2026-09-22 09:24:00', '7d71ba58-80e4-537c-9159-cb003f45da5a');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 47: Rebozo
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Rebozo', NULL, 'perro_04.jpg', 25.4251311, -100.9977267, '2026-09-22 15:59:00', '439a1bec-b405-57bc-8805-0f1c849de2b1');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);

-- Muestra 48: Tornillo
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Tornillo', (SELECT id FROM raza WHERE nombre = 'Salchicha (Dachshund)'), 'perro_05.jpg', 25.4264940, -100.9884395, '2026-09-24 11:59:00', '81d9c01f-5d60-5348-b009-4a699f67c9fd');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);

-- Muestra 49: Manchitas
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Manchitas', NULL, 'perro_05.jpg', 25.3553589, -101.0310830, '2026-09-24 15:42:00', '1362af05-bc1d-5643-b3a9-7b6aa1da9e78');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 50: Baltazar
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Baltazar', (SELECT id FROM raza WHERE nombre = 'Border Collie'), 'perro_03.jpg', 25.4591333, -100.9827600, '2026-09-24 17:54:00', '77ad56f1-fb2d-5cd4-9409-23625a58d5bd');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 51: Manchas
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Manchas', NULL, 'perro_10.jpg', 25.4232259, -100.9926393, '2026-09-24 18:21:00', 'd7eed2b9-c589-5c58-8912-90e12764642f');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 52: Cafecito
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Cafecito', (SELECT id FROM raza WHERE nombre = 'Poodle / Caniche'), 'perro_09.jpg', 25.4246268, -100.9926034, '2026-09-24 21:44:00', '6524b7e1-dfb1-5715-8ef5-5585bbbedfa4');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 53: Coco
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Coco', NULL, 'perro_01.jpg', 25.4307059, -100.9966332, '2026-09-25 08:15:00', '1277e835-76e0-5a55-94c0-819c97c87504');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Crema'), TRUE);

-- Muestra 54: Rayo
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Rayo', (SELECT id FROM raza WHERE nombre = 'Schnauzer'), 'perro_04.jpg', 25.4339193, -100.9967300, '2026-09-25 14:39:00', '48fadab4-9819-5baa-a6b8-575f89d19f74');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), TRUE);

-- Muestra 55: Sombra
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Sombra', NULL, 'perro_02.jpg', 25.4231195, -100.9918776, '2026-09-25 19:03:00', '14bcc20c-ca8e-5051-98f5-2b458d94d745');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Crema'), TRUE);

-- Muestra 56: Negrito
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Negrito', NULL, 'perro_15.jpg', 25.4233495, -100.9922101, '2026-09-26 17:09:00', '56e69be6-e3e3-521a-bd07-3bbcc3352e5a');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);

-- Muestra 57: Luna Negra
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Luna Negra', (SELECT id FROM raza WHERE nombre = 'Labrador Retriever'), 'perro_01.jpg', 25.5401250, -100.9548062, '2026-09-26 18:40:00', '11468ed0-f7ee-517f-a04e-781f11590903');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 58: Lola
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Lola', (SELECT id FROM raza WHERE nombre = 'Pastor Alemán'), 'perro_01.jpg', 25.4255430, -100.9908087, '2026-09-27 15:51:00', 'ddd72671-afd3-5b97-b6bb-7a06bb1d1262');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 59: Chucho
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Chucho', (SELECT id FROM raza WHERE nombre = 'Pitbull / Terrier americano'), 'perro_02.jpg', 25.4231451, -100.9911917, '2026-09-27 16:33:00', 'cc98c7e0-dada-5fbf-a504-3118f1f85929');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Gris'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 60: Bola
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Bola', (SELECT id FROM raza WHERE nombre = 'Salchicha (Dachshund)'), 'perro_13.jpg', 25.4240039, -100.9960492, '2026-09-28 08:20:00', 'a3c38036-62d5-595a-868d-98790e364fe0');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Crema'), TRUE);

-- Muestra 61: Max
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Max', (SELECT id FROM raza WHERE nombre = 'Chihuahua'), 'perro_15.jpg', 25.4232811, -100.9930325, '2026-09-28 13:41:00', '1dda82a8-2bda-55ef-9190-9dda7d59c945');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Gris'), TRUE);

-- Muestra 62: Canelo
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Canelo', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_05.jpg', 25.4589865, -100.9854314, '2026-09-28 14:34:00', '4c7fd5f4-7648-5de5-9458-96775ce5a36a');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Canela'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 63: Martillo
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Martillo', NULL, 'perro_12.jpg', 25.3554225, -101.0306556, '2026-09-28 17:57:00', '2ba01b95-4229-529d-b9d4-a85dfa81d7b1');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), FALSE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 64: Bimba
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Bimba', (SELECT id FROM raza WHERE nombre = 'Border Collie'), 'perro_14.jpg', 25.4570010, -100.9824223, '2026-09-30 08:06:00', '8e942f7c-cf3a-5b27-8315-b2e2625aff6f');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 65: Bruno
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Bruno', (SELECT id FROM raza WHERE nombre = 'Pitbull / Terrier americano'), 'perro_09.jpg', 25.4319053, -100.9939523, '2026-09-30 08:42:00', '9feed455-84ef-5ba3-89e2-dac0c484519f');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 66: Regla
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Regla', NULL, 'perro_13.jpg', 25.4307063, -100.9974638, '2026-09-30 12:37:00', '213dc24a-cb52-5710-bcf2-ffa12234f7cb');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Gris'), TRUE);

-- Muestra 67: Limón
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Limón', (SELECT id FROM raza WHERE nombre = 'Pastor Alemán'), 'perro_07.jpg', 25.4296988, -100.9966754, '2026-10-01 10:41:00', 'e8702e8e-bec9-52b3-98bc-1980834b48eb');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 68: Pincel
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Pincel', (SELECT id FROM raza WHERE nombre = 'Labrador Retriever'), 'perro_03.jpg', 25.4312347, -100.9963646, '2026-10-02 09:57:00', 'e50dde03-3bb9-52e5-8b86-a17d30b42857');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Canela'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 69: Piñata
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Piñata', (SELECT id FROM raza WHERE nombre = 'Pastor Alemán'), 'perro_02.jpg', 25.3591788, -101.0348278, '2026-10-02 16:21:00', '1254d9ed-1570-52d1-9dc2-13e2d09e8645');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 70: Lápiz
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Lápiz', (SELECT id FROM raza WHERE nombre = 'Border Collie'), 'perro_08.jpg', 25.4265204, -100.9941293, '2026-10-03 09:51:00', 'e2de7ba3-00a9-5a37-b2ad-c38d863efd18');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), FALSE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Muestra 71: Melchor
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Melchor', (SELECT id FROM raza WHERE nombre = 'Schnauzer'), 'perro_09.jpg', 25.4632980, -100.9833233, '2026-10-04 13:43:00', '447a0e70-cd7f-5b30-b2a5-4cbf21e7c856');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), TRUE);

-- Muestra 72: Osito
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Osito', NULL, 'perro_09.jpg', 25.4240141, -100.9931942, '2026-10-04 18:08:00', '16a2531c-3630-56ed-83ea-130574538bb4');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Muestra 73: Nala
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Nala', NULL, 'perro_09.jpg', 25.5398948, -100.9491220, '2026-10-05 18:46:00', 'bdbcfbc0-98dc-564a-987d-35e59bb45d71');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), FALSE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Muestra 74: Flaquito
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Flaquito', (SELECT id FROM raza WHERE nombre = 'Pastor Alemán'), 'perro_01.jpg', 25.4256100, -100.9902503, '2026-10-05 22:51:00', 'a6d80d92-1c9c-5126-9e25-35bd2d8bd97c');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 75: Tacho
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Tacho', (SELECT id FROM raza WHERE nombre = 'Xoloitzcuintle'), 'perro_02.jpg', 25.5412941, -100.9530714, '2026-10-06 08:28:00', '582b88a6-3487-5093-9306-9168af5e708b');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);

-- Muestra 76: Pelusa
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Pelusa', NULL, 'perro_08.jpg', 25.4559931, -100.9850816, '2026-10-07 13:01:00', '2fa079da-d582-525d-bb06-376f0ff61a5f');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 77: Cacahuate
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Cacahuate', NULL, 'perro_10.jpg', 25.3575817, -101.0367560, '2026-10-07 13:39:00', '713c1492-4819-501c-a07c-a944d77d1406');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 78: Mango
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Mango', NULL, 'perro_01.jpg', 25.5380621, -100.9490646, '2026-10-08 09:21:00', '32b415ec-8272-529e-8708-5454b3b55f63');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 79: Frijol
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Frijol', NULL, 'perro_09.jpg', 25.4577926, -100.9856758, '2026-10-08 10:07:00', '2349377c-534c-5da6-aa34-d7a08534eba1');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Muestra 80: Kiara
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Kiara', NULL, 'perro_08.jpg', 25.4238690, -100.9901315, '2026-10-09 13:14:00', 'dcb753d1-6a83-5f7b-85b6-b1c6d06f203a');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 81: Soldador
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Soldador', NULL, 'perro_05.jpg', 25.3618646, -101.0258881, '2026-10-09 14:14:00', '496069d1-a056-5cf2-93bc-7f9e2d09b24a');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Manchado'), TRUE);

-- Muestra 82: Mancha
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Mancha', NULL, 'perro_06.jpg', 25.3567963, -101.0332807, '2026-10-09 14:39:00', 'ccf88af8-24d8-5f60-90cf-bab6940cf22c');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Muestra 83: Toño
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Toño', (SELECT id FROM raza WHERE nombre = 'Border Collie'), 'perro_10.jpg', 25.5441465, -100.9507941, '2026-10-09 16:41:00', 'ba5bdabb-645e-58ef-8507-8699efca2d18');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);

-- Muestra 84: Duque
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Duque', (SELECT id FROM raza WHERE nombre = 'Schnauzer'), 'perro_14.jpg', 25.4527855, -100.9774551, '2026-10-10 09:43:00', '952344a7-6cc4-534a-a3c5-96c7c2f74734');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 85: Panda
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Panda', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_11.jpg', 25.4239180, -100.9918760, '2026-10-10 10:05:00', 'c586945e-9693-5b50-b816-c5319e4ed739');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), FALSE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Muestra 86: Mochi
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Mochi', NULL, 'perro_14.jpg', 25.4216784, -100.9919652, '2026-10-10 11:23:00', '67ffa19d-edbc-510a-b221-2e5e68ef7f2c');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 87: Burrito
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Burrito', NULL, 'perro_12.jpg', 25.4281989, -100.9914065, '2026-10-10 18:19:00', '5a889537-2296-5b32-a310-51576959b8f2');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 88: Chiquis
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Chiquis', (SELECT id FROM raza WHERE nombre = 'Chihuahua'), 'perro_15.jpg', 25.4309502, -101.0000588, '2026-10-11 13:24:00', '20504181-9193-5fe3-9068-62f75e4273a9');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Gris'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 89: Dobby
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Dobby', NULL, 'perro_05.jpg', 25.4538880, -100.9838888, '2026-10-11 13:34:00', '67e81d63-d820-5976-bf55-973d0741dd81');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);

-- Muestra 90: Nieve
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Nieve', NULL, 'perro_01.jpg', 25.4239365, -100.9946007, '2026-10-12 11:32:00', 'ac944b7b-ffa2-5122-a797-4e8b75de6c05');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 91: Rufo
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Rufo', (SELECT id FROM raza WHERE nombre = 'Pitbull / Terrier americano'), 'perro_03.jpg', 25.4271953, -101.0021555, '2026-10-12 14:03:00', '35ee13fd-4358-56bf-a21f-1b748ddf3843');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);

-- Muestra 92: Pozole
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Pozole', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_07.jpg', 25.4576329, -100.9822463, '2026-10-12 14:28:00', 'c3e27c73-f011-5940-b6d6-26146a796a77');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);

-- Muestra 93: Chato
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Chato', NULL, 'perro_09.jpg', 25.5394097, -100.9490770, '2026-10-12 21:46:00', '6280a5b0-70fc-545d-ae87-975ff3ec9429');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), FALSE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Muestra 94: Pulgas
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Pulgas', (SELECT id FROM raza WHERE nombre = 'Xoloitzcuintle'), 'perro_15.jpg', 25.4216474, -100.9940719, '2026-10-13 10:17:00', '3c8cd949-237c-5344-96e6-8f93cb0cf035');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 95: Bigotes
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Bigotes', (SELECT id FROM raza WHERE nombre = 'Border Collie'), 'perro_03.jpg', 25.4285294, -100.9960955, '2026-10-13 17:43:00', 'ed284372-cb1f-51b0-b89e-91615b71385c');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 96: Kaiser
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Kaiser', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_06.jpg', 25.4591612, -100.9844013, '2026-10-14 08:26:00', '7a954f1e-2c99-5008-89b0-a415948080b5');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);

-- Muestra 97: Beto
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Beto', (SELECT id FROM raza WHERE nombre = 'Schnauzer'), 'perro_06.jpg', 25.4210632, -100.9947294, '2026-10-14 08:36:00', 'fb47ce6b-398b-5407-b372-90aee658e61e');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Crema'), TRUE);

-- Muestra 98: Tigre
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Tigre', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_09.jpg', 25.5405901, -100.9480679, '2026-10-14 12:03:00', 'b497dade-e613-5e09-9954-73aa4135ee19');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 99: Cachorro
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Cachorro', (SELECT id FROM raza WHERE nombre = 'Pastor Alemán'), 'perro_12.jpg', 25.4309714, -100.9982714, '2026-10-14 15:22:00', 'd9576c9b-5bfb-5c87-a67c-1d99f9a0d6cc');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 100: Jitomate
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Jitomate', NULL, 'perro_10.jpg', 25.4575582, -100.9823644, '2026-10-14 16:36:00', '66ec9a12-7b37-5896-954e-e05d1fdc0043');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Manchado'), TRUE);

-- Muestra 101: Volcán
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Volcán', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_11.jpg', 25.3557677, -101.0343176, '2026-10-14 16:52:00', '493df154-bc94-5364-9dab-fac922c0c024');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 102: Peludo
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Peludo', (SELECT id FROM raza WHERE nombre = 'Sin raza definida / criollo'), 'perro_11.jpg', 25.4236632, -100.9925684, '2026-10-14 17:05:00', 'a56c8e00-444c-597b-9699-88f693d80816');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), FALSE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Muestra 103: Simba
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Simba', NULL, 'perro_13.jpg', 25.3556480, -101.0266273, '2026-10-14 18:08:00', '27f18033-11d8-5df5-8a60-1a2c0cd0e366');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 104: Gordo
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Gordo', (SELECT id FROM raza WHERE nombre = 'Pastor Alemán'), 'perro_15.jpg', 25.3551823, -101.0306807, '2026-10-14 18:25:00', '8cd59d69-9466-5b3b-95bf-faf50cf3ee1a');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Rojizo'), TRUE);

-- Muestra 105: Aguacate
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Aguacate', NULL, 'perro_11.jpg', 25.4187667, -100.9930478, '2026-10-15 10:41:00', '5fa3d08f-55d2-50f0-8dd6-ab0819a82fc7');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 106: Princesa
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Princesa', (SELECT id FROM raza WHERE nombre = 'Poodle / Caniche'), 'perro_08.jpg', 25.4575687, -100.9809737, '2026-10-15 16:49:00', '597d9ddc-634d-5295-99ff-6c04657c1268');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 107: Peludo
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Peludo', NULL, 'perro_08.jpg', 25.4232503, -100.9896566, '2026-10-15 17:14:00', 'c8f2bcbc-d2ef-53df-8afd-b723280be877');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 108: Engrapadora
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Engrapadora', (SELECT id FROM raza WHERE nombre = 'Husky Siberiano'), 'perro_04.jpg', 25.3498602, -101.0340875, '2026-10-16 10:57:00', 'b0af8c8f-743b-54b5-8725-a63f9d3b986e');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), FALSE);

-- Muestra 109: Goma
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Goma', (SELECT id FROM raza WHERE nombre = 'Schnauzer'), 'perro_11.jpg', 25.4290881, -100.9913463, '2026-10-16 13:26:00', '6a7a4efa-2e28-5cf8-a1c9-2e76daab2fd6');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Gris'), TRUE);

-- Muestra 110: Doña Lola
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Doña Lola', (SELECT id FROM raza WHERE nombre = 'Pastor Alemán'), 'perro_01.jpg', 25.4331020, -100.9973936, '2026-10-16 14:21:00', '97543baa-9d60-5673-97ab-1e1df4b98283');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 111: Chilaquil
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Chilaquil', NULL, 'perro_15.jpg', 25.4220378, -100.9908044, '2026-10-16 19:40:00', 'ba532247-cd67-58cf-bba8-2450e368fb38');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 112: Peludo
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Peludo', (SELECT id FROM raza WHERE nombre = 'Pastor Alemán'), 'perro_01.jpg', 25.4333757, -100.9970142, '2026-10-17 20:21:00', '247bacb0-45b2-5908-b880-7577eee90723');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 113: Juanito
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Juanito', NULL, 'perro_03.jpg', 25.4250019, -100.9984658, '2026-10-18 08:19:00', 'c3300b7a-43b8-58ea-ad7a-729ffa4e614c');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 114: Güero
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Güero', NULL, 'perro_13.jpg', 25.3548946, -101.0263816, '2026-10-19 01:08:00', '961cfe23-678c-5967-a9b1-964a9d5dbaa6');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 115: Nube
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Nube', (SELECT id FROM raza WHERE nombre = 'Labrador Retriever'), 'perro_04.jpg', 25.3552547, -101.0363692, '2026-10-19 11:15:00', 'ee246e9d-24a8-5804-9232-9d358cf9cf1a');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 116: Pegamento
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Pegamento', NULL, 'perro_02.jpg', 25.4309808, -100.9973088, '2026-10-19 14:10:00', '627d9db3-e6b9-5594-87e8-6fe9f6aee8fb');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Negro'), TRUE);

-- Muestra 117: Churro
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Churro', NULL, 'perro_15.jpg', 25.4273132, -100.9983402, '2026-10-19 16:52:00', '26b7a431-8da7-57c1-9504-38f3c02be995');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Dorado'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 118: Flaquito
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Flaquito', NULL, 'perro_12.jpg', 25.4282434, -100.9920623, '2026-10-19 21:19:00', '39b988da-d7d4-52f3-9da1-214d4c6e2138');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Blanco'), FALSE);

-- Muestra 119: Chispa
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Chispa', (SELECT id FROM raza WHERE nombre = 'Pastor Alemán'), 'perro_03.jpg', 25.4593340, -100.9836397, '2026-10-21 08:02:00', 'bb7d2360-1eab-5cb4-b44f-0c71c7847234');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

-- Muestra 120: Peludo
INSERT INTO perrito (nombre, raza_id, foto_archivo, latitud, longitud, fecha_registro, clave_idempotencia) VALUES ('Peludo', (SELECT id FROM raza WHERE nombre = 'Pastor Alemán'), 'perro_03.jpg', 25.4588904, -100.9845590, '2026-10-23 17:00:00', '16d57f0c-8b34-56c7-85a1-7407d1705baf');
SET @perrito_id = LAST_INSERT_ID();
INSERT INTO perrito_color (perrito_id, color_id, es_principal) VALUES (@perrito_id, (SELECT id FROM color WHERE nombre = 'Café'), TRUE);

