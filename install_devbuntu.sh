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
	sudo apt install -y build-essential screen git curl openssh-client openssh-server nmap imagemagick libmagickwand-dev libmagickwand-dev libpq-dev libxcb-xtest0
	sudo add-apt-repository ppa:malteworld/ppa
	sudo apt update
	sudo apt install redis-server postgis
	sudo snap install postman
        sudo snap install slack --classic
        sudo snap install android-studio --classic
        echo "Installing zoom"
        cd /tmp
        wget https://zoom.us/client/latest/zoom_amd64.deb
        sudo dpkg -i zoom_amd64.deb
        echo "Downloading Pdftk"
        cd /tmp
        # download packages
        wget http://launchpadlibrarian.net/340410966/libgcj17_6.4.0-8ubuntu1_amd64.deb \
         http://launchpadlibrarian.net/337429932/libgcj-common_6.4-3ubuntu1_all.deb \
         https://launchpad.net/ubuntu/+source/pdftk/2.02-4build1/+build/10581759/+files/pdftk_2.02-4build1_amd64.deb \
         https://launchpad.net/ubuntu/+source/pdftk/2.02-4build1/+build/10581759/+files/pdftk-dbg_2.02-4build1_amd64.deb

        echo -e "Packages for pdftk downloaded\n\n"
        # install packages 
        echo -e "\n\n Installing pdftk: \n\n"
        sudo apt-get install ./libgcj17_6.4.0-8ubuntu1_amd64.deb \
             ./libgcj-common_6.4-3ubuntu1_all.deb \
             ./pdftk_2.02-4build1_amd64.deb \
             ./pdftk-dbg_2.02-4build1_amd64.deb
        echo -e "\n\n pdftk installed\n"
        echo -e "   try it in shell with: > pdftk \n"
        # delete deb files in /tmp directory
        rm ./libgcj17_6.4.0-8ubuntu1_amd64.deb
        rm ./libgcj-common_6.4-3ubuntu1_all.deb
        rm ./pdftk_2.02-4build1_amd64.deb
        rm ./pdftk-dbg_2.02-4build1_amd64.deb
        cd ~/
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
