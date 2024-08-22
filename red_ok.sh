#!/bin/bash

clear
if [ $UID -eq 0 ];then
	echo "buenas root"
else
	echo "solo root puede ejecutarlo"
fi
direcciones_totales=0
accesibles=0
inaccesibles=0


if [ $# -eq 0 ];then
	echo "sin ips"
	exit 1
fi
for DIR_IP in "$@"; do
	direcciones_totales=$((direcciones_totales + 1))
	if ping -c 1 "$DIR_IP" &> /dev/null ;then
		accesibles=$((accesibles + 1))
		echo "la direccion $DIR_IP es accesible"
	else
		inaccesibles=$((inaccesibles + 1))
		echo "la direccion $DIR_IP es inaccesible"
	fi
done
echo "total de direcciones recibidas: $direcciones_totales"
echo "total de direcciones accesibles: $accesibles"
echo "total de direcciones inaccesibles: $inaccesibles"
