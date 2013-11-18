#!/bin/bash

if [ $# -eq 0 ]
then
        echo "install_devbuntu.sh [options] install|update|upgrade"
elif [ $1 == 'install' ]; then
	echo "Updating..."
	sudo apt-get update
	sudo apt-get upgrade
	echo "Installing Xmonad"
	sudo apt-get -y install xmonad xmobar suckless-tools  
elif [ $1 == 'update' ]; then
        echo "Updating..."
        sudo apt-get update
        sudo apt-get upgrade
elif [ $1 == 'upgrade' ]; then
        echo "Upgrading..."
        sudo apt-get update
        sudo apt-get upgrade
	sudo apt-get dist-upgrade
fi
