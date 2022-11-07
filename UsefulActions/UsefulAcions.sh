#!/bin/bash

user=$1
action=$2

rc=0

userList=$(cat /etc/passwd | cut -d ":" -f1 | grep $user) || rc=1

if [ $rc -eq 1 ]; then

	echo "User given not exist"

fi

if [ $action = "replenish" ]; then


	mkdir /home/Workspace
	touch sample.txt

	mkdir config
	touch sample.txt

	mkdir bin
	touch sample.txt

	mkdir source

	mkdir rsrc

	

fi


