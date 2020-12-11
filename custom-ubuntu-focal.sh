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



### CHECKED ABOVE ^^^ ###

echo "** Installing Angry IP Scanner deb package..."
echo ""
wget https://filedn.com/lAHAHtmqjaTjJxFAtUSMfN8/files/archive/Software/Linux/ipscan_3.6.2_amd64.deb
sudo dpkg -i ipscan_3.6.2_amd64.deb
sudo apt install -f
rm -rf ipscan_3.6.2_amd64.deb
echo ""
echo "** Installing FreeFileSync..."
echo ""
wget https://filedn.com/lAHAHtmqjaTjJxFAtUSMfN8/files/archive/Software/Linux/FreeFileSync_10.20_Linux.tar.gz
tar -xvzf FreeFileSync_10.20_Linux.tar.gz
rm -rf FreeFileSync_10.20_Linux.tar.gz
unzip -o FreeFileSync/Resources.zip -d FreeFileSync/Resources
mkdir -p ~/Software
mv FreeFileSync ~/Software
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/FreeFileSyncSync.desktop <<EOF
#!/usr/bin/env xdg-open

[Desktop Entry]
Type=Application
Name=FreeFileSync
Name[de]=FreeFileSync
Name[it]=FreeFileSync
GenericName=Folder Comparison and Synchronization
GenericName[de_DE]=Ordnervergleich und Synchronisation
GenericName[it_IT]=Comparazione e Sincronizzazione di Cartelle
Exec=/home/carlotta/Software/FreeFileSync/FreeFileSync %F
Icon=/home/carlotta/Software/FreeFileSync/Resources/FreeFileSync.png
Icon[de]=/home/carlotta/Software/FreeFileSync/Resources/FreeFileSync.png
Icon[it]=/home/carlotta/Software/FreeFileSync/Resources/FreeFileSync.png
NoDisplay=false
Terminal=false
Categories=Utility;FileTools;
StartupNotify=true
EOF
chmod +x ~/.local/share/applications/FreeFileSyncSync.desktop
cat > ~/.local/share/applications/RealTimeSync.desktop <<EOF
#!/usr/bin/env xdg-open

[Desktop Entry]
Type=Application
Name=RealTimeSync
Name[de]=RealTimeSync
Name[it]=RealTimeSync
GenericName=Automated Synchronization
GenericName[de_DE]=Automatisierte Synchronisation
GenericName[it_IT]=Sincronizzazione Automatica
Exec=/home/carlotta/Software/FreeFileSync/RealTimeSync %f
Icon=/home/carlotta/Software/FreeFileSync/Resources/RealTimeSync.png
Icon[de]=/home/carlotta/Software/FreeFileSync/Resources/RealTimeSync.png
Icon[it]=/home/carlotta/Software/FreeFileSync/Resources/RealTimeSync.png
NoDisplay=false
Terminal=false
Categories=Utility;FileTools;
StartupNotify=true
EOF
chmod +x ~/.local/share/applications/RealTimeSync.desktop
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
