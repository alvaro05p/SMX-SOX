#!/bin/bash

while true ; do

ip=$(ip a | grep metric | cut -d " " -f6 | cut -d "/" -f1)

sleep 5

control=$(ping -c 1 $ip | grep ", 0% packet loss" | wc -l)


if [ $control = 1 ]; then

        echo "Funka"


elif [ $control = 0 ]; then

        if [ -f arp.log ]; then


                echo "Actualizando tu fichero arp ya que se encontró un error"

                rm arp.log

                wget http://tic.ieslasenia.org/arp.log

        else

                wget http://tic.ieslasenia.org/arp.log

                echo "Se ha descargado el fichero arp por que se encontro un error"


                        echo $lineas





        fi


                cat arp.log | cut -d " " -f1,5 | while read lineas ; do


                        echo $lineasA


                done


fi

done

exit 0