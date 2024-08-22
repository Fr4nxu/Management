#!/bin/bash

# Solicitar al usuario el directorio de origen
read -p "Ingrese la ruta del directorio de origen (carpeta a limpiar): " directorio_origen

# Verificar si el directorio de origen existe
if [ ! -d "$directorio_origen" ]; then
    echo "Error: El directorio de origen no existe."
    exit 1
fi

# Solicitar al usuario el directorio de respaldo
read -p "Ingrese la ruta del directorio de respaldo (donde se moverán los archivos antes de eliminarlos): " directorio_respaldo

# Verificar si el directorio de respaldo existe, si no, crearlo
if [ ! -d "$directorio_respaldo" ]; then
    mkdir -p "$directorio_respaldo"
    echo "Directorio de respaldo creado en $directorio_respaldo"
fi

# Solicitar al usuario la extensión de archivo a eliminar
read -p "Ingrese la extensión de archivo a eliminar (sin el punto): " extension

# Mover archivos al directorio de respaldo
echo "Moviendo archivos con la extensión .$extension a $directorio_respaldo..."
mv "$directorio_origen"/*."$extension" "$directorio_respaldo"/

# Mostrar mensaje de éxito
echo "Archivos movidos correctamente a $directorio_respaldo."

# Confirmar la eliminación permanente
read -p "¿Desea eliminar permanentemente los archivos de $directorio_respaldo? (S/N): " confirmacion
if [ "$confirmacion" == "S" ] || [ "$confirmacion" == "s" ]; then
    rm -f "$directorio_respaldo"/*."$extension"
    echo "Archivos eliminados permanentemente de $directorio_respaldo."
elif [ "$confirmacion" == "N" ] || [ "$confirmacion" == "n" ]; then
    echo "No se eliminaron permanentemente los archivos."
else
    echo "Opción no válida. No se eliminaron permanentemente los archivos."
fi

