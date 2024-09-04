#!/bin/bash

# Solicitar al usuario el archivo en el que realizar el reemplazo
read -p "Ingrese la ruta del archivo en el que desea realizar el reemplazo: " archivo

# Verificar si el archivo existe
if [ ! -e "$archivo" ]; then
    echo "Error: El archivo no existe."
    exit 1
fi

# Solicitar al usuario la cadena de texto a buscar
read -p "Ingrese la cadena de texto a buscar: " cadena_buscar

# Solicitar al usuario la cadena de texto de reemplazo
read -p "Ingrese la cadena de texto de reemplazo: " cadena_reemplazo

# Realizar el reemplazo en el archivo
sed -i "s/$cadena_buscar/$cadena_reemplazo/g" "$archivo"

echo "Reemplazo completado en el archivo: $archivo"

