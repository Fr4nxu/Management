#!/bin/bash

# Función para generar una contraseña aleatoria
CONTRASEÑA() {
    tr -dc '[:alnum:]' < /dev/urandom | head -c 16
}

# Archivo de contraseñas
ARCHIVO_CONTRA="contraseñas.txt"

# Verificar si el archivo de contraseñas existe
if [ ! -f "$ARCHIVO_CONTRA" ]; then
    read -p "El archivo de contraseñas no existe. ¿Desea crearlo? (S/N): " OPCION
    if [ "$OPCION" = S ] || [ "$OPCION" = s ]; then
        touch "$ARCHIVO_CONTRA"
        echo "Archivo de contraseñas creado."
    elif [ "$OPCION" = N ] || [ "$OPCION" = n ];then
        echo "No se ha creado el archivo de contraseñas. Saliendo del script."
        exit 1
    fi
fi

# Generar una contraseña aleatoria
NUEVA_CONTRA=$(CONTRASEÑA)

# Almacenar la contraseña en el archivo de contraseñas
echo "Contraseña generada: $NUEVA_CONTRA" >> "$ARCHIVO_CONTRA"

echo "Contraseña generada y almacenada en '$ARCHIVO_CONTRA'."

