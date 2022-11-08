#!/bin/bash

user=$1
action=$2

rc=0

if [ $# -le 1 ]; then

        exit 1

fi

userList=$(cat /etc/passwd | cut -d ":" -f1 | grep $user) || rc=1


if [ $rc -eq 1 ]; then

	echo "User given not exist"
	action=0
fi

if [ $action = "replenish" ]; then


	mkdir /home/Workspace

	mkdir /home/Workspace/config
	touch /home/Workspace/config/sample.txt

	mkdir /home/Workspace/bin
	touch /home/Workspace/bin/sample.txt

	mkdir /home/Workspace/source
	touch /home/Workspace/source/sample.txt


	mkdir /home/Workspace/rsrc
	touch /home/Workspace/rsrc/sample.txt
	touch /home/Workspace/sample.txt


fi


exit 0


