#!/bin/bash
#addgrupos.sh
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
      elif grep -q $GRUPO /etc/group; then  #q en modo silencioso
         echo "El grupo ya existe. No lo creamos"
      elif [ ${#GRUPO} -gt 15 ]; then
         echo "El grupo $GRUPO supera los 15 caracteres y por lo tanto no se crea."
      else
         /usr/sbin/groupadd $GRUPO &>/dev/null
         if [ $? -eq 0 ]; then
            echo "Grupo $GRUPO añadido al sistema"
         else
            echo "El grupo $GRUPO no se ha añadido correctamente al sistema"
         fi
      fi
   done
fi
