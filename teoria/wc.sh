#!/bin/bash
#wc.sh
if [ $# -ne 1 ]; then
   echo "Numero de argumentos erroneos"
   echo "Sintaxis correcta $0 fich"
   exit 1
elif ! [ -f $1 ]; then
   echo "$1 no es un fichero"
   exit 2
else
   echo "El numero de lineas del fichero $1 es: $(wc -l < $1)"
   echo "El numero de palabras del fichero $1 es: $(wc -w < $1)"
   echo "El numero de caracteres del fichero $1 es: $(wc -m < $1)"
fi
