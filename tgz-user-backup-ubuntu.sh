#!/bin/bash
# Build 2019.12.22 - Daniele Lolli (UncleDan) - Ubuntu and derivative
# --- SCRIPT ---
ADESSO=$(date +"%Y-%m-%d_%H-%M-%S")
echo "Salvo elenco pacchetti installati..."
sudo dpkg --get-selections | sed "s/.*deinstall//" | sed "s/install$//g" > $HOME/dpkg-get-selections_$ADESSO.list
echo "Comprimo la home..."
sudo tar --exclude=$HOME/.pcloud --exclude=$HOME/pCloudDrive --exclude=$HOME/tgz-user-backup-ubuntu* -cvpzf $HOME/tgz-user-backup-ubuntu_${USER:=$(/usr/bin/id -run)}_$ADESSO.tar.gz $HOME
sudo chown $USER:$USER $HOME/tgz-user-backup-ubuntu_${USER:=$(/usr/bin/id -run)}_$ADESSO.tar.gz
sudo rm $HOME/dpkg-get-selections_$ADESSO.list
echo "Backup eseguito."
