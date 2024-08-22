#!/bin/bash

# Nombre del archivo de registro
ARCHIVO_LOG="ARCHIVO.log"

# Preguntar al usuario cuántos registros desea conservar
read -p "Ingrese el número de registros que desea conservar: " N

# Verificar si el archivo de registro existe
if [ -f "$archivo_log" ]; then
    # Contar el número total de líneas en el archivo de registro
    LINEAS=$(wc -l < "$archivo_log")

    # Calcular el número de líneas a conservar
    CONSERVAR=$((LINEAS - N))

    # Si es necesario, realizar la rotación eliminando las líneas más antiguas
    if [ "$CONSERVAR" -gt 0 ]; then
        sed -i "1,${CONSERVAR}d" "$ARCHIVO_LOG"
        echo "Rotación completada. Se conservan los últimos $N registros."
    else
        echo "No es necesario realizar la rotación. El archivo ya tiene $LINEAS registros o menos."
    fi
else
    echo "El archivo de registro '$ARCHIVO_LOG' no existe."
fi

