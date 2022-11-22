
#!/bin/bash

while true ; do

sleep 5m

control=$(ping -c 1 192.168.1.24 | grep ", 0% packet loss" | wc -l)

if [ $control = 1 ]; then

	echo "Funka"

elif [ $control = 0 ]; then

	echo "Estas q funka"

fi

done

exit 0




