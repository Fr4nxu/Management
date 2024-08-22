#!/bin/bash

# Función para crear un nuevo usuario
crear_usuario() {
    read -p "Ingrese el nombre del nuevo usuario: " nuevo_usuario
    sudo useradd "$nuevo_usuario"

    read -p "asignado a grupo "
    read -p "Ingrese el nombre del nuevo grupo: " nuevo_grupo
        sudo addgroup "$nuevo_grupo"
        sudo usermod -aG "$nuevo_grupo" "$nuevo_usuario"
        echo "Usuario '$nuevo_usuario' añadido al grupo '$nuevo_grupo'."

    read -p "¿Desea configurar una contraseña para el nuevo usuario? (S/N): " configurar_contraseña
    if [ "$configurar_contraseña" == "S" ] || [ "$configurar_contraseña" == "s" ]; then
        sudo passwd "$nuevo_usuario"
        echo "Contraseña configurada para el usuario '$nuevo_usuario'."
    elif [ "$configurar_contraseña" == "N" ] || [ "$configurar_contraseña" == "n" ]; then
	echo "entendido saliendo del programa"
	exit 1
    else
	echo "opcion incorrecta"
	exit 1
    fi
}

# Función principal
main() {
    read -p "¿Desea crear un nuevo usuario? (S/N): " crear_nuevo_usuario
    if [ "$crear_nuevo_usuario" == "S" ] || [ "$crear_nuevo_usuario" == "s" ]; then
        crear_usuario
    elif [ "$crear_nuevo_usuario" == "N" ] || [ "$crear_nuevo_usuario" == "n" ]; then
        echo "No se crearon nuevos usuarios. Saliendo del script."
    else
        echo "Opción no válida. Saliendo del script."
        exit 1
    fi
}

# Ejecutar el script principal
main

