#!/bin/bash
#pide el valor de una nota(numero entero) y dice si es 
#D(0-2),C-(3-4),c+(5-6)
#B(7-8) o A(9-10)
echo "¿que nota tienes(entero de 1 a 10)?"
read NOTA
case "$NOTA" in
	[0-2])
	echo "Tienes una D."
	;;
	[34])
	echo "tienes una C-."
	;;
	[56])
	echo " tienes una C+."
	;;
	[78])
	echo "tienes una B."
	;;
	9|10)
	echo "tienes un sobresaliente."
	;;
	*)
	echo "fuera de rango"
	;;
esac
