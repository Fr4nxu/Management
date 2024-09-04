#!/bin/bash
#suma.sh
# Recibira dos numeros por parametro y los sumara
#control de numero de parametros
if [ $# -ne 2 ]; then
	echo "error: se esperaban dos parametros"
	echo "uso del programa: $0 num1 num2 "
	exit 1
fi
#recibimos dos parametros, y hacemos la suma 
((SUMA=$1 + $2))
echo "la suma de $1 y $2 es :$SUMA"
