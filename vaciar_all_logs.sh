#!/bin/bash
#vaciar_all_logs.sh
# Zona de funciones
function mensaje {
   FECHA=$(date +"%b,%x-%X")
   echo "`basename $0`: $FECHA -> $1"
}
# Zona de variables
DIRECTORIO="/var/log/*log"
LINEAS=50
A=0   #Variable que cuenta los ficheros procesados
# Comprobaciones
if [ $UID -ne 0 ]; then
   mensaje "Error: debe ser root"
   exit 1
elif [ -z "$(echo $DIRECTORIO)" ]; then
   mensaje "Error: no hay ficheros con log en su nombre en /var/log"
   exit 2
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
   for FICHERO in $DIRECTORIO; do
      if [ -f "$FICHERO" ]; then
         tail -n $L "$FICHERO" > "$FICHERO.TMP"
         mv "$FICHERO.TMP" "$FICHERO"
         ((A++))
      fi
   done
   mensaje "Borrado correcto de logs..."
   echo "Se han procesado $A ficheros"
fi
