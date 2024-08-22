#!/bin/bash
#comprobacion de que solo el root puede ejecutar
if [ $UID -ne 0 ]; then
	echo "no eres root sorry"
	exit 1
fi
#COMPROBACION de que se pasa solo un argumento
if [ $# -ne 1 ];then 
	echo "debe introducir un argumento"
	exit 2
fi

FICHERO=$1
#comrpobacion de que es un fichero regular
if [ ! -f $FICHERO ];then
	echo "no es un fichero regular error"
	exit 3
fi
#proceso de introducir grupos
for GRUPO in $(cat $FICHERO); do
	#procesamos el fichero para encontrar errores
	if [ -z $GRUPO ];then
	echo "no se especifico el grupo"
	elif grep -q $GRUPO /etc/group;then #el -q en el grep es para que no salga en pantalla
	echo "el grupo ya existe no se creara"
	elif [ ${#GRUPO} -gt 15 ];then
	echo "error nombre de grupo demasiado largo"
	else
	#se comprueba si existen los grupos
	#no se admiten grupos vacios
	#si borramos hasta el for y dejamos la linea de ABAJO funciona pero no prueba nada
	/usr/sbin/groupadd $GRUPO &>/dev/null #esto hace que no salga en pantalla el resultado del comando
	#comprobamos que el grupo se añadio al sistema
	if [ $? -eq 0 ];then
	echo "grupo añadido al sistema"
	else
	echo "fallo al añadir grupo"
	fi
	fi
done
