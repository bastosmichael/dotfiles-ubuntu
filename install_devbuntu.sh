#!/bin/bash

if [ $# -eq 0 ]
then
    echo "install_devbuntu.sh [options] install|update|upgrade|android|devops|ssh"
elif [ $1 == 'install' ]; then
	echo "Updating..."
	sudo apt update
	sudo apt -y upgrade
        sudo apt -y dist-upgrade
	echo "Installing Essentials"
	sudo apt install -y build-essential screen git curl openssh-client openssh-server nmap imagemagick libmagickwand-dev libmagickwand-dev
	sudo add-apt-repository ppa:malteworld/ppa
	sudo apt update
	sudo apt install pdftk
	sudo snap install postman
        sudo snap install slack --classic
        sudo snap install android-studio --classic
	echo "Installing Xmonad"
        sudo apt install -y xmonad xmobar suckless-tools
	echo "Installing Databases"
	sudo debconf-set-selections <<< 'mysql-server-<version> mysql-server/root_password password password'
	sudo debconf-set-selections <<< 'mysql-server-<version> mysql-server/root_password_again password password'
	sudo apt install -y mysql-client mysql-server libmysqlclient-dev sqlite3 libsqlite3-dev postgresql postgresql-contrib libpq-dev postgis pdftk redis-server
	sudo -u postgres bash -c "psql -c \"CREATE USER michael WITH PASSWORD '';\""
	sudo -u postgres bash -c "psql -c \"ALTER USER michael WITH SUPERUSER;\""
	echo "Installing Visual Studio Code"
	curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
	sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	sudo apt install apt-transport-https
        sudo apt update
        sudo apt install code
	echo "Installing RVM"
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	\curl -sSL https://get.rvm.io | bash -s stable
	source ~/.bash_profile
        rvm install ruby
	echo "Install NVM"
	curl https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh | bash
	source ~/.profile
	nvm install node
	nvm use node
	echo "Install PyEnv"
	curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
	pyenv install 2.7
	pyenv install 3.6.3
	pyenv local 3.6.3
elif [ $1 == 'update' ]; then
    echo "Updating..."
    sudo apt-get update
    sudo apt-get upgrade
    /opt/android-sdk-linux/tools/android update sdk --no-ui
elif [ $1 == 'upgrade' ]; then
    echo "Upgrading..."
    sudo apt-get update
    sudo apt-get upgrade
	sudo apt-get dist-upgrade
fi
