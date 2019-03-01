#!/bin/bash
echo "*** CUSTOMIZING..."
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
echo "* apt-get install libreoffice firefox firefox-locale-it thunderbird thunderbird-locale-it keepassx vlc flatpak openssh-server git putty wine-stable zip unzip p7zip filezilla"
sudo apt-get install -y libreoffice firefox firefox-locale-it thunderbird thunderbird-locale-it keepassx vlc flatpak openssh-server git putty wine-stable zip unzip p7zip filezilla
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
echo ""
echo "** Installing Angry IP Scanner deb package..."
echo ""
wget http://www.danielelolli.it/files/archive/Software/AngryIPScanner/Linux/ipscan_3.5.5_amd64.deb
sudo dpkg -i ipscan_3.5.5_amd64.deb
sudo apt-get install -f
rm -rf ipscan_3.5.5_amd64.deb
echo ""
echo "** Installing FreeFileSync..."
echo ""
wget http://www.danielelolli.it/files/archive/Software/FreeFileSync/Linux/FreeFileSync_10.9_Linux.tar.gz
tar -xvzf FreeFileSync_10.9_Linux.tar.gz
rm -rf FreeFileSync_10.9_Linux.tar.gz
mkdir -p ~/Software
mv FreeFileSync ~/Software
echo ""
echo "ATTENZIONE! Non è stato creato alcun launcher. Per eseguire FreeFileSyc e RealTimeSync fare doppio click sui rispettivi eseguibili."
echo ""
echo ""
echo "** Installing pCloud AppImage..."
echo ""
mkdir -p ~/Software/pCloud
wget http://www.danielelolli.it/files/archive/Software/pCloud/Linux/2019-02-27/pcloud
mv pcloud ~/Software/pCloud
chmod +x ~/Software/pCloud/pcloud
echo ""
echo ""
echo "** Installing pCloud AppImage..."
echo ""
echo "ATTENZIONE! per attivare pCloud fare doppio click sul relativo eseguibile."
echo ""
echo ""
# ^^^ Still some problems on pcloud.
echo "DONE."
