#!/bin/bash
#controles

if [ $UID -ne 0 ];then
	echo "solo root puede ejecutarlo"
	exit 1
fi

read -p "nombre del paquete:" PAQUETE
apt list --installed | grep -w $PAQUETE >& /dev/null
if [ "$?" -eq 0 ];then
VERSION=$(dpkg-query -W "$PAQUETE" | cut -f 2)
	echo  "El paquete esta instalado en su version:$VERSION"
else
	echo "el paquete $PAQUETE no esta instaldo"
	read -p "quieres instalarlo " OPCION2
	if [ "$OPCION2" == y ] || [ "$OPCION2" == Y ];then
		echo -n "instalando paquete: "
		sudo apt-get install $PAQUETE
	elif [ "$OPCION2" == n ] || [ "$OPCION2" == N ]; then
		echo "saliendo del programa"
	else
		echo "error al elegir opcion"
	fi

fi



