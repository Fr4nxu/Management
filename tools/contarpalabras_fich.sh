#!/bin/bash 
#
#
#
#
clear
if [ $# -eq 0 ];then 
	echo "error se esperan dos parametros primero el fichero y despues la palabra:"
	sleep 1
	exit 1
fi


fichero=$1
palabra=$2

lineas=$(grep -i -w "$palabra" "$fichero" | wc -l)




if [ -f "$fichero" ];then
	echo  "es un fichero, contando lineas"
	sleep 2
	echo "tiene $lineas lineas"
	sleep 2
	exit 0
elif [ -d "$fichero" ];then
	echo "no es un fichero, es un directorio"
	sleep 1
	echo "ERROR!!!"
	sleep 1
	echo "saliendo del programa"
	sleep 2
else
	exit 1
fi

