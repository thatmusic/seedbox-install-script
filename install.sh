#!/bin/sh
sudo mkdir /home/seedbox
sudo adduser --disabled-password --system --home /home/seedbox --group seedbox
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
echo "deb http://apt.sonarr.tv/ master main" | sudo tee /etc/apt/sources.list.d/sonarr.list
sudo apt-get update 
sudo apt-get install python deluged deluge-webui deluge-console nzbdrone -y
sudo touch /var/log/deluged.log
sudo touch /var/log/deluge-web.log
sudo chown seedbox:seedbox /var/log/deluge*
sudo mkdir /home/seedbox/.config
sudo mkdir /home/seedbox/.config/deluge
sudo mkdir /home/seedbox/torrents
sudo mkdir /home/seedbox/torrents/.temp
sudo mkdir /home/seedbox/torrents/complete
sudo cp deluged.conf /etc/init/deluged.conf
sudo cp deluge-web.conf /etc/init/deluge-web.conf
sudo cp core.conf /home/seedbox/.config/deluge
sudo echo "seedbox:seedbox:10" >> /home/seedbox/.config/deluge/auth
sudo mkdir /home/seedbox/.couchpotato
sudo git clone git://github.com/RuudBurger/CouchPotatoServer.git /home/seedbox/.couchpotato
sudo cp /home/seedbox/.couchpotato/init/ubuntu /etc/init.d/couchpotato
sudo chmod +x /etc/init.d/couchpotato
sudo cp ubuntu.default /etc/default/couchpotato
sudo chmod +x /etc/default/couchpotato
sudo update-rc.d couchpotato defaults
sudo cp nzbdrone.conf /etc/init
sudo chmod -R 777 /home/seedbox
sudo reboot now