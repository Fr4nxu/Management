#!/bin/bash

# Pedir al usuario los directorios
read -p "Ingrese el directorio que desea respaldar: " directorio_origen
read -p "Ingrese el directorio de destino para la copia de seguridad: " directorio_destino

# Verificar si los directorios existen
if [ ! -d "$directorio_origen" ]; then
    echo "Error: El directorio de origen no existe."
    exit 1
fi

if [ ! -d "$directorio_destino" ]; then
    echo "Error: El directorio de destino no existe."
    exit 1
fi

# Configuración
archivo_log="registro_copia_seguridad.log"

# Verificar si el archivo de log existe
if [ ! -f "$archivo_log" ]; then
    touch "$archivo_log"
fi

# Función para realizar copia de seguridad incremental
realizar_copia_seguridad() {
    fecha_actual=$(date +"%Y%m%d_%H%M%S")
    echo "Realizando copia de seguridad en $fecha_actual" >> "$archivo_log"

    rsync -a --delete --backup --backup-dir="$directorio_destino/respaldo_$fecha_actual" "$directorio_origen" "$directorio_destino" >> "$archivo_log"

    echo "Copia de seguridad completada." >> "$archivo_log"
}

# Realizar copia de seguridad
realizar_copia_seguridad

# Programar copia de seguridad automática (cada día a las 2 AM)
echo "0 2 * * * $(pwd)/script_backup.sh" | crontab -

echo "Cron configurado para realizar copias de seguridad automáticas todos los días a las 2 AM."

