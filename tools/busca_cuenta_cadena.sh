#!/bin/bash
#buscar una cadena en un archivo con opciones

# ayuda
mostrar_ayuda() {
    echo "Uso: $0 [-i] [-c] <cadena> <archivo>"
    echo "Opciones:"
    echo "  -i    Búsqueda insensible a mayúsculas/minúsculas"
    echo "  -c    Contar el número total de ocurrencias de la cadena"
    echo "  -h    Muestra esta ayuda"
    exit 0
}

#variables
ignore_case=""
count_occurrences=false

#opciones
while getopts ":ic:h" opt; do
    case ${opt} in
        i )
            ignore_case="-i"
            ;;
        c )
            count_occurrences=true
            ;;
        h )
            mostrar_ayuda
            ;;
        \? )
            echo "Opción inválida: -$OPTARG" >&2
            mostrar_ayuda
            ;;
    esac
done
shift $((OPTIND -1))

#argumentos
if [ $# -ne 2 ]; then
    echo "Error: Número incorrecto de argumentos."
    mostrar_ayuda
fi

#segundo argumento archivo y que no esté vacío
if ! [ -f "$2" ]; then
    echo "Error: $2 no es un archivo válido."
    exit 2
elif [ ! -s "$2" ]; then
    echo "Error: El archivo $2 está vacío."
    exit 3
fi

# buscar la cadena en el archivo
RESGREP=$(grep -n $ignore_case "$1" "$2")

# Si no se encuentra la cadena
if [ -z "$RESGREP" ]; then
    echo "La cadena '$1' no se encontró en el archivo '$2'."
    exit 0
fi

# opción -c activada, contar las ocurrencias
if $count_occurrences; then
    total_ocurrencias=$(echo "$RESGREP" | grep -o $ignore_case "$1" | wc -l)
    echo "La cadena '$1' aparece un total de $total_ocurrencias veces en el archivo '$2'."
    exit 0
fi

#mostrar las ocurrencias línea por línea
while IFS= read -r FILA; do
    LINEA=$(echo "$FILA" | cut -d":" -f1)
    CONTENIDO=$(echo "$FILA" | cut -d":" -f2-)
    OCURRENCIA=$(echo "$CONTENIDO" | grep -o $ignore_case "$1" | wc -l)
    echo "La cadena '$1' aparece en la línea $LINEA el siguiente número de veces: $OCURRENCIA"
done <<< "$RESGREP"
