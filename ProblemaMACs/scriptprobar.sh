#!/bin/bash

if [ -f textinfo ]; then

	echo "Todo good"

else

	touch textinfo

fi

while true; do

sleep 1

cat probarcosas.txt | cut -d " " -f1 | while read palabra; do


	echo "hola" > textinfo

	info=$(cat textinfo)



		if [ $palabra = $info ]; then


			echo $textinfo

		fi

	done

	done

done


exit 0
