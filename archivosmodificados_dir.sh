#!/bin/bash
read -p "nombre del directorio a contar(ej:/home/proyecto1): " DIRECTORIO

if [ ! -d "$DIRECTORIO" ]; then
    echo "Error: El directorio no existe."
    exit 1
fi

read -p "Ingrese la cantidad de días para buscar modificaciones: " N

ARCHIVOS=$(find "$DIRECTORIO" -type f -mtime "-$N")

echo -e "Archivos modificados recientemente $ARCHIVOS:"


