#!/bin/bash
#grep.sh
if [ $# -ne 2 ]; then
   echo "Numero de argumentos erroneos"
   echo "Sintaxis correcta $0 fich"
   exit 1
elif ! [ -f $2 ]; then
   echo "$2 no es un fichero"
   exit 2
else
   RESGREP=$(grep -n "$1" "$2")
   if [ ${#RESGREP} -eq 0 ]; then
      echo "La cadena $1 no se encontro en el fichero $2"
      exit 0
   else
      for FILA in $RESGREP; do
         LINEA=$(echo $FILA | cut -d":" -f1)
         CONTENIDO=$(echo $FILA | cut -d":" -f2)
         OCURRENCIA=$(echo $CONTENIDO | grep -o $1 | wc -l)
         echo "La cadena $1 aparece en la linea $LINEA el siguiente numero de veces: $OCURRENCIA"
      done
   fi
fi
