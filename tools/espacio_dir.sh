#!/bin/bash


# Verifica si se pasaron argumentos
if [ $# -lt 1 ]; then
    echo "Uso: $0 dir1 dir2 dir3 ..."
    exit 1
fi

# Itera sobre cada directorio proporcionado como argumento
for DIR in "$@"; do
    if [ -d "$DIR" ]; then
        echo "Directorio: $DIR"
        # Usa un bucle para calcular el espacio de cada subdirectorio
        for SUBDIR in "$DIR"/*; do
            if [ -d "$SUBDIR" ]; then
                # Calcular y mostrar el espacio de cada subdirectorio
                du -sh "$SUBDIR"
            fi
        done
    else
        echo "$DIR no es un directorio"
    fi
done

