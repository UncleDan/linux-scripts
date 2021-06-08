#!/bin/bash
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
sudo apt autoremove -y
echo ""
echo "** Set RTC time to avoid problems in dual boot..."
echo ""
sudo timedatectl set-local-rtc 1 --adjust-system-clock
echo ""
echo "** Installing Google Chrome deb package..."
echo ""
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install -f
rm -rf google-chrome-stable_current_amd64.deb
echo ""
echo "** Installing Teamviewer deb package..."
echo ""
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo dpkg -i teamviewer_amd64.deb
sudo apt --fixbroken install -f
rm -rf teamviewer_amd64.deb
echo ""
echo ""
echo "** Installing Visual Studio Cpde deb package..."
echo ""
wget https://az764295.vo.msecnd.net/stable/940b5f4bb5fa47866a54529ed759d95d09ee80be/code_1.52.0-1607640828_amd64.deb
sudo dpkg -i code_1.52.0-1607640828_amd64.deb
rm -rf code_1.52.0-1607640828_amd64.deb
echo "** Install APT utilities (keepassx vlc openssh-server xrdp xorgxrdp git putty wine-stable zip unzip p7zip-full filezilla)..."
sudo apt install keepassx vlc openssh-server xrdp xorgxrdp git putty wine-stable zip unzip p7zip-full filezilla -y
echo ""
echo "** Remove APT Thunderbird 68.x ..."
echo ""
sudo apt remove thunderbird -y
sudo apt autoremove -y
echo ""
echo "** Install Snap Thunderbird 78.x ..."
echo ""
sudo snap install thunderbird
echo ""
echo "** Remove APT Libreoffice 6.x ..."
echo ""
sudo apt-get remove --purge libreoffice*
sudo apt autoremove -y
echo ""
echo "** Install Snap Libreoffice 7.x ..."
echo ""
sudo snap install libreoffice
echo ""
echo "** Remove APT Gimp (if present) 6.x ..."
echo ""
sudo apt-get remove --purge gimp*
sudo apt autoremove -y
echo ""
echo "** Install Snap Gimp ..."
echo ""
sudo snap install gimp
echo "** Install Snap Notepad++"
sudo snap install notepad-plus-plus
echo ""
echo "** Installing Angry IP Scanner deb package..."
echo ""
wget https://filedn.com/lAHAHtmqjaTjJxFAtUSMfN8/files/archive/Software/Linux/ipscan_3.7.3_amd64.deb
sudo apt install openjdk-14-jre openjdk-14-jre-headless ca-certificates-java java-common libatk-wrapper-java-jni fonts-dejavu-extra -y
sudo dpkg -i ipscan_3.7.3_amd64.deb
rm -rf ipscan_3.7.3_amd64.deb

### CHECKED ABOVE ^^^ ###

echo ""
echo "** Installing FreeFileSync..."
echo ""
wget https://filedn.com/lAHAHtmqjaTjJxFAtUSMfN8/files/archive/Software/Linux/FreeFileSync_11.10_Linux.tar.gz
tar -xvzf FreeFileSync_11.10_Linux.tar.gz
rm -rf FreeFileSync_11.10_Linux.tar.gz
./FreeFileSync_11.10_Install.run
rm -rf FreeFileSync_11.10_Install.run
# ^^^ Check if FreeFileSync can be completely silent
echo ""
echo "** Installing pCloud AppImage..."
echo ""
mkdir -p ~/Software/pCloud
wget https://filedn.com/lAHAHtmqjaTjJxFAtUSMfN8/files/archive/Software/Linux/pcloud_2021-06-08_amd64.AppImage
mv pcloud_2021-06-08_amd64.AppImage ~/Software/pCloud/pcloud
chmod +x ~/Software/pCloud/pcloud
echo ""
echo "ATTENZIONE! per attivare pCloud fare doppio click sul relativo eseguibile."
echo "Se non funziona riscaicare AppImage aggiornata da:"
echo "https://www.pcloud.com/it/how-to-install-pcloud-drive-linux.html"
echo ""
echo ""
# ^^^ Still some problems on pcloud, it would be nice to have it completely automatic.
echo "DONE."
