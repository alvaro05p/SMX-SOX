#!/bin/bash


prueba=$(ldapsearch -x -b dc=ubuntusrv,dc=smx2023,dc=net -H ldap://192.168.5.140 | grep $USER | grep "cn=gnolls" | cut -d "," -f2)

if [ ! -d $HOME/shared/smx2023.net/stronghold-ldap-nfs ]; then

        mkdir -p $HOME/shared/smx2023.net/stronghold-ldap-nfs


fi


if [ $prueba = "cn=gnolls" ]; then


        echo "alvaro" | sudo -S mount stronghold.smx2023.net:/srv/nfs/stronghold-ldap-nfs $HOME/shared/smx2023.net/stronghold-ldap-nfs


        logger "se deberia haber montado con nfs"

fi

exit 0
