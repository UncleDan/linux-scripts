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

### CHECKED ABOVE ^^^ ###

echo ""

echo "** Install preferred packages..."
echo ""
echo "* apt install libreoffice firefox firefox-locale-it thunderbird thunderbird-locale-it keepassx vlc openssh-server xrdp xorgxrdp git putty wine-stable zip unzip p7zip filezilla"
sudo apt install -y libreoffice firefox firefox-locale-it thunderbird thunderbird-locale-it keepassx vlc openssh-server xrdp xorgxrdp git putty wine-stable zip unzip p7zip filezilla
echo ""
echo "** Uninstalling old Gimp versions..."
echo ""
echo "* apt purge gimp*"
sudo apt purge -y gimp*
echo ""
echo "** Installing flatpak software..."
echo ""
echo "* apt install flatpak"
sudo apt install -y flatpak
echo "* flatpak install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref"
sudo flatpak install -y https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref
echo ""
echo "** Installing snap software..."
echo ""
echo "* apt install snapd"
sudo apt install -y snapd
echo "* snap install notepad-plus-plus"
sudo snap install notepad-plus-plus
echo ""
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
