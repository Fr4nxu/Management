#!/bin/bash
#control de parametros
if [ $# -ne 1 ];then
	echo "ERROR INESPERADO POR PARAMETRO"
	echo -e "\n !!!!! INGRESE EL NUMERO DE PARAMETROS CORRECTO !!!!!"
	echo -e	   "\n USO DEL PROGRAMA: $0 nombre de archivo"
	exit 1
fi
#echo $#
#echo $*
#
#comprobar si el parametro es correcto y es un archivo
if [ -f $1 ];then
	echo "$1 ES UN ARCHIVO"
fi
exit 0
