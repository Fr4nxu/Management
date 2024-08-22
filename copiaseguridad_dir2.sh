#!/bin/bash
#
# backup.sh
# Script para realizar una copia de seguridad de un directorio.
#
# Solo el usuario root puede ejecutar este script.
if [ "$EUID" -ne 0 ]; then
    echo "Error: Este script debe ser ejecutado como root." >&2
    exit 1
fi

clear

# Solicita los directorios al usuario
read -p "Introduce el directorio completo a copiar: " DIRECTORIO_DIR
read -p "Introduce el directorio completo donde se enviará la copia: " COPIA_DIR

# Validar que los directorios no estén vacíos
if [ -z "$DIRECTORIO_DIR" ] || [ -z "$COPIA_DIR" ]; then
    echo "Error: Los directorios no pueden estar vacíos." >&2
    exit 2
fi

# Validar que el directorio de origen existe
if [ ! -d "$DIRECTORIO_DIR" ]; then
    echo "Error: El directorio de origen '$DIRECTORIO_DIR' no existe." >&2
    exit 3
fi

# Crear el directorio de destino si no existe
if [ ! -d "$COPIA_DIR" ]; then
    mkdir -p "$COPIA_DIR"
fi

LOG="$COPIA_DIR/backup.log"

# Obtener la fecha de la última copia
COPIA_ULTIMA=$(tail -n 1 "$LOG" 2>/dev/null)

# Obtener la fecha actual
FECHA_ACTUAL=$(date +"%Y%m%d%H%M%S")

# Actualizar el log con la nueva fecha de copia
echo "$FECHA_ACTUAL" >> "$LOG"

# Crear el directorio de respaldo con la fecha actual
DIRECTORIO_COPIA="$COPIA_DIR/$FECHA_ACTUAL"

# Copiar archivos modificados desde la última copia usando rsync
if [ -n "$COPIA_ULTIMA" ]; then
    rsync -a --link-dest="$COPIA_DIR/$COPIA_ULTIMA" "$DIRECTORIO_DIR/" "$DIRECTORIO_COPIA/"
else
    rsync -a "$DIRECTORIO_DIR/" "$DIRECTORIO_COPIA/"
fi

# Confirmar que la copia se completó
echo "Copia completada en $DIRECTORIO_COPIA"

exit 0

