#!/bin/bash
x=1
while [ $x -le 10 ]; do
	echo "$x vale $x"
	((x++))
done
