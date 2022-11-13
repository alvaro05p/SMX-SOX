#!/bin/bash


if [ -d /home/clientealvaro/mnt ]; then



        echo "The mount point exists"


else

        mkdir /home/clientealvaro/mnt
        mkdir /home/clientealvaro/mnt/bgg
        mkdir /home/clientealvaro/mnt/bgg/friday
        mkdir /home/clientealvaro/mnt/bgg/friday/level-green
        mkdir /home/clientealvaro/mnt/bgg/friday/level-yellow
        mkdir /home/clientealvaro/mnt/bgg/friday/level-red
        mkdir /home/clientealvaro/mnt/bgg/friday/pirates

        echo "Mount point created"

fi

        mount 10.0.2.15:/home/servidoralvaro/srv/friday/level-green /home/clientealvaro/mnt/bgg/friday/level-green
        mount 10.0.2.15:/home/servidoralvaro/srv/friday/level-yellow /home/clientealvaro/mnt/bgg/friday/level-yellow
        mount 10.0.2.15:/home/servidoralvaro/srv/friday/level-red /home/clientealvaro/mnt/bgg/friday/level-red
        mount 10.0.2.15:/home/servidoralvaro/srv/friday/pirates /home/clientealvaro/mnt/bgg/friday/pirates


exit 0
