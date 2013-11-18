#!/bin/bash

if [ $# -eq 0 ]
then
        echo "install_devbuntu.sh [options] install|update|upgrade"
elif [ $1 == 'install' ]; then
	echo "Updating..."
	sudo apt-get update
	sudo apt-get upgrade
	echo "Installing Essentials"
	sudo apt-get install -y build-essential git-core curl 
	echo "Installing Databases"
	sudo debconf-set-selections <<< 'mysql-server-<version> mysql-server/root_password password password'
	sudo debconf-set-selections <<< 'mysql-server-<version> mysql-server/root_password_again password password'
	sudo apt-get install -y mysql-client mysql-server libmysqlclient-dev sqlite3 libsqlite3-dev postgresql postgresql-contrib
	echo "Installing Xmonad"
        sudo apt-get install -y xmonad xmobar suckless-tools
	echo "Installing Browsers"
	sudo apt-get install -y chromium-browser libxss1
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome*.deb
	echo "Installing Sublime-Text 3"
	sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
	sudo apt-get update
	sudo apt-get install -y sublime-text-installer
	echo "Installing RVM"
	bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
	type rvm | head -1
	rvm install 2.0.0
	rvm use --default 2.0.0
	rvm install 1.9.3
	rvm install 1.9.2
	rvm install 1.8.7
	sudo apt-get install -y libmysql-ruby
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