#!/bin/bash
DIRECTORIO=$(pwd)

# Verificar si el directorio existe
if [ ! -d "$DIRECTORIO" ]; then
    echo "Error: El directorio no existe."
    exit 1
fi
NUM_ARCHIVOS=$(find "$DIRECTORIO" -type f | wc -l)


echo "La cantidad de archivos en '$DIRECTORIO': $NUM_ARCHIVOS"

