#!/bin/bash
#
#
#
# solo por administrador que siempre queda bonito
if [ $UID -ne 0 ];then
        echo "solo root puede ejecutarlo"
        exit 1
fi

clear
#directorios
read -p "directorio completo a copiar: " DIRECTORIO_DIR
read -p "directorio completo donde se enviara la copia: " COPIA_DIR
LOG="$COPIA_DIR/backup.log"

# crea un directorio si no existe
if [ ! -d "$COPIA_DIR" ]; then
    mkdir -p "$COPIA_DIR"
fi

# sacamos la fecha de la ultima copia
COPIA_ULTIMA=$(tail -n 1 "$LOG" 2>/dev/null | cut -f1)

# ponemos la marca de tiempo de la copia
FECHA_ACTUAL=$(date +"%Y%m%d%H%M%S")

# actualizamos la fecha de copia en el log
echo "$FECHA_ACTUAL" >> "$LOG"

# copiamos los archivos modificados desde la ulima vez
rsync -a ="$COPIA_DIR/$COPIA_ULTIMA" "$DIRECTORIO_DIR" "$COPIA_DIR/$FECHA_ACTUAL"

echo "Copia completada"


