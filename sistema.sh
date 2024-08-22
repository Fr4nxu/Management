#!/bin/bash
ARCHIVO_INFORME="informe_rendimiento.txt"

if [ ! -e "$ARCHIVO_INFORME" ]; then
    sudo touch "$ARCHIVO_INFORME"
fi
FECHA_ACTUAL=$(date +"%d-%m-%Y %H:%M")

echo  "Informe de Rendimiento del sistema" | sudo tee -a "$ARCHIVO_INFORME"
echo  "-----------------------------------" | sudo tee -a "$ARCHIVO_INFORME"

echo "Fecha y hora: $FECHA_ACTUAL"
echo "1. Informe de la CPU: "
sudo top -h >> "$ARCHIVO_INFORME"

echo "2. Informacion de la RAM:"
sudo free -h >> "$ARCHIVO_INFORME"

echo "3. Informacion del uso del disco:"
sudo df -h >> "$ARCHIVO_INFORME"

echo "Informe generado con exito en: $ARCHIVO_INFORME"


