#!/bin/bash
#addusuarios.sh
if [ $UID -ne 0 ]; then
   echo "Debes ser root para ejecutar este script"
   exit 1
#comrpobacion de los parametros
elif [ $# -ne 1 ]; then
   echo "Debe haber un parametro"
   echo "Sintaxis correcta: $0 fich"
   exit 2
#comrpobacion de que es un fichero
elif ! [ -f "$1" ]; then
   echo "$1 no es un fichero o no existe"
   exit 3
else
#proceso del script con conprobaciones adicionales dentro del proceso
   FICHERO="$1"
   for LINEA in $(cat "$FICHERO"); do
      #Extraemos información
      echo "Procesando la fila: $LINEA"
      USUARIO=$(echo $LINEA | cut -d"," -f1)
      GRUPO=$(echo $LINEA | cut -d"," -f2)
      CLAVE=$(echo $LINEA | cut -d"," -f3)
	#comprobacion de que hay usuario
      if [ -z $USUARIO ]; then
         echo "Fila anulada. No se ha especificado el usuario"
	#comprobacion de que hay grupo
      elif [ -z $GRUPO ]; then
         echo "Fila anulada. No se ha especificado el grupo"
	#comprobacion de que hay clave
      elif [ -z $CLAVE ]; then
         echo "Fila anulada. No se ha especificado la contraseña"
	 #comprobacion de que el usuario es demasiado largo para el programa
      elif [ ${#USUARIO} -gt 15 ]; then
         echo "El usuario $USUARIO supera los 15 caracteres y por lo tanto no se crea"
      else
	#comprobacion de que el grupo existe y si no lo crea
         if grep -q $GRUPO /etc/group; then  #q en modo silencioso
            echo "El grupo ya existe. No lo creamos"
         else
            /usr/sbin/groupadd $GRUPO
	#añadimos el grupo creado al sistema o damos un error
            if [ $? -eq 0 ]; then
               echo "Grupo $GRUPO añadido al sistema"
            else
               echo "El grupo $GRUPO no se ha podido añadir al sistema"
            fi
         fi
	#comprobacion de que el usuario existe si no lo crea
         if cat /etc/passwd | cut -d"." -f1 | grep -q $USUARIO; then
            echo "El usuario ya existe. No lo creamos"
         else
            /usr/sbin/useradd -m -g $GRUPO $USUARIO &> /dev/null
	 #añadimos el usuario al sistema o damos un error 
            if [ $? -eq 0 ]; then
               echo "Usuario $USUARIO añadido al sistema"
            else
               echo "El usuario $USUARIO no se ha podido añadir al sistema"
            fi
	#asignamos la contraseña o damos un error
            echo "$USUARIO:$CLAVE" | chpasswd  &> /dev/null
            if [ $? -eq 0 ]; then
               echo "Al usuario $USUARIO se le asigno la clave $CLAVE"
            else
               echo "No se le ha asignado la clave correctamente al usuario $USUARIO"
            fi
         fi
      fi
   done
fi
#termina el script
