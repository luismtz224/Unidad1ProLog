#!/usr/bin/env bash
# ============================================================
# restore.sh — restaura un respaldo generado por backup.sh
#
# Uso:
#   ./restore.sh db_20260922_180000.sql imagenes_20260922_180000.tar.gz
# ============================================================
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Uso: ./restore.sh <respaldo_db.sql> <respaldo_imagenes.tar.gz>"
  exit 1
fi

DB_HOST="${DB_HOST:-localhost}"
DB_USER="${DB_USER:-perritos_app}"
DB_NAME="${DB_NAME:-perritos_calle}"
RUTA_IMAGENES="${RUTA_IMAGENES:?Debes definir RUTA_IMAGENES}"

RESPALDO_DB="$1"
RESPALDO_IMAGENES="$2"

echo "Restaurando base de datos..."
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < "$RESPALDO_DB"

echo "Restaurando imágenes en $RUTA_IMAGENES ..."
mkdir -p "$RUTA_IMAGENES"
tar -xzf "$RESPALDO_IMAGENES" -C "$(dirname "$RUTA_IMAGENES")"

echo "Restauración completa."
