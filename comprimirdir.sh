#!/bin/bash
#
# Script para comprimir archivos con una extensión específica en un directorio dado

# Verifica que se han proporcionado exactamente dos parámetros
if [ $# -ne 2 ]; then
    echo "Error: Se esperan dos parámetros. Primero el directorio y luego la extensión."
    exit 1
fi

# Asigna los parámetros a variables
directorio=$1
extension=$2
zip="archivos_$extension.zip"

# Verifica si el directorio existe
if [ ! -d "$directorio" ]; then
    echo "Error: El directorio '$directorio' no existe."
    exit 1
fi

# Busca archivos con la extensión especificada
copias=$(find "$directorio" -type f -name "*.$extension")

# Verifica si se encontraron archivos
if [ -n "$copias" ]; then
    # Pregunta al usuario si desea comprimir los archivos
    read -p "Hay archivos con la extensión '.$extension'. ¿Desea comprimirlos? [S/N]: " respuesta

    case "$respuesta" in
        [Ss])
            # Realiza la compresión
            zip -j "$zip" $copias
            if [ $? -eq 0 ]; then
                echo "Compresión exitosa: $zip"
            else
                echo "Error: Fallo en la compresión."
            fi
            ;;
        [Nn])
            echo "Compresión cancelada por el usuario."
            ;;
        *)
            echo "Respuesta inválida. Debe ser 'S' o 'N'."
            exit 1
            ;;
    esac
else
    echo "No se encontraron archivos con la extensión '.$extension' en el directorio '$directorio'."
    exit 1
fi

