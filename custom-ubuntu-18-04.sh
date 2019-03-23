#!/bin/bash
echo "*** CUSTOMIZING..."
echo ""
echo ""
echo "** Creating temp folder..."
MYDIR=$(pwd)
MYTEMPDIR=`mktemp -d`
if [[ ! "$MYTEMPDIR" || ! -d "$MYTEMPDIR" ]]; then
  echo "Could not create temp dir"
  exit 1
fi
cd $MYTEMPDIR
echo ""
echo ""
echo "** Adding repo for Google Chrome and Wine HQ..."
echo ""
echo "* add repos"
sudo bash -c 'cat << EOF > /etc/apt/sources.list.d/google-chrome.list
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
EOF'
sudo dpkg --add-architecture i386
sudo bash -c 'cat << EOF > /etc/apt/sources.list.d/winehq.list
deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main
EOF'
echo ""
echo "* add keys"
wget https://dl.google.com/linux/linux_signing_key.pub
sudo apt-key add linux_signing_key.pub
wget https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
echo ""
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
echo ""
echo ""
echo "** Uninstalling old versions packages..."
echo ""
echo "* apt purge gimp* wine*"
sudo apt purge -y gimp* wine*
sudo apt autoclean
echo ""
echo ""
echo "** Install preferred packages..."
echo ""
echo "* apt install libreoffice firefox firefox-locale-it thunderbird thunderbird-locale-it keepassx vlc flatpak openssh-server xrdp xorgxrdp git putty zip unzip p7zip filezilla snapd google-chrome-stable winehq-stable"
sudo apt install -y --install-recommends libreoffice firefox firefox-locale-it thunderbird thunderbird-locale-it keepassx vlc flatpak openssh-server xrdp xorgxrdp git putty zip unzip p7zip filezilla snapd google-chrome-stable winehq-stable
echo ""
echo ""
echo "** Installing snap software..."
echo ""
echo "* snap install notepad-plus-plus"
sudo snap install notepad-plus-plus
echo ""
echo ""
echo "** Installing flatpak software..."
echo ""
echo "* flatpak install https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref"
sudo flatpak install -y https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref
echo ""
echo ""
echo "** Installing Angry IP Scanner deb package..."
echo ""
wget http://www.danielelolli.it/files/archive/Software/Linux/ipscan_3.5.5_amd64.deb
sudo dpkg -i ipscan_3.5.5_amd64.deb
sudo apt install -f
rm -rf ipscan_3.5.5_amd64.deb
echo ""
echo "** Installing FreeFileSync..."
echo ""
wget http://www.danielelolli.it/files/archive/Software/Linux/FreeFileSync_10.10_Linux.tar.gz
tar -xvzf FreeFileSync_10.10_Linux.tar.gz
rm -rf FreeFileSync_10.10_Linux.tar.gz
unzip -o FreeFileSync/Resources.zip -d FreeFileSync/Resources
mkdir -p ~/Software
mv FreeFileSync ~/Software
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/FreeFileSyncSync.desktop <<EOF
#!/usr/bin/env xdg-open

[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=/home/utente/Software/FreeFileSync/Resources/FreeFileSync.png
Icon[it_IT]=/home/utente/Software/FreeFileSync/Resources/FreeFileSync.png
Name[it_IT]=FreeFileSync
Exec=/home/utente/Software/FreeFileSync/FreeFileSync
Name=FreeFileSync
EOF
chmod +x ~/.local/share/applications/FreeFileSyncSync.desktop
cat > ~/.local/share/applications/RealTimeSync.desktop <<EOF
#!/usr/bin/env xdg-open

[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=/home/utente/Software/FreeFileSync/Resources/RealTimeSync.png
Icon[it_IT]=/home/utente/Software/FreeFileSync/Resources/RealTimeSync.png
Name[it_IT]=RealTimeSync
Exec=/home/utente/Software/FreeFileSync/RealTimeSync
Name=RealTimeSync
EOF
chmod +x ~/.local/share/applications/RealTimeSync.desktop
echo ""
echo ""
echo "** Installing pCloud AppImage..."
echo ""
mkdir -p ~/Software/pCloud
wget http://www.danielelolli.it/files/archive/Software/Linux/pcloud_2019-03-23_amd64
mv pcloud_2019-03-23_amd64 ~/Software/pCloud/pcloud
chmod +x ~/Software/pCloud/pcloud
echo ""
echo "ATTENZIONE! per attivare pCloud fare doppio click sul relativo eseguibile."
# ^^^ Still some problems on pcloud.
cd $MYDIR
MYDIR=
MYTEMPDIR=
echo ""
echo ""
echo "DONE."
