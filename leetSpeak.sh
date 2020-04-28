#!/bin/bash
#Generates cringe er I mean leet speak.
#Created by Quinton Brown 4-28-2020

while read -ep "Type something to convert it and press enter: " text; do 
	echo "Super cool text here:"
	echo "$text" | tr letbogis 13780612 | tr LETBOGIS 13780612;
	echo "wow so cool bruh"
	break
done
