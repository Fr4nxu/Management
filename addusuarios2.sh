#!/bin/bash
#comprobaciones previas
#solo root puede ejecutarlo pero se comprueba a traves de una variable 
ROOT_ID=0
if [ $UID -ne $ROOT_ID ]; then
	echo "acceso denegado"
	exit 1
fi
#introducir un argumento
if [ $# -ne 1 ];then
	echo "debe introducir al menos un argumento(fichero)"
	exit 2
fi
#el siguiente paso es ver si el paramento es valido
FICHERO=$1
if [ ! -f $FICHERO ];then
	echo "el $FICHERO no es un fichero regular"
	exit 3
fi
#proceso principal del scrip despues de las comprobaciones
for LINEA in $(cat $FICHERO); do
	#extraemos la info del fichero con cut
	USUARIO=$(echo $LINEA | cut -d "," -f1)
	GRUPO=$(echo $LINEA | cut -d "," -f2)
	CLAVE=$(echo $LINEA | cut -d "," -f3)
	echo "creando al usuario"
	#comando para crear usuarios en linux
	/usr/sbin/useradd -m -g $GRUPO $USUARIO
	#asignacion de contraseña
	echo "$USUARIO:$CLAVE" | chpasswd
done

