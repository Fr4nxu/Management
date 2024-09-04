#!/bin/ksh
print "por favor ingresa un numero: \c"
read numero
if [[ "$numero" = +([0-9]) ]]; then
	if ((numero > 0));then
		print "es un entero positivo"
	elif ((numero < 0));then
		print "es un entero negativo"
	else 
		print "es un cero"
	fi
else
	if ((numero > 0));then
		print "es un numero real positivo"
	elif ((numero < 0));then
		print "es un numero real negativo"
	else
		print "es un 0"
	fi
fi
