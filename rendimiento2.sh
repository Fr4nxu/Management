#!/bin/bash

# Archivo de salida para el informe
informe_archivo="informe_rendimiento.txt"

# Función para agregar información al informe
agregar_al_informe() {
    local seccion="$1"
    local comando="$2"
    echo -e "\n[$seccion]\n" | tee -a "$informe_archivo"
    eval "$comando" >> "$informe_archivo"
}

# Verificar si el archivo de informe existe, si no, crearlo
if [ ! -e "$informe_archivo" ]; then
    touch "$informe_archivo" || { echo "Error: No se pudo crear el archivo de informe."; exit 1; }
fi

# Obtener la fecha y hora actual para el informe
fecha_actual=$(date +"%Y-%m-%d %H:%M:%S")

# Encabezado del informe
echo "Informe de Rendimiento del Sistema - $fecha_actual" | tee -a "$informe_archivo"
echo "--------------------------------------------------" | tee -a "$informe_archivo"

# Información de la CPU
agregar_al_informe "Información de la CPU" "lscpu"

# Uso de la CPU
agregar_al_informe "Uso de la CPU" "mpstat 1 3"

# Información de la memoria RAM
agregar_al_informe "Información de la Memoria RAM" "free -h"

# Uso de la memoria RAM por proceso
agregar_al_informe "Uso de la Memoria RAM por Proceso" "ps aux --sort=-%mem | awk 'NR<=10{print \$0}'"

# Información de uso del disco
agregar_al_informe "Información de Uso del Disco" "df -h"

# Uso del disco por directorio
agregar_al_informe "Uso del Disco por Directorio" "du -h --max-depth=1 / 2>/dev/null | sort -hr"

# Información sobre la red
agregar_al_informe "Información de Red" "ss -tuln"

# Cambiar la propiedad del archivo al usuario actual
chown "$USER:$USER" "$informe_archivo" || { echo "Error: No se pudo cambiar la propiedad del archivo."; exit 1; }

echo "Informe de rendimiento generado en: $informe_archivo"

