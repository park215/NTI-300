#!/bin/bash

if (( $# >= 1 ))
status2=$( yum list installed | grep "$@" | grep -v "tools" | awk -F "." '{print $1}' )
then [[ $status2 == $@ ]];
        for i in "$@"
        do
        yum -y install "$@"
        done

status1=$(systemctl status "$@" | grep Active | awk '{print $2}')
inactive="inactive"

[[ $status1 == $inactive ]];
        for i in "$@"
        do
        read -p "the service is off would you like to turn it on? " yn
        case $yn in
                [Yy]* ) service start "$@";;
                [Nn]* ) exit 0;;
                * ) echo "please answer yes or no";;
        esac
done
fi
