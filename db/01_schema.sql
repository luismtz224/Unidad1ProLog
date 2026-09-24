CREATE DATABASE IF NOT EXISTS perritos_calle
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE perritos_calle;

-- ------------------------------------------------------------
-- Catálogo de razas
-- ------------------------------------------------------------
CREATE TABLE raza (
    id      INT AUTO_INCREMENT PRIMARY KEY,
    nombre  VARCHAR(100) NOT NULL,
    CONSTRAINT uq_raza_nombre UNIQUE (nombre)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Catálogo de colores
-- ------------------------------------------------------------
CREATE TABLE color (
    id      INT AUTO_INCREMENT PRIMARY KEY,
    nombre  VARCHAR(50) NOT NULL,
    CONSTRAINT uq_color_nombre UNIQUE (nombre)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Perrito registrado
-- ------------------------------------------------------------
CREATE TABLE perrito (
    id                   INT AUTO_INCREMENT PRIMARY KEY,
    nombre               VARCHAR(100) NOT NULL,
    raza_id              INT NULL,
    foto_archivo         VARCHAR(255) NOT NULL,
    latitud              DECIMAL(10,7) NOT NULL,
    longitud             DECIMAL(10,7) NOT NULL,
    fecha_registro       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    clave_idempotencia   VARCHAR(100) NOT NULL,

    CONSTRAINT uq_perrito_idempotencia UNIQUE (clave_idempotencia),
    CONSTRAINT fk_perrito_raza FOREIGN KEY (raza_id)
        REFERENCES raza (id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- Colores de un perrito (relación muchos a muchos).
-- ------------------------------------------------------------
CREATE TABLE perrito_color (
    perrito_id    INT NOT NULL,
    color_id      INT NOT NULL,
    es_principal  BOOLEAN NOT NULL DEFAULT FALSE,

    PRIMARY KEY (perrito_id, color_id),
    CONSTRAINT fk_pc_perrito FOREIGN KEY (perrito_id)
        REFERENCES perrito (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pc_color FOREIGN KEY (color_id)
        REFERENCES color (id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;
