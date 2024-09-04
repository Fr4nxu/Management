#!/bin/bash
#juego de adivinar un numero entre 1 y 6
#calculamos en numero aleatorio entre 1 y 6
echo -n "numero de intentos " 
read INTENTOS2
((N = $RANDOM % 6 + 1))
read -p "adivina el numero entre 1 y 6: " RESPUESTA
while (( $RESPUESTA != $N )); do
	echo
	echo -n "el numero no es ${RESPUESTA}. Vuelve a intentarlo: "
	read RESPUESTA
	((INTENTOS++))
if [ $INTENTOS == $INTENTOS2 ]; then
	echo "limite de intentos alcanzado"
exit 1
fi
done
echo "bien hecho lo has adivinado en ${INTENTOS}. El numero era $N"
exit 0
