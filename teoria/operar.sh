#!/bin/bash
#
#operacion con error si no se introduce un numero o si no hay parametros

if [ "$#" -ne 2 ];then
	echo "debes introducir dos parametros"
	exit 1
elif [[ $1 =~ ^[0-9]+$  && $2 =~ ^[0-9]+$ ]]; then
	echo -n "SUMANDO LOS NUMEROS: "
	suma=$(($1 + $2))
	echo " la suma de $1 y $2 es $suma"
else
	echo "error en uno de los numeros"
fi

