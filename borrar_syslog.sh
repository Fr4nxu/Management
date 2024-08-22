#!/bin/bash
#borrar_syslog.sh
# Zona de funciones
function mensaje {
   FECHA=$(date +"%b,%x-%X")
   echo "`basename $0`: $FECHA -> $1"
}
# Zona de variables
FICHERO="/var/log/syslog"
LINEAS=50

# Comprobaciones
if [ "$UID" -ne 0 ]; then
   mensaje "Error: debe ser root" 
   exit 1
else

# Comprobamos el posible argumento introducido
# No introducen nada (entonces 50), introducen algo que no es numérico (me salgo) o introducen un valor numérico (entonces, ese es el valor)
   case "$1" in
   "")  #vacio
      L=$LINEAS
      ;;
   *[!0-9]*)  #algo de numerico
      mensaje "Error: $1 argumento inválido"
      exit 2
      ;;
   *)  #Numero
      L=$1
      ;;
   esac

# Programa
   tail -n $L $FICHERO > $FICHERO.TMP
   mv $FICHERO.TMP $FICHERO
   mensaje "Borrado correcto de logs..."
   exit 0
fi
