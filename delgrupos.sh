#!/bin/bash
#delgrupos.sh
if [ $UID -ne 0 ]; then
   echo "Debes ser root para ejecutar este script"
   exit 1
elif [ $# -ne 1 ]; then
   echo "Debe haber un parametro"
   echo "Sintaxis correcta: $0 fich"
   exit 2
elif ! [ -f "$1" ]; then
   echo "$1 no es un fichero o no existe"
   exit 3
else
   FICHERO="$1"
   for GRUPO in $(cat "$FICHERO"); do
      echo "Procesando la fila: $GRUPO"
      if [ -z $GRUPO ]; then
         echo "Fila anulada. No se ha especificado el grupo"
      elif grep -qE "^$GRUPO:" /etc/group; then  #q en modo silencioso
         /usr/sbin/groupdel $GRUPO &>/dev/null
         if [ $? -eq 0 ]; then
            echo "El grupo $GRUPO se ha borrado con exito"
         else
            echo "El grupo $GRUPO no se ha podido eliminar"
         fi
      else
         echo "Fila anulada. El grupo no existe, por lo que no se puede eliminar"
      fi
   done
fi
