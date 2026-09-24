#!/usr/bin/env bash
# backup.sh — respalda la base de datos y la carpeta de
# imágenes (que vive fuera del proyecto).
#
# Uso:
#   ./backup.sh


 
set -euo pipefail

DB_HOST="${DB_HOST:-localhost}"
DB_USER="${DB_USER:-perritos_app}"
DB_NAME="${DB_NAME:-perritos_calle}"
RUTA_IMAGENES="${RUTA_IMAGENES:?Debes definir RUTA_IMAGENES}"
RUTA_RESPALDOS="${RUTA_RESPALDOS:-/var/backups/perritos}"

FECHA=$(date +%Y%m%d_%H%M%S)
mkdir -p "$RUTA_RESPALDOS"

echo "Respaldando base de datos..."
mysqldump \
  -h "$DB_HOST" \
  -u "$DB_USER" \
  -p"$DB_PASSWORD" \
  --single-transaction \
  --routines \
  --triggers \
  "$DB_NAME" > "$RUTA_RESPALDOS/db_${FECHA}.sql"

echo "Respaldando imágenes..."
tar -czf "$RUTA_RESPALDOS/imagenes_${FECHA}.tar.gz" -C "$(dirname "$RUTA_IMAGENES")" "$(basename "$RUTA_IMAGENES")"

echo "Listo:"
echo "  $RUTA_RESPALDOS/db_${FECHA}.sql"
echo "  $RUTA_RESPALDOS/imagenes_${FECHA}.tar.gz"
