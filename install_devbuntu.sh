#!/bin/bash

if [ $# -eq 0 ]
then
    echo "install_devbuntu.sh [options] install|update|upgrade|android|devops|ssh"
elif [ $1 == 'install' ]; then
	echo "Updating..."
	sudo apt-get update
	sudo apt-get -y upgrade
	echo "Installing Essentials"
	sudo dpkg --add-architecture i386
	# sudo add-apt-repository -y ppa:colingille/freshlight
	sudo apt-get -qqy update
	sudo apt-get -qqy install libncurses5:i386 libstdc++6:i386 zlib1g:i386
	sudo apt-get install -y build-essential screen git-core curl openssh-client openssh-server libxslt-dev libxml2-dev libqt4-dev qtcreator nmap winusb pcscd coolkey meld nautilus-dropbox imagemagick libmagickwand-dev nodejs
	echo "Installing Databases"
	sudo debconf-set-selections <<< 'mysql-server-<version> mysql-server/root_password password password'
	sudo debconf-set-selections <<< 'mysql-server-<version> mysql-server/root_password_again password password'
	sudo apt-get install -y mysql-client mysql-server libmysqlclient-dev sqlite3 libsqlite3-dev postgresql postgresql-contrib libpq-dev redis-server mongodb couchdb
	echo "Installing Xmonad"
        sudo apt-get install -y xmonad xmobar suckless-tools
	echo "Installing Browsers"
	sudo apt-get install -y chromium-browser libxss1 icedtea-7-plugin xvfb firefox
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome*.deb
	rm *.deb
	echo "Installing Sublime-Text 3"
	sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
	sudo apt-get update
	sudo apt-get install -y sublime-text-installer
	echo "Installing RVM"
	sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
    curl -L https://get.rvm.io | bash -s stable
    source ~/.rvm/scripts/rvm
    rvm install 2.1.2
    rvm use 2.1.2 --default
    ruby -v
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
elif [ $1 == 'ssh' ]; then
	cd ~/.ssh
	ssh-keygen -t rsa -C "bastosmichael@gmail.com"
	cd ~/
	cat ~/.ssh/id_rsa.pub
elif [ $1 == 'android' ]; then
	echo "Installing Android SDK"
	sudo apt-get install -y openjdk-7-jre openjdk-7-jdk
	wget http://dl.google.com/android/android-sdk_r22.3-linux.tgz
	sudo tar -xvf android-sdk_r22.3-linux.tgz -C /opt
	sudo chmod -R 777 /opt/android-sdk-linux
	rm *.tgz
	echo "Installing Eclipse"
	sudo apt-get -y install eclipse eclipse-jdt eclipse-cdt eclipse-pde eclipse-platform eclipse-rcp
elif [ $1 == 'devops' ]; then
	echo "Installing Docker"
	sudo apt-get update
	sudo apt-get -y install linux-image-extra-`uname -r`
	sudo sh -c "wget -qO- https://get.docker.io/gpg | apt-key add -"
	sudo sh -c "echo deb http://get.docker.io/ubuntu docker main\ > /etc/apt/sources.list.d/docker.list"
	sudo apt-get update
	sudo apt-get -y install lxc-docker
	echo "Installing Vagrant"
	sudo apt-get -y install virtualbox vagrant linux-headers-$(uname -r)
	sudo dpkg-reconfigure virtualbox-dkms
	vagrant plugin install vagrant-aws vagrant-awsinfo vagrant-rackspace
	echo "Installing VM Ware"
	wget https://www.dropbox.com/s/zdqk3rza7ipd70a/VMware-Workstation-Full-10.0.1-1379776.x86_64.bundle
	chmod 777 VMware-Workstation-Full-10.0.1-1379776.x86_64.bundle
	sudo ./VMware-Workstation-Full-10.0.1-1379776.x86_64.bundle
	echo "Installing Heroku Toolset"
	wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
fi
