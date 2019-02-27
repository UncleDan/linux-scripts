#!/bin/bash
echo "*** CUSTOMIZIONG..."
echo ""
echo "** Update all..."
echo ""
echo "* apt-get clean"
sudo apt-get clean -y
echo ""
echo "* apt-get update"
sudo apt-get update -y
echo ""
echo "* apt-get upgrade"
sudo apt-get upgrade -y
echo ""
echo "** Install preferred packages..."
echo ""
echo "* apt-get install libreoffice firefox firefox-locale-it thunderbird thunderbird-locale-it keepassx vlc flatpak git putty wine-stable zip unzip"
sudo apt-get install -y libreoffice firefox firefox-locale-it thunderbird thunderbird-locale-it keepassx vlc flatpak git putty wine-stable zip unzip
echo ""
echo "** Installing snap software..."
echo ""
echo "* snap install notepad-plus-plus"
sudo snap install notepad-plus-plus
echo ""
echo "** Installing flatpak software..."
echo ""
echo "* flatpak install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref"
sudo flatpak install -y https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref
echo ""
echo "** Installing Google Chrome deb package..."
echo ""
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f
rm -rf google-chrome-stable_current_amd64.deb
# echo ""
# echo "** Installing pCloud AppImage..."
# echo ""
# mkdir -p ~/Software/pCloud
# cd ~/Software/pCloud
# wget http://www.danielelolli.it/files/archive/Software/pCloud/Linux/2019-02-27/pcloud
# chmod +x pcloud
# ./pcloud
# [^^^ This doesn't work: it works only from desktop not from console]
# cd ~
# echo ""
# echo "** Installing FreeFileSync..."
# echo ""
# wget https://freefilesync.org/download/FreeFileSync_10.9_Linux.tar.gz
# tar -xvzf FreeFileSync_10.9_Linux.tar.gz
# rm -rf FreeFileSync_10.9_Linux.tar.gz
# [Something smart I still need to figure out...]
echo ""
echo ""
echo "DONE."
