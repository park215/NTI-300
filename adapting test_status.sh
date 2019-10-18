#!/bin/bash
read -p  "enter package or service you want to install:" myvar
status2=$( yum list installed | grep "$myvar" | grep -v "tools" | awk -F "." '{pri
nt $1}' )
if [[ $status2 == $myvar ]]; then
        echo "this package or service is already installed"
        exit 0;
else
        read -p "do you want to install this program: " yn
        case $yn in
                [Yy]* ) yum -y install "$myvar"; break;;
                [Nn]* ) exit;;
                * ) echo "please answer yes or no";;
        esac
fi
