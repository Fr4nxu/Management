#!/bin/bash
#delusuarios.sh
#comprobamos si es sudo
if [ $UID -ne 0 ]; then
   echo "Debes ser root para ejecutar este script"
   exit 1
#comprobamos que se pasa un parametro
elif [ $# -ne 1 ]; then
   echo "Debe haber un parametro"
   echo "Sintaxis correcta: $0 fich"
   exit 2
#comprobamos que es un fichero
elif ! [ -f "$1" ]; then
   echo "$1 no es un fichero o no existe"
   exit 3
else
#procesos del script con comprobaciones internas
   FICHERO="$1"
   for LINEA in $(cat "$FICHERO"); do
      #Extraemos información
      echo "Procesando la fila: $LINEA"
      USUARIO=$(echo $LINEA | cut -d"," -f1)
      GRUPO=$(echo $LINEA | cut -d"," -f2)
	#comprobamos que la fila es valida 
      if [ -z $USUARIO ]; then
         echo "Fila anulada. No se ha especificado el usuario"
	#comprobamos que la fila es valida
      elif [ -z $GRUPO ]; then
         echo "Fila anulada. No se ha especificado el grupo"
      else
	#busca si el usuario existe y lo elimina 
         if cat /etc/passwd | cut -d"." -f1 | grep -q $USUARIO; then   # otra forma seria id $USUARIO &>/dev/null
            /usr/sbin/userdel $USUARIO &>/dev/null
	#elimina el grupo despues de eliminar al usuario
            if [ $? -eq 0 ]; then
               echo "El usuario $USUARIO se ha eliminado, procedo a eliminar el grupo"
               /usr/sbin/groupdel $GRUPO &>/dev/null
		#comprobacion de que todo salio bien o si hay algun error
               if [ $? -eq 0 ]; then
                  echo "Grupo $GRUPO eliminado con exito"
               else
                  echo "El grupo $GRUPO no se ha podido eliminar"
               fi
            else
               echo "No se ha eliminado correctamente el usuario $USUARIO"
            fi
         else
            echo "El usuario $USUARIO no existe, por lo que no se elimina"
         fi
      fi
   done
fi

