#!/usr/bin/env bash

clear
cd $HOME

if [ -d "/home/crypto-data/" ]
then
  if [ -f "/home/crypto-data/yiimp/site/configuration/serverconfig.php" ]
    then
      echo "Installing for multipool-installer"
      mkdir temp_ipupdate_script_install && cd temp_ipupdate_script_install
      git clone https://github.com/fredsat/butkpoolscripts.git
      sudo cp multipool_ipupdate /usr/bin/ipupdate
      cd $HOME
      rm -drf temp_ipupdate_script_install
    else
      echo "Could not find serverconfig.php in the right folder!"
      exit 1
  fi
else
  if [ -d "/var/web/" ] && [ -f "/var/web/serverconfig.php" ]
    then
      mkdir temp_ipupdate_script_install && cd temp_ipupdate_script_install
      git clone https://github.com/fredsat/butkpoolscripts.git
      echo "Installing for standard yiimp install"
      sudo cp standard_ipupdate /usr/bin/ipupdate
      cd $HOME
      rm -drf temp_ipupdate_script_install
    else
      echo "Could not find serverconfig.php in the right folder!"
      exit 1
  fi
else
  echo "Could not find standard Yiimp folders. Check your installation first!"
  exit 1
fi
clear
sudo chmod a+x /usr/bin/ipchange
echo "Installation complete. Do you want to run the script (Y/n)?"
read yno
[ yno == "Y" ] || [ yno == "y" ] && { bash /usr/bin/ipchange; exit 0; }
echo "To run the script, use the command: ipchange"
exit 0

