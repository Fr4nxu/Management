#!/bin/bash
#
# Script para registrar información del sistema en un archivo de registro.
# Solo puede ser ejecutado por el usuario root.

# Verificar si el script es ejecutado como root
if [ "$EUID" -ne 0 ]; then
    echo "Error: Solo el usuario root puede ejecutar este script." >&2
    exit 1
fi

# Archivo de registro
ARCHIVO_REGISTRO="registro_sistema.txt"

# Función para obtener la información de inicio de sesión
LOG_INICIO() {
    echo "------- Información de Inicio de Sesión -------" | tee -a "$ARCHIVO_REGISTRO"
    who >> "$ARCHIVO_REGISTRO"
    echo "---------------------------------------------" | tee -a "$ARCHIVO_REGISTRO"
}

# Función para registrar cambios en archivos importantes
LOG_CAMBIOS() {
    ARCHIVOS_IMPORTANTES="/etc/passwd /etc/shadow /etc/ssh/sshd_config"

    for archivo in $ARCHIVOS_IMPORTANTES; do
        if [ -e "$archivo" ]; then
            echo "------- Cambios en $archivo -------" | tee -a "$ARCHIVO_REGISTRO"
            cat "$archivo" >> "$ARCHIVO_REGISTRO"
            echo "-----------------------------------" | tee -a "$ARCHIVO_REGISTRO"
        else
            echo "Advertencia: El archivo '$archivo' no existe." | tee -a "$ARCHIVO_REGISTRO"
        fi
    done
}

# Verificar si el archivo de registro existe
if [ ! -f "$ARCHIVO_REGISTRO" ]; then
    read -p "El archivo de registros no existe. ¿Desea crearlo? (S/N): " OPCION
    case "$OPCION" in
        [Ss])
            touch "$ARCHIVO_REGISTRO"
            echo "Archivo de registros creado." ;;
        [Nn])
            echo "No se ha creado el archivo de registros. Saliendo del script."
            exit 1 ;;
        *)
            echo "Opción inválida. Salida del script." >&2
            exit 1 ;;
    esac
fi

# Registrar inicio de sesión
LOG_INICIO

# Registrar cambios en archivos importantes
LOG_CAMBIOS

echo "Actividades del sistema registradas en '$ARCHIVO_REGISTRO'."

