#!/bin/bash
echo -n "Escribe un numero:" 
read X
if [ $X -lt 10 ]; then
	echo "$X es menor que 10"
else
	if [ $X -gt 10 ] ; then
		echo "$X es mayor que 10"
	else
		echo "$X es igual que 10"
	fi
fi
