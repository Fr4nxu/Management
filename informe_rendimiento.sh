#!/bin/bash

#no se porque pero la primera vez que lo ejecutas dice que no tienes permisos pero la segunda vez 
#ya lo hace bien 

informe_archivo="informe_rendimiento.txt"

if [ ! -e "$informe_archivo" ]; then
    sudo touch "$informe_archivo"
    sleep 1
fi

FECHA_ACTUAL=$(date +"%d-%m-%Y %H:%M")

echo  "Informe de Rendimiento del sistema" | sudo tee -a "$informe_archivo"
echo  "-----------------------------------" | sudo tee -a "$informe_archivo"

echo -e "Fecha y hora: $FECHA_ACTUAL" | sudo tee -a "$informe_archivo" 
echo -e "1. Informe de la CPU: "	   | sudo tee -a "$informe_archivo"
sudo top -b -n 1   >> "$informe_archivo"



echo -e "2. Informacion de la RAM:" | sudo tee -a "$informe_archivo"
sudo free -h >> "$informe_archivo"

echo -e "3. Informacion del uso del disco:" | sudo tee -a "$informe_archivo"
sudo df -h >> "$informe_archivo"

sudo chown "$USER:$USER" "$informe_archivo"

echo "Informe generado con exito en: $informe_archivo" 


