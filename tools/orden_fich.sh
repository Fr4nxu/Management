#!/bin/bash

# Solicitar al usuario el archivo a leer
read -p "Ingrese la ruta del archivo a leer: " archivo

# Verificar si el archivo existe
if [ ! -e "$archivo" ]; then
    echo "Error: El archivo no existe."
    exit 1
fi

# Solicitar al usuario el campo para ordenar
read -p "Ingrese el número del campo por el cual desea ordenar (separado por espacios si son múltiples): " campos_ordenar

# Solicitar al usuario el criterio para filtrar las líneas
read -p "Ingrese el criterio para filtrar las líneas (puede dejar en blanco si no desea filtrar): " criterio_filtrar

# Ordenar las líneas en función de los campos proporcionados
if [ -n "$campos_ordenar" ]; then
    sort -k"$campos_ordenar" -o "$archivo" "$archivo"
    echo "Líneas ordenadas en función del campo $campos_ordenar en el archivo: $archivo"
fi

# Filtrar las líneas que cumplen con el criterio proporcionado
if [ -n "$criterio_filtrar" ]; then
    grep "$criterio_filtrar" "$archivo" > "$archivo.filtrado"
    echo "Líneas filtradas en función del criterio \"$criterio_filtrar\" en el archivo: $archivo.filtrado"
fi


