#!/bin/bash

# Solicitar al usuario el directorio
read -p "Ingrese la ruta del directorio: " directorio

# Verificar si el directorio existe
if [ ! -d "$directorio" ]; then
    echo "Error: El directorio no existe."
    exit 1
fi

# Solicitar al usuario el prefijo o sufijo
read -p "Ingrese el prefijo o sufijo a agregar a los nombres de archivo: " personalizado

# Solicitar al usuario si desea agregar un prefijo o sufijo
read -p "¿Desea agregar un prefijo o sufijo? (P/S): " tipo

# Iterar sobre los archivos en el directorio y renombrarlos
for archivo in "$directorio"/*; do
    if [ -f "$archivo" ]; then
        nombre=$(basename "$archivo")
        extension="${nombre##*.}"
        nombre_sin_extension="${nombre%.*}"

        if [ "$tipo" == "P" ] || [ "$tipo" == "p" ]; then
            nuevo_nombre="$personalizado$nombre_sin_extension.$extension"
        elif [ "$tipo" == "S" ] || [ "$tipo" == "s" ]; then
            nuevo_nombre="$nombre_sin_extension$personalizado.$extension"
        else
            echo "Opción no válida. Saliendo del script."
            exit 1
        fi

        mv "$archivo" "$directorio/$nuevo_nombre"
        echo "Renombrado: $nombre -> $nuevo_nombre"
    fi
done

echo "Archivos renombrados correctamente en el directorio: $directorio"

