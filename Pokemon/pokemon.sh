#!/bin/bash


ataque=$1

defensa=$2

contador=0

cat data.txt | sed -n 2,19p | cut -d "," -f1 | while read line; do

let contador=contador+1

echo $contador
echo $line

atacantes=$(cat data.txt | sed 2,19p | grep -i $ataque)

echo $atacantes

done





exit 0
