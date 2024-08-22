#!/bin/bash
clear
while true;do

	echo "Menu para usuario:"
	echo "1. Lista archivos del directorio actual"
	echo "2. comprime los archivos del directorio actual"
	echo "3. borra los archivos del directorio actual"
	echo "4. muestra la ubicacion actual"
	echo "5. reinicar el sitema."
	echo "6. apagar el sistema"
	echo "7. salir"

	read -p "Introduce la opcion: " OPCION
case $OPCION in 
	1)
		ls
		;;
	2)
		read -p "Nombre que le dara al comprimir: " NOMBRE_ARCHIVO
		zip -r "$NOMBRE_ARCHIVO.zip" *
		echo "archivos comprimidos"
		;;
	3)
		read -p "Nombre de la extension a borrar (ejemplo *.txt): " EXTENSION
		read -p "seguro que quieres borrarlos: " OPCION2
		if [ "$OPCION2" = S ] || [ "$OPCION2" = s ];then
			echo "borrando archivos"
			sleep 1
		rm -r $EXTENSION
		elif [ "$OPCION2" = N ] || [ "$OPCION2" = n ];then
			echo "no se borraran los archivos"
			sleep 1
		else
			echo "fallo en opcion"
		fi
		;;
	4)
		pwd
		;;
	5)
		reboot
		;;
	6)
		shutdown -h now
		;;
	7)
		echo "adios"
		sleep 1
		exit 0
		;;
	*)
		echo "opcion no valida"
		;;
esac
done
