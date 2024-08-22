#!/bin/bash
# borrar_syslog.sh
# truncar el archivo de log syslog manteniendo las últimas N líneas o reducirlo a un tamaño específico.

# funciones
function mensaje {
    local mensaje="$1"
    local fecha=$(date +"%b %d, %Y %H:%M:%S")
    echo "$(basename "$0"): $fecha -> $mensaje"
}

function mostrar_tamano_log {
    local tamano=$(du -sh "$FICHERO" | cut -f1)
    mensaje "El tamaño actual del archivo de log es: $tamano."
}

function programar_ejecucion {
    local dia="$1"
    (crontab -l 2>/dev/null; echo "0 0 * * $dia $(realpath "$0") $LINEAS $REDUCIR_MB") | crontab -
    mensaje "El script ha sido programado para ejecutarse todos los $dia."
}

# variables
FICHERO="/var/log/syslog"
DEFAULT_LINEAS=50
REDUCIR_MB=0

# Comprobaciones
if [ "$EUID" -ne 0 ]; then
    mensaje "Error: Este script debe ser ejecutado como root."
    exit 1
fi

# Verificación de archivo
if [ ! -f "$FICHERO" ]; then
    mensaje "Error: El archivo de log '$FICHERO' no existe."
    exit 3
fi

# Mostrar el tamaño actual del log
mostrar_tamano_log

# Opción de reducción por tamaño
read -p "¿Desea reducir el tamaño del log a un valor específico en MB o bytes? (S/N): " reducir_opcion
if [[ "$reducir_opcion" =~ ^[Ss]$ ]]; then
    read -p "Ingrese el tamaño deseado (Ejemplo: 5M para 5 MB o 500K para 500 KB): " REDUCIR_MB
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

# Programa
if [ -n "$REDUCIR_MB" ]; then
    
    cp "$FICHERO" "$FICHERO.bak"
    truncate -s "$REDUCIR_MB" "$FICHERO"
    mensaje "El archivo de log ha sido truncado a $REDUCIR_MB."
else
    
    if [ "$LINEAS" -ge 0 ]; then
        tail -n "$LINEAS" "$FICHERO" > "$FICHERO.TMP"
        mv "$FICHERO.TMP" "$FICHERO"
        mensaje "Borrado correcto de logs. Se han conservado las últimas $LINEAS líneas."
    else
        mensaje "Error: El número de líneas debe ser un valor no negativo."
        exit 4
    fi
fi

# Programar ejecución si el usuario lo desea
read -p "¿Desea programar este script para ejecutarse semanalmente? (S/N): " programar_opcion
if [[ "$programar_opcion" =~ ^[Ss]$ ]]; then
    read -p "Ingrese el día de la semana en que desea programar la ejecución (0=Domingo, 6=Sábado): " dia_semana
    programar_ejecucion "$dia_semana"
fi

exit 0
