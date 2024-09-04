#!/bin/bash

# Solicitar al usuario las rutas de los directorios a comparar
read -p "Ingrese la ruta del directorio de origen: " directorio_origen
read -p "Ingrese la ruta del directorio de destino: " directorio_destino

# Verificar si los directorios existen
if [ ! -d "$directorio_origen" ] || [ ! -d "$directorio_destino" ]; then
    echo "Error: Uno o ambos de los directorios no existen."
    exit 1
fi

# Sincronizar los directorios utilizando rsync
rsync -av --delete "$directorio_origen/" "$directorio_destino/"

# Mostrar mensaje de éxito
echo "Los directorios han sido sincronizados correctamente."

