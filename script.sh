#!/bin/bash

clear
cd $HOME

[ -d "ipupdate" ] && { rm -drf ipupdate; }
if [ -d "/home/crypto-data/" ]
then
  if [ -f "/home/crypto-data/yiimp/site/configuration/serverconfig.php" ]
  then
    sudo touch /usr/bin/ipupdate
    git clone https://github.com/fredsat/ipupdate.git
    echo "Installing for multipool-installer"
    cd ipupdate
    sudo cat multipool_ipupdate > /usr/bin/ipupdate
    cd $HOME
    rm -drf ipupdate
  else
    echo "ERROR: Could not find serverconfig.php in the right folder!"
    echo
    echo
    exit 1
  fi
elif [ -d "/var/web/" ]
then
  if [ -f "/var/web/serverconfig.php" ]
  then
    sudo touch /usr/bin/ipupdate
	git clone 'https://github.com/fredsat/ipupdate.git'
    cd ipupdate
    echo "Installing for standard yiimp install"
    sudo cat standard_ipupdate > /usr/bin/ipupdate
    cd $HOME
    rm -drf ipupdate
  else
    echo "ERROR: Could not find serverconfig.php in the right folder!"
    echo
    echo
    exit 1
  fi
else
  echo "ERROR: Could not find standard Yiimp folders. Check your installation first!"
  echo
  echo
  exit 1
fi
sudo chmod a+x /usr/bin/ipupdate
read -r -p "Installation complete. Do you want to run the script [Y/n] ? " yn
case $yn in
  [Yy]* ) bash /usr/bin/ipupdate;;
  * ) echo 'To run the script enter: ipupdate';;
esac
exit 0
