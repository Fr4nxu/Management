#!/bin/bash

# Verificar si se proporciona un archivo como argumento
if [ "$#" -eq 0 ]; then
    echo "Uso: $0 <archivo>"
    exit 1
fi

# Obtener el nombre del archivo desde el primer argumento
archivo="$1"

# Verificar si el archivo existe
if [ ! -e "$archivo" ]; then
    echo "Error: El archivo no existe."
    exit 1
fi

# Contar el número total de palabras en el archivo
num_palabras=$(wc -w < "$archivo")

# Mostrar el número total de palabras
echo "Número total de palabras en el archivo '$archivo': $num_palabras"

# Mostrar las palabras más frecuentes
echo -e "\nPalabras más frecuentes:"
awk '{for(i=1;i<=NF;i++) palabra[$i]++} END{for(p in palabra) print p, palabra[p]}' "$archivo" | sort -k2,2nr | head -n 10

