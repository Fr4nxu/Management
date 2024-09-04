#!/bin/bash

# Función contraseña aleatoria
generar_contrasena() {
    # Longitud
    local longitud=16
    tr -dc '[:alnum:][:punct:]' < /dev/urandom | head -c "$longitud"
}

# archivo contraseñas
ARCHIVO_CONTRA="contraseñas.txt"

# verificar si el archivo de contraseñas existe
if [ ! -f "$ARCHIVO_CONTRA" ]; then
    while true; do
        read -p "El archivo de contraseñas no existe. ¿Desea crearlo? (S/N): " OPCION
        case "$OPCION" in
            [Ss]* ) 
                touch "$ARCHIVO_CONTRA"
                echo "Archivo de contraseñas creado."
                break
                ;;
            [Nn]* )
                echo "No se ha creado el archivo de contraseñas. Saliendo del script."
                exit 1
                ;;
            * )
                echo "Por favor, responda S (sí) o N (no)."
                ;;
        esac
    done
fi

# generar contraseña aleatoria
NUEVA_CONTRA=$(generar_contraseña)

# guardar la contraseña en el archivo de contraseñas 
{
    echo "Contraseña generada: $NUEVA_CONTRA"
} >> "$ARCHIVO_CONTRA"

# comprobar si la operación de escritura fue exitosa
if [ $? -eq 0 ]; then
    echo "Contraseña generada y almacenada en '$ARCHIVO_CONTRA'."
else
    echo "Error al almacenar la contraseña en '$ARCHIVO_CONTRA'."
    exit 1
fi
