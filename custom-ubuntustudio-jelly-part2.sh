#!/bin/bash
echo "***** CUSTOMIZING... PART 2 *****"
echo ""
## Again from: https://mutschler.dev/linux/ubuntu-btrfs-20-04/
echo "** Installing and running Timeshift, on first run choose your options..."
echo ""
sudo apt -y install timeshift
sudo timeshift-gtk
echo ""
echo "** Installing timeshift-autosnap-apt..."
echo ""
git clone https://github.com/wmutschl/timeshift-autosnap-apt.git /home/$USER/timeshift-autosnap-apt
cd /home/$USER/timeshift-autosnap-apt
sudo make install
echo ""
echo "** Installing timeshift-autosnap-apt..."
echo ""
git clone https://github.com/Antynea/grub-btrfs.git /home/$USER/grub-btrfs
cd /home/$USER/grub-btrfs
sudo make install
cd /home/$USER/
echo ""
echo "** Installing curl, git, zip, unzip, 7zip and flatpak commands..."
echo ""
sudo apt -y install curl git zip unzip p7zip-full flatpak
echo ""
echo "** Creating temporary folder and local keyrings folder..."
echo ""
tmp_dir=$(mktemp -d -t ci-$(date +%Y-%m-%d-%H-%M-%S)-XXXXXXXXXX)
sudo mkdir -p /usr/local/share/keyrings/
echo ""
echo "** INTERNET: Installing Google Chrome DEB package..."
echo ""
curl -L https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o $tmp_dir/google-chrome-stable_current_amd64.deb
sudo apt -y install $tmp_dir/google-chrome-stable_current_amd64.deb
echo ""
echo "** INTERNET: Installing Teamviewer DEB package via repository..."
echo ""
sudo curl -L https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc -o /usr/local/share/keyrings/TeamViewer2017.asc
sudo bash -c 'echo "deb [signed-by=/usr/local/share/keyrings/TeamViewer2017.asc] https://linux.teamviewer.com/deb stable main" > /etc/apt/sources.list.d/teamviewer.list'
sudo apt update
sudo apt -y install teamviewer
echo ""
echo "** INTERNET: Installing Anydesk DEB package via repository..."
echo ""
sudo curl -L https://keys.anydesk.com/repos/DEB-GPG-KEY -o /usr/local/share/keyrings/anydesk.asc
sudo bash -c 'echo "deb [signed-by=/usr/local/share/keyrings/anydesk.asc] http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list'
sudo apt update
sudo apt -y install anydesk
echo ""
echo "** INTERNET: Installing Zoom DEB package..."
echo ""
curl -L https://zoom.us/client/latest/zoom_amd64.deb -o $tmp_dir/zoom_amd64.deb
sudo apt -y install $tmp_dir/zoom_amd64.deb
echo ""
echo "** INTERNET: Installing Webex DEB package..."
echo ""
curl -L https://binaries.webex.com/WebexDesktop-Ubuntu-Official-Package/Webex.deb -o $tmp_dir/Webex.deb
sudo apt -y install $tmp_dir/Webex.deb
echo ""
echo "** INTERNET: Installing pCloud AppImage package, close Firefox when download is finished..."
echo ""
pkill -e -f firefox
firefox --new-instance --private-window "https://www.pcloud.com/how-to-install-pcloud-drive-linux.html?download=electron-64"
sudo rm -rf /opt/pcloud
sudo mkdir -p /opt/pcloud
sudo mv /home/$USER/Scaricati/pcloud /opt/pcloud/
sudo chown -R root:root /opt/pcloud
sudo chmod -R 755 /opt/pcloud
### Suggested from pCloud site but maybe unnecessary on Ubuntu Studio
sudo add-apt-repository -y universe
sudo apt install libfuse2
/opt/pcloud/pcloud
echo ""
echo "** INTERNET: Installing Mozilla Thunderbird italian localization DEB package via repository..."
echo ""
sudo apt -y install thunderbird-locale-it
echo ""
echo "** INTERNET: Installing TOR Browser TXZ package in user home folder..."
echo ""
curl -L https://dist.torproject.org/torbrowser/11.5/tor-browser-linux64-11.5_it.tar.xz -o $tmp_dir/tor-browser-linux64-11.5_it.tar.xz
tar -xvf $tmp_dir/tor-browser-linux64-11.5_it.tar.xz -C /home/$USER/
sudo cp /home/uncledan/tor-browser_it/start-tor-browser.desktop /usr/share/applications/start-tor-browser.desktop
echo ""
echo "** OFFICE: Installing Libreoffice localization DEB package..." ## Jelly is up to date to 7.3.2.2 as of 26/04/2022, if not Italian guide is here https://wiki.documentfoundation.org/Documentation/Install/Linux/it
echo ""
sudo apt -y install libreoffice-l10n-it hyphen-it mythes-it libreoffice-help-it hunspell hunspell-dictionary-it  ## myspell-it has no candidates
echo ""
echo "** OFFICE: Installing Onlyoffice Desktop Editors DEB package..."
echo ""
curl -L https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb -o $tmp_dir/onlyoffice-desktopeditors.deb
sudo apt -y install $tmp_dir/onlyoffice-desktopeditors.deb
echo ""
echo "** UTILITY: Install Visual Studio Code DEB package via MS repository..."
echo ""
## sudo apt-get install wget gpg ## everything already installed in Ubuntu Studio 22.04
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update
sudo apt -y install code
echo ""
echo "** UTILITY: Installing Angry IP scanner DEB package..."
echo ""
curl -L https://github.com/angryip/ipscan/releases/download/3.8.2/ipscan_3.8.2_amd64.deb -o $tmp_dir/ipscan_3.8.2_amd64.deb
sudo apt -y install $tmp_dir/ipscan_3.8.2_amd64.deb
echo ""
echo "** UTILITY: Install KeepassXC DEB package..."
echo ""
sudo apt -y install keepassxc
echo ""
echo "** UTILITY: Install PUTTY DEB package..."
echo ""
sudo apt -y install putty
echo ""
echo "** UTILITY: Install Filezilla DEB package..."
echo ""
sudo apt -y install filezilla
echo ""
echo "** UTILITY: Install OpenSSH Server DEB package..."
echo ""
sudo apt -y install openssh-server
echo ""
echo "** GRAPHICS: Removing GIMP DEB package and installing GIMP flatpak package..."
echo ""
sudo apt -y remove gimp*
sudo apt -y autoremove
sudo apt -y autoclean
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak -y install flathub org.gimp.GIMP
echo ""
echo "** MULTIMEDIA: Install Avidemux AppImage package, close Firefox when download is finished..."
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
echo "** UTILITY: Installing FreeFileSync TGZ package..."
echo ""
curl -L https://freefilesync.org/download/FreeFileSync_11.22_Linux.tar.gz -o $tmp_dir/FreeFileSync_11.22_Linux.tar.gz
tar -xvzf $tmp_dir/FreeFileSync_11.22_Linux.tar.gz -C $tmp_dir
$tmp_dir/FreeFileSync_11.22_Install.run
# ^^^ Check if FreeFileSync can be completely silent
echo ""
echo "** VIRTUALIZATION: Installing Oracle Virtualbox DEB package via repository..."
echo ""
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg
sudo bash -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib" > /etc/apt/sources.list.d/oracle-virtualbox.list'
sudo apt update
sudo apt -y install virtualbox-6.1
echo ""
echo "** UTILITY: Installing wine and Notepad++"
echo ""
sudo apt -y install wine-stable
curl -L https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.4/npp.8.4.4.Installer.x64.exe -o $tmp_dir/npp.8.4.4.Installer.x64.exe
wine $tmp_dir/npp.8.4.4.Installer.x64.exe
echo ""
echo "** UPDATE: Update and clean DEB packages (again)..."
echo ""
sudo apt update
sudo apt -y upgrade
sudo apt -y dist-upgrade
sudo apt -y autoremove
sudo apt -y autoclean
echo ""
echo "** UPDATE: Update and clean flatpak packages..."
echo ""
sudo flatpak -y update
echo ""
echo "DONE: reboot suggested."
