#!/usr/bin/env bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi
clear
cd $HOME

[ -d "temp_ipupdate_script_install ] && { rm -dr temp_ipupdate_script_install; }
if [ -d "/home/crypto-data/" ]
then
  if [ -f "/home/crypto-data/yiimp/site/configuration/serverconfig.php" ]
  then
    sudo touch /var/bin/ipupdate
    git clone https://github.com/fredsat/butkpoolscripts.git
    sudo cp multipool_ipupdate /usr/bin/
    echo "Installing for multipool-installer"
    mkdir temp_ipupdate_script_install && cd temp_ipupdate_script_install
    cd $HOME
    rm -drf temp_ipupdate_script_install
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
    sudo touch /var/bin/ipupdate
    mkdir temp_ipupdate_script_install && cd temp_ipupdate_script_install
    git clone 'https://github.com/fredsat/butkpoolscripts.git'
    echo "Installing for standard yiimp install"
    sudo cp standard_ipupdate /usr/bin/
    cd $HOME
    rm -drf temp_ipupdate_script_install
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
clear
sudo chmod a+x /usr/bin/ipchange
  read -p "Installation complete. Do you want to run the script [Y/n] ? " yn
  case $yn in
    [Yy]* ) bash /usr/bin/ipupdate; exit;;
    * ) echo "To run the script enter: ipupdate"; exit;;
  esac
done
