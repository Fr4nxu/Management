#!/bin/bash

# ayuda
mostrar_ayuda() {
    echo "Uso: $0 dir1 dir2 dir3 ..."
    echo "Este script calcula y muestra el espacio utilizado por cada subdirectorio dentro de los directorios proporcionados."
    exit 0
}

if [ "$1" == "-h" ]; then
    mostrar_ayuda
fi

#argumentos
if [ $# -lt 1 ]; then
    echo "Error: No se proporcionaron directorios."
    echo "Uso: $0 dir1 dir2 dir3 ..."
    exit 1
fi

# Itera sobre cada directorio proporcionado como argumento
for DIR in "$@"; do
    if [ -d "$DIR" ]; then
        echo "====================================="
        echo "Directorio: $DIR"
        echo "====================================="
        # Usa un bucle para calcular el espacio de cada subdirectorio
        if [ "$(ls -A "$DIR")" ]; then
            for SUBDIR in "$DIR"/*; do
                if [ -d "$SUBDIR" ]; then
                    # Calcular y mostrar el espacio de cada subdirectorio
                    du -sh "$SUBDIR" 2>/dev/null || echo "Error al calcular el espacio de $SUBDIR"
                fi
            done
        else
            echo "El directorio $DIR está vacío."
        fi
    else
        echo "Error: $DIR no es un directorio válido o no se puede acceder."
    fi
done
