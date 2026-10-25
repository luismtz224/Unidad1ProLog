#!/bin/sh
# Se ejecuta UNA vez, al crear el volumen de la base (docker-entrypoint-initdb.d).
# Crea el usuario de SOLO LECTURA que usa el servicio Elixir (opción A del P2).
set -e

mysql -uroot -p"$MYSQL_ROOT_PASSWORD" <<EOSQL
CREATE USER IF NOT EXISTS '${DB_LECTURA_USUARIO}'@'%' IDENTIFIED BY '${DB_LECTURA_PASSWORD}';
GRANT SELECT ON \`${MYSQL_DATABASE}\`.* TO '${DB_LECTURA_USUARIO}'@'%';
FLUSH PRIVILEGES;
EOSQL
