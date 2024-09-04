#!/bin/bash
#
#
#
# Función para verificar si es primo
primo() {
    local num=$1
    if [ $num -lt 2 ]; then
        return 1  # No es primardo
    fi
    for ((i = 2; i * i <= num; i++)); do
        if [ $((num % i)) -eq 0 ]; then
            return 1  #no es primardo
        fi
    done
    return 0 #ole su primo
}

# Solicitar al usuario el rango
read -p "inicio del rango: " inicio
read -p "fin del rango: " fin

# crea y enseña la lista de números primos
echo -n "numero primos del $inicio al $fin : "
for ((num = inicio; num <= fin; num++)); do
    if primo "$num"; then
        echo -n "$num "
    fi
done
echo  # pa un espacio pa que quede mas bonito
