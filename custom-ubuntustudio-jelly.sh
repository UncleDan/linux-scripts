#!/bin/bash
echo "***** CUSTOMIZING... *****"
echo ""
echo "** Set RTC time to avoid problems in dual boot..."
echo ""
sudo timedatectl set-local-rtc 1 --adjust-system-clock
echo ""
echo "** Installing curl, git, zip, unzip, 7zip and flatpak commands..."
echo ""
sudo apt install curl git zip unzip p7zip-full flatpak -y
echo ""
echo "** Adding flathub flatpak repository..."
echo ""
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo ""
echo "** Adding flathub flatpak backend to Discover..."
echo ""
sudo apt install plasma-discover-backend-flatpak -y
echo ""
echo "** Creating temporary folder..."
echo ""
tmp_dir=$(mktemp -d -t ci-$(date +%Y-%m-%d-%H-%M-%S)-XXXXXXXXXX)
echo ""
echo "** INTERNET: Installing Google Chrome DEB package..."
echo ""
curl -L https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o $tmp_dir/google-chrome.deb
sudo apt install $tmp_dir/google-chrome.deb -y
echo ""
echo "** INTERNET: Installing and/or localizing Firefox DEB package..."
echo ""
sudo apt install firefox firefox-locale-it -y
echo ""
echo "** INTERNET: Installing and/or localizing Thunderbird DEB package..."
echo ""
sudo apt install thunderbird thunderbird-locale-it -y
echo ""
echo "** INTERNET: Installing Zoom DEB package..."
echo ""
curl -L https://zoom.us/client/latest/zoom_amd64.deb -o $tmp_dir/zoom.deb
sudo apt install $tmp_dir/zoom.deb -y
echo ""
echo "** INTERNET: Installing Webex DEB package..."
echo ""
curl -L https://binaries.webex.com/WebexDesktop-Ubuntu-Official-Package/Webex.deb -o $tmp_dir/Webex.deb
sudo apt install $tmp_dir/Webex.deb -y
echo ""
echo "** INTERNET: Installing Teamviewer DEB package..."
echo ""
curl -L https://download.teamviewer.com/download/linux/teamviewer_amd64.deb -o $tmp_dir/teamviewer.deb
sudo apt install $tmp_dir/teamviewer.deb -y
echo ""
echo "** INTERNET: Installing Anydesk DEB package..."
echo ""
curl -L https://download.anydesk.com/linux/anydesk_6.1.1-1_amd64.deb -o $tmp_dir/anydesk.deb
sudo apt install $tmp_dir/anydesk.deb -y
echo ""
echo "** INTERNET: Installing pCloud AppImage package..."
echo ""
pkill -e -f firefox
firefox --new-instance --private-window "https://www.pcloud.com/how-to-install-pcloud-drive-linux.html?download=electron-64"
sudo rm -rf /opt/pcloud
sudo mkdir -p /opt/pcloud
sudo mv ~/Scaricati/pcloud /opt/pcloud/
sudo chown -R root:root /opt/pcloud
sudo chmod -R 755 /opt/pcloud
/opt/pcloud/pcloud
echo ""
echo "** OFFICE: Installing Libreoffice localization DEB package..." ## Jelly is up to date to 7.3.2.2 as of 26/04/2022, if not Italian guide is here https://wiki.documentfoundation.org/Documentation/Install/Linux/it
echo ""
sudo apt install libreoffice-l10n-it hyphen-it mythes-it libreoffice-help-it -y ## myspell-it has no candidates
echo ""
echo "** OFFICE: Installing Onlyoffice Desktop Editors DEB package..."
echo ""
curl -L https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb -o $tmp_dir/onlyoffice-desktopeditors.deb
sudo apt install $tmp_dir/onlyoffice-desktopeditors.deb -y
echo ""
echo "** GRAPHICS: Removing GIMP DEB package and installing GIMP flatpak package..."
echo ""
sudo apt remove gimp* -y
sudo flatpak install flathub org.gimp.GIMP -y
### echo ""
### echo "** MULTIMEDIA: Installing VLC media player DEB package..." ## Jelly is up to date
### echo ""
### sudo apt vlc install -y
### echo ""
### echo "** MULTIMEDIA: Installing OBS Studio DEB package..." ## Jelly is up to date
### echo ""
### sudo apt install obs-studio -y
echo ""
echo "** MULTIMEDIA: Install Avidemux AppImage package..."
echo ""
pkill -e -f firefox
firefox --new-instance --private-window "https://www.fosshub.com/Avidemux.html?dwl=avidemux_2.8.0.appImage"
sudo rm -rf /opt/avidemux
sudo mkdir -p /opt/avidemux
sudo mv ~/Scaricati/avidemux_2.8.0.appImage /opt/avidemux/avidemux
sudo chown -R root:root /opt/avidemux
sudo chmod -R 755 /opt/avidemux
/opt/avidemux/avidemux
sudo bash -c 'cat > /usr/share/applications/avidemux.desktop <<EOF
[Desktop Entry]
Version=1.0
Name=Avidemux
GenericName=Software for encoding and basic video editing
Comment=Software for encoding and basic video editing
Exec=/opt/avidemux/avidemux
Icon=/opt/avidemux/avidemux
Terminal=false
Type=Application
Categories=AudioVideo;Recorder;
StartupNotify=true

GenericName[it_IT]=Software per encoding e semplice montaggio video
Comment[it_IT]=Software per encoding e semplice montaggio video
EOF'
echo ""
echo "** CODING: Install Visual Studio Code DEB package (via MS repository)..."
echo ""
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update -y
sudo apt install code -y
echo ""
echo "** UTILITY: Installing Angry IP scanner DEB package..."
echo ""
curl -L https://github.com/angryip/ipscan/releases/download/3.8.2/ipscan_3.8.2_amd64.deb -o $tmp_dir/ipscan.deb
sudo apt install $tmp_dir/ipscan.deb -y
echo ""
echo "** UTILITY: Installing FreeFileSync TGZ package..."
echo ""
curl -L https://freefilesync.org/download/FreeFileSync_11.20_Linux.tar.gz -o $tmp_dir/FreeFileSync.tgz
tar -xvzf $tmp_dir/FreeFileSync.tgz -C $tmp_dir
$tmp_dir/FreeFileSync_11.20_Install.run
# ^^^ Check if FreeFileSync can be completely silent
echo ""
echo "** UTILITY: Install KeepassXC DEB package..."
echo ""
sudo apt install keepassxc -y
echo ""
echo "** UTILITY: Install PUTTY DEB package..."
echo ""
sudo apt install putty -y
echo ""
echo "** UTILITY: Install Filezilla DEB package..."
echo ""
sudo apt install filezilla -y
echo ""
echo "** UTILITY: Install OpenSSH Server DEB package..."
echo ""
sudo apt install openssh-server -y
echo ""
echo "** UPDATE: Update and clean DEB packages..."
echo ""
sudo apt clean -y
sudo apt update -y
sudo apt autoremove -y
sudo apt upgrade -y
echo ""
echo "** UPDATE: Update and clean flatpak packages..."
echo ""
sudo flatpak update -y
echo "DONE: reboot suggested."
