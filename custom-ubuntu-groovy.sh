#!/bin/bash
## Based on Ubuntu Studio 20.10 "Groovy Gorilla"
echo "*** CUSTOMIZING..."
echo ""
echo "** Update all..."
echo ""
echo "* apt clean"
sudo apt clean -y
echo ""
echo "* apt update"
sudo apt update -y
echo ""
echo "* apt upgrade"
sudo apt upgrade -y
sudo apt autoclean
echo ""
echo "** Install preferred packages..."
echo ""
echo "* install -y firefox-locale-it thunderbird-locale-it keepassx vlc openssh-server xrdp xorgxrdp git putty wine-stable zip unzip p7zip filezilla mc"
sudo apt install -y firefox-locale-it thunderbird-locale-it keepassx vlc openssh-server xrdp xorgxrdp git putty wine-stable zip unzip p7zip filezilla
sudo apt install -y --install-suggests mc
echo "** Installing snap software..."
echo ""
echo "* snap install notepad-plus-plus"
sudo snap install notepad-plus-plus
echo ""
echo "** Installing Google Chrome deb package..."
echo ""
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
##################################################
echo ""
echo "** Installing FreeFileSync..."
echo ""
wget https://filedn.com/lAHAHtmqjaTjJxFAtUSMfN8/files/archive/Software/Linux/FreeFileSync_11.6_Linux.tar.gz
tar -xvzf FreeFileSync_11.6_Linux.tar.gz
rm -rf FreeFileSync_10.20_Linux.tar.gz
./FreeFileSync_11.6_Install.run
rm -rf FreeFileSync_11.6_Install.run
echo ""
echo "** Installing Angry IP Scanner deb package..."
echo ""
wget https://filedn.com/lAHAHtmqjaTjJxFAtUSMfN8/files/archive/Software/Linux/ipscan_3.6.2_amd64.deb
sudo apt install -y ./ipscan_3.6.2_amd64.deb
echo ""
echo "** Installing pCloud AppImage..."
echo ""
mkdir -p ~/Software/pCloud
wget https://filedn.com/lAHAHtmqjaTjJxFAtUSMfN8/files/archive/Software/Linux/pcloud_2020-03-08_amd64.AppImage
mv pcloud_2020-03-08_amd64.AppImage ~/Software/pCloud/pcloud
chmod +x ~/Software/pCloud/pcloud
echo ""
echo "ATTENZIONE! per attivare pCloud fare doppio click sul relativo eseguibile."
echo "Se non funziona riscaicare AppImage aggiornata da:"
echo "https://www.pcloud.com/it/how-to-install-pcloud-drive-linux.html"
echo ""
echo ""
# ^^^ Still some problems on pcloud.
echo "DONE."
