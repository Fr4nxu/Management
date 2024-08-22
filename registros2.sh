#!/bin/bash
#
#
#
#para que solo el usuario root pueda ejecutar esto
if [ $UID -ne 0 ];then
	echo "solo el root puede ejecutar este script"
	exit 1
fi

# Archivo de registro
ARCHIVO_REGISTRO="registro_sistema.txt"

# Función para obtener la información de inicio de sesión
LOG_INICIO() {
    who >> "$ARCHIVO_REGISTRO"
}

# Función para registrar cambios en archivos importantes
LOG_CAMBIOS() {
    ARCHIVOS_IMPORTANTES="/etc/passwd /etc/shadow /etc/ssh/sshd_config"

    for archivo in $ARCHIVOS_IMPORTANTES; do
        if [ -e "$archivo" ]; then
            echo "------- Cambios en $archivo -------" | sudo tee -a "$ARCHIVO_REGISTRO"
            sudo  cat "$archivo" >> "$ARCHIVO_REGISTRO"
            echo "-----------------------------------" | sudo tee -a "$ARCHIVO_REGISTRO"
        fi
    done
}

# Verificar si el archivo de registro existe
if [ ! -f "$ARCHIVO_REGISTRO" ]; then
    read -p "El archivo de registros no existe. ¿Desea crearlo? (S/N): " OPCION
    if [ "$OPCION" = S ] || [ "$OPCION" = s ]; then
        touch "$ARCHIVO_REGISTRO"
        echo "Archivo de registros creado."
    elif [ "$OPCION" = N ] || [ "$OPCION" = n ];then
        echo "No se ha creado el archivo de registros. Saliendo del script."
        exit 1
    fi
fi

# Registrar inicio de sesión
LOG_INICIO

# Registrar cambios en archivos importantes
LOG_CAMBIOS

echo "Actividades del sistema registradas en '$ARCHIVO_REGISTRO'."

