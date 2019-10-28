#!/bin/bash

for i in $@
do
echo "installing: "$@
status2=$( yum list installed | grep "$@" | grep -v "tools" |  awk -F "." '{print $1}' )
if [[ $status2 == $@ ]]; then
        echo "this package or service is already installed"
elif
        read -p "do you want to install this program: " yn
        case $yn in
                [Yy]* ) yum -y install "$@";;
                [Nn]* ) exit 0;;
                * ) echo "please answer yes or no";;
        esac
status1=$(systemctl status "$@" | grep Active | awk '{print $2}')
inactive="inactive"
then [[ $status1 == $inactive ]];
        read -p "the service is off would you like to turn it on? " yn
        case $yn in
                [Yy]* ) systemctl start "$@";;
                [Nn]* ) exit 0;;
                * ) echo "please answer yes or no";;
        esac
fi;
done
