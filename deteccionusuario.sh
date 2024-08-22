#!/bin/bash

if [ $UID -eq 0 ];then
	echo "buenas root"
fi



usuario=$(getent passwd $USER | cut -d ':' -f 5)

hora=$(date +%H)

if [ "$hora" -lt 14 ];then
	saludo="buenos dias"
else
	saludo="buenas tardes"
fi

if [ -n "$usuario" ];then
	echo "$saludo, $usuario"
else
	echo "$saludo, $USER"
fi

