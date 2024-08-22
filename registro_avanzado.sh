#!/bin/bash
#
# Script para registrar información del sistema y detectar cambios en archivos importantes.
# Solo puede ser ejecutado por el usuario root.

# Verificar si el script es ejecutado como root
if [ "$EUID" -ne 0 ]; then
    echo "Error: Solo el usuario root puede ejecutar este script." >&2
    exit 1
fi

# Configuración
ARCHIVO_REGISTRO="registro_sistema.txt"
ARCHIVO_REGISTRO_ROTADO="registro_sistema_$(date +'%Y%m%d_%H%M%S').txt"
ARCHIVOS_IMPORTANTES="/etc/passwd /etc/shadow /etc/ssh/sshd_config"
DIRECTORIO_BACKUP="/var/backups"

# Crear el directorio de backup si no existe
if [ ! -d "$DIRECTORIO_BACKUP" ]; then
    mkdir -p "$DIRECTORIO_BACKUP"
fi

# Función para verificar y crear archivo de registro
verificar_archivo_registro() {
    if [ -f "$ARCHIVO_REGISTRO" ]; then
        # Rotar el archivo de registro si ya existe
        mv "$ARCHIVO_REGISTRO" "$DIRECTORIO_BACKUP/$ARCHIVO_REGISTRO_ROTADO"
        echo "Archivo de registro rotado a '$DIRECTORIO_BACKUP/$ARCHIVO_REGISTRO_ROTADO'."
    fi
    touch "$ARCHIVO_REGISTRO"
    echo "Archivo de registros creado: '$ARCHIVO_REGISTRO'."
}

# Función para obtener la información del sistema
registrar_informacion_sistema() {
    echo "------- Información del Sistema -------" | tee -a "$ARCHIVO_REGISTRO"
    echo "Fecha y Hora: $(date)" | tee -a "$ARCHIVO_REGISTRO"
    echo "Uptime: $(uptime)" | tee -a "$ARCHIVO_REGISTRO"
    echo "Espacio en Disco:" | tee -a "$ARCHIVO_REGISTRO"
    df -h | tee -a "$ARCHIVO_REGISTRO"
    echo "Uso de Memoria:" | tee -a "$ARCHIVO_REGISTRO"
    free -h | tee -a "$ARCHIVO_REGISTRO"
    echo "Usuarios Conectados:" | tee -a "$ARCHIVO_REGISTRO"
    who | tee -a "$ARCHIVO_REGISTRO"
    echo "Procesos en Ejecución:" | tee -a "$ARCHIVO_REGISTRO"
    ps aux | tee -a "$ARCHIVO_REGISTRO"
    echo "Actividad de Red:" | tee -a "$ARCHIVO_REGISTRO"
    netstat -tuln | tee -a "$ARCHIVO_REGISTRO"
    echo "---------------------------------------" | tee -a "$ARCHIVO_REGISTRO"
}

# Función para registrar cambios en archivos importantes
registrar_cambios_archivos() {
    echo "------- Cambios en Archivos Importantes -------" | tee -a "$ARCHIVO_REGISTRO"
    for archivo in $ARCHIVOS_IMPORTANTES; do
        if [ -e "$archivo" ]; then
            echo "Verificando archivo: $archivo" | tee -a "$ARCHIVO_REGISTRO"
            echo "Hash MD5 antes del registro:" | tee -a "$ARCHIVO_REGISTRO"
            md5sum "$archivo" | tee -a "$ARCHIVO_REGISTRO"
            echo "Contenido del archivo:" | tee -a "$ARCHIVO_REGISTRO"
            cat "$archivo" | tee -a "$ARCHIVO_REGISTRO"
            echo "----------------------------------------------" | tee -a "$ARCHIVO_REGISTRO"
        else
            echo "Advertencia: El archivo '$archivo' no existe." | tee -a "$ARCHIVO_REGISTRO"
        fi
    done
}

# Verificar y crear archivo de registro
verificar_archivo_registro

# Registrar información del sistema
registrar_informacion_sistema

# Registrar cambios en archivos importantes
registrar_cambios_archivos

echo "Actividades del sistema registradas en '$ARCHIVO_REGISTRO'."

