#!/bin/bash

# Archivo de salida para el informe
informe_archivo="informe_rendimiento.txt"

# Verificar si el archivo de informe existe, si no, crearlo
if [ ! -e "$informe_archivo" ]; then
    sudo touch "$informe_archivo"
fi

# Obtener la fecha y hora actual para el informe
fecha_actual=$(date +"%Y-%m-%d %H:%M:%S")

# Encabezado del informe
echo "Informe de Rendimiento del Sistema - $fecha_actual" | sudo tee -a "$informe_archivo"
echo "--------------------------------------------------" | sudo tee -a "$informe_archivo"

# Información de la CPU
echo -e "\n[Información de la CPU]\n" | sudo tee -a "$informe_archivo"
sudo lscpu >> "$informe_archivo"

# Uso de la CPU
echo -e "\n[Uso de la CPU]\n" | sudo tee -a "$informe_archivo"
sudo mpstat 1 3 >> "$informe_archivo"

# Información de la memoria RAM
echo -e "\n[Información de la Memoria RAM]\n" | sudo tee -a "$informe_archivo"
sudo free -h >> "$informe_archivo"

# Uso de la memoria RAM por proceso
echo -e "\n[Uso de la Memoria RAM por Proceso]\n" | sudo tee -a "$informe_archivo"
sudo ps aux --sort=-%mem | awk 'NR<=10{print $0}' >> "$informe_archivo"

# Información de uso del disco
echo -e "\n[Información de Uso del Disco]\n" | sudo tee -a "$informe_archivo"
sudo df -h >> "$informe_archivo"

# Uso del disco por directorio
echo -e "\n[Uso del Disco por Directorio]\n" | sudo tee -a "$informe_archivo"
sudo du -h --max-depth=1 / 2>/dev/null | sort -hr >> "$informe_archivo"

# Cambiar la propiedad del archivo al usuario actual
sudo chown "$USER:$USER" "$informe_archivo"

echo "Informe de rendimiento generado en: $informe_archivo"

