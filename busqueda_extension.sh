#!/bin/bash

# Solicitar al usuario la extensión de archivo a buscar
read -p "Ingrese la extensión de archivo (sin el punto): " extension

# Solicitar al usuario el directorio desde el cual iniciar la búsqueda
read -p "Ingrese la ruta del directorio desde el cual iniciar la búsqueda: " directorio_inicio

# Verificar si el directorio existe
if [ ! -d "$directorio_inicio" ]; then
    echo "Error: El directorio no existe."
    exit 1
fi

# Utilizar find para buscar archivos con la extensión específica
echo "Archivos con la extensión .$extension en $directorio_inicio y subdirectorios:"
find "$directorio_inicio" -type f -name "*.$extension" -print

