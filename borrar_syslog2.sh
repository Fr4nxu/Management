#!/bin/bash
# borrar_syslog.sh
# Script para truncar el archivo de log syslog manteniendo las últimas N líneas.

# Zona de funciones
function mensaje {
    local mensaje="$1"
    local fecha=$(date +"%b %d, %Y %H:%M:%S")
    echo "$(basename "$0"): $fecha -> $mensaje"
}

# Zona de variables
FICHERO="/var/log/syslog"
DEFAULT_LINEAS=50

# Comprobaciones
if [ "$EUID" -ne 0 ]; then
    mensaje "Error: Este script debe ser ejecutado como root."
    exit 1
fi

# Comprobamos el argumento introducido
if [ -n "$1" ]; then
    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        mensaje "Error: El argumento '$1' no es un número válido."
        exit 2
    fi
    LINEAS="$1"
else
    LINEAS="$DEFAULT_LINEAS"
fi

# Verificación de archivo
if [ ! -f "$FICHERO" ]; then
    mensaje "Error: El archivo de log '$FICHERO' no existe."
    exit 3
fi

# Programa
if [ "$LINEAS" -ge 0 ]; then
    tail -n "$LINEAS" "$FICHERO" > "$FICHERO.TMP"
    mv "$FICHERO.TMP" "$FICHERO"
    mensaje "Borrado correcto de logs. Se han conservado las últimas $LINEAS líneas."
else
    mensaje "Error: El número de líneas debe ser un valor no negativo."
    exit 4
fi

exit 0

