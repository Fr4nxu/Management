#!/bin/bash
#
#estrellas.sh
#ejemplo de bucles estilo C anidados
#
N=10
for (( i=1 ;i <= $N ;i++ ));do
	for ((j=1 ;j <= i;j++ ));do
		echo -n "*"
	done
	echo
done
for ((y=$N ; y >= 1; y-- ));do
	for ((j=1; j <= y; j++ ));do
		echo -n "*"
	done
	echo
done
