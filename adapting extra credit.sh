#!/bin/bash


for i in $( echo "$@" ); do

status2=$( yum list installed | grep "$i@" | grep -v "tools" |  awk -F "." '{print $1}' )
if [[ $status2 == $i ]]; then
        echo "this package or service is already installed"
elif
        read -p "do you want to install this program: " yn
        case $yn in
                [Yy]* ) yum -y install "$i";;
                [Nn]* ) exit 0;;
                * ) echo "please answer yes or no";;
        esac
status1=$(systemctl status "$i" | grep Active | awk '{print $2}')
inactive="inactive"
then [[ $status1 == $inactive ]];
        read -p "the service is off would you like to turn it on? " yn
        case $yn in
                [Yy]* ) systemctl start "$i";;
                [Nn]* ) exit 0;;
                * ) echo "please answer yes or no";;
        esac
fi;
done
