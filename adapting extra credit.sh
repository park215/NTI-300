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
                [Yy]* ) systemctl start "$@";;
                [Nn]* ) exit 0;;
                * ) echo "please answer yes or no";;
        esac
        exit 0;
done

fi

read -p  "enter package or service you want to install:" myvar
status2=$( yum list installed | grep "$myvar" | grep -v "tools" | awk -F "." '{print $1}' )
if [[ $status2 == $myvar ]]; then
        echo "this package or service is already installed"
elif
        read -p "do you want to install this program: " yn
        case $yn in
                [Yy]* ) yum -y install "$myvar";;
                [Nn]* ) exit 0;;
                * ) echo "please answer yes or no";;
        esac
status1=$(systemctl status "$myvar" | grep Active | awk '{print $2}')
inactive="inactive"
then [[ $status1 == $inactive ]];
        read -p "the service is off would you like to turn it on? " yn
        case $yn in
                [Yy]* ) systemctl start "$myvar";;
                [Nn]* ) exit 0;;
                * ) echo "please answer yes or no";;
        esac
fi
