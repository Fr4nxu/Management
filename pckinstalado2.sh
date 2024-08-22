#!/bin/bash
#controles

if [ $UID -ne 0 ];then
	echo "solo root puede ejecutarlo"
	exit 1
fi

apt list --installed | grep -w $1 >& /dev/null
if [ "$?" -eq 0 ];then
VERSION=$(dpkg-query -W "$1" | cut -f 2)
	echo  "El paquete esta instalado en su version:$VERSION"
else
	echo "el paquete $1 no esta instaldo"
	read -p "quieres instalarlo(y/Y)(n/N) " OPCION2
	if [ y == "$OPCION2" ] || [ Y = "$OPCION2" ] ;then
		echo -n "instalando paquete: "
		sudo apt-get install $1
	elif [ n == "$OPCION2" ] || [ N == "$OPCION2" ] ;then
		echo "saliendo del programa"
	else
		echo "error al escoger opcion"
	fi

fi



