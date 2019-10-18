#!/bin/bash

read -p  "enter package or service you want to install:" myvar

status2=$( yum list installed | grep "$myvar" | grep -v "tools" | awk -F "." '{print $1}' )
status=$(systemctl status $3 | grep Active | awk '{print $4}')
inactive="inactive"

if [[ $status2 == $myvar ]]; then
        echo "this package or service is already installed"
        exit 0;

else
        read -p "do you want to install this program: " yn
        case $yn in
                [Yy]* ) yum -y install "$myvar";;
                [Nn]* ) exit 0;;
                * ) echo "please answer yes or no";;
                esac
fi

if [[ $status == $inactive ]]; then
        read -p "the service is off would you like to turn it on?"; yn
        case $yn in
                [Yy]* ) systemctl start "$myvar"; break;;
                [Nn]* ) exit;;
                * ) echo "please answer yes or no";;
        esac

fi
