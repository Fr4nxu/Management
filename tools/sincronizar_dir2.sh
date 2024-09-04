#!/bin/bash

# Solicitar al usuario las rutas de los directorios a comparar
read -p "Ingrese la ruta del directorio de origen: " directorio_origen
read -p "Ingrese la ruta del directorio de destino: " directorio_destino

# Verificar si los directorios existen
if [ ! -d "$directorio_origen" ] || [ ! -d "$directorio_destino" ]; then
    echo "Error: Uno o ambos de los directorios no existen."
    exit 1
fi

# Confirmar la sincronización
echo "Va a sincronizar '$directorio_origen' con '$directorio_destino'."
read -p "¿Está seguro de que desea continuar? (s/n): " confirmacion

if [[ $confirmacion =~ ^[sS]$ ]]; then
    # Sincronizar los directorios utilizando rsync
    echo "Iniciando la sincronización..."
    if rsync -av --delete "$directorio_origen/" "$directorio_destino/"; then
        echo "Los directorios han sido sincronizados correctamente."
    else
        echo "Error: La sincronización de directorios falló."
        exit 1
    fi
else
    echo "Sincronización cancelada."
    exit 0
fi

