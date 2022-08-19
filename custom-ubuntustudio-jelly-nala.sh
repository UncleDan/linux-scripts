#!/bin/bash
echo "***** CUSTOMIZING... *****"
echo ""

echo "** Set RTC time to avoid problems in dual boot..."
echo ""
sudo timedatectl set-local-rtc 1 --adjust-system-clock

echo "** BTRFS is the way, updating and tweaking ..."
echo ""
## Hints from: https://mutschler.dev/linux/ubuntu-btrfs-20-04/
sudo systemctl enable fstrim.timer

echo "Install nala package manager..."
echo "deb https://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list > /dev/null
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
sudo apt update && sudo apt install nala

## Again from: https://mutschler.dev/linux/ubuntu-btrfs-20-04/
echo "** Installing and running Timeshift, on first run choose your options..."
echo ""
sudo nala install timeshift -y
sudo timeshift-gtk

echo ""
echo "** Installing timeshift-autosnap-apt..."
echo ""
rm -rf ~/timeshift-autosnap-apt
git clone https://github.com/wmutschl/timeshift-autosnap-apt.git ~/timeshift-autosnap-apt
cd ~/timeshift-autosnap-apt
sudo make install

echo ""
echo "** Installing timeshift-autosnap-apt..."
echo ""
rm -rf ~/grub-btrfs
git clone https://github.com/Antynea/grub-btrfs.git 
cd ~/grub-btrfs
sudo make install
cd ~

echo ""
echo "** INTERNET: Installing Google Chrome DEB package from repository..."
echo ""
wget -qO - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/google-linux-signing-key.gpg > /dev/null
echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
sudo nala update && sudo nala install google-chrome-stable -y

echo ""
echo "** INTERNET: Installing Teamviewer DEB package from repository..."
echo ""
sudo wget -q https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc && sudo mv TeamViewer2017.asc /etc/apt/trusted.gpg.d/TeamViewer2017.asc
echo "deb [signed-by=/etc/apt/trusted.gpg.d/TeamViewer2017.asc] https://linux.teamviewer.com/deb stable main" | sudo tee /etc/apt/sources.list.d/teamviewer.list > /dev/null
sudo nala update && sudo nala install teamviewer -y

echo ""
echo "** INTERNET: Installing Anydesk DEB package via repository..."
echo ""
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/anydesk.gpg > /dev/null
echo "deb [signed-by=/etc/apt/trusted.gpg.d/anydesk.gpg] http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list > /dev/null
sudo nala update && sudo nala install anydesk -y

echo ""
echo "** UTILITY: Install Visual Studio Code DEB package via MS repository..."
echo ""
wget -qO - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/packages.microsoft.gpg > /dev/null
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
sudo nala update && sudo nala install code -y

echo ""
echo "** VIRTUALIZATION: Installing Oracle Virtualbox DEB package via repository..."
echo ""
wget -qO - https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor  | sudo tee /etc/apt/trusted.gpg.d/oracle-virtualbox-2016.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib" | sudo tee /etc/apt/sources.list.d/oracle-virtualbox.list > /dev/null
sudo nala update && sudo nala install virtualbox-6.1 -y

echo ""
echo "** Installing curl, git, zip, unzip, 7zip and flatpak commands..."
echo ""
sudo nala update && sudo nala install curl git zip unzip p7zip-full flatpak -y

echo ""
echo "** INTERNET: Installing Mozilla Thunderbird italian localization DEB package via repository..."
echo ""
sudo nala update && sudo nala install thunderbird-locale-it -y

echo ""
echo "** OFFICE: Installing Libreoffice localization DEB package..." ## Jelly is up to date to 7.3.2.2 as of 26/04/2022, if not Italian guide is here https://wiki.documentfoundation.org/Documentation/Install/Linux/it
echo ""
sudo nala update && sudo nala install libreoffice-l10n-it hyphen-it mythes-it libreoffice-help-it hunspell hunspell-it -y ## myspell-it has no candidates

## Temporary folder
tmp_dir=$(mktemp -d -t ci-$(date +%Y-%m-%d-%H-%M-%S)-XXXXXXXXXX)

echo ""
echo "** INTERNET: Installing Zoom DEB package..."
echo ""
curl -L https://zoom.us/client/latest/zoom_amd64.deb -o $tmp_dir/zoom_amd64.deb
sudo nala install $tmp_dir/zoom_amd64.deb -y

echo ""
echo "** INTERNET: Installing Webex DEB package..."
echo ""
curl -L https://binaries.webex.com/WebexDesktop-Ubuntu-Official-Package/Webex.deb -o $tmp_dir/Webex.deb
sudo nala install $tmp_dir/Webex.deb -y

echo ""
echo "** OFFICE: Installing Onlyoffice Desktop Editors DEB package..."
echo ""
curl -L https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb -o $tmp_dir/onlyoffice-desktopeditors_amd64.deb
sudo nala install $tmp_dir/onlyoffice-desktopeditors_amd64.deb -y

echo ""
echo "** UTILITY: Installing Angry IP scanner DEB package..."
echo ""
curl -L https://github.com/angryip/ipscan/releases/download/3.8.2/ipscan_3.8.2_amd64.deb -o $tmp_dir/ipscan_3.8.2_amd64.deb
sudo nala install $tmp_dir/ipscan_3.8.2_amd64.deb -y

echo ""
echo "** UTILITY: Install KeepassXC DEB package..."
echo ""
sudo nala update && sudo nala install keepassxc -y

echo ""
echo "** UTILITY: Install PUTTY DEB package..."
echo ""
sudo nala update && sudo nala install putty putty-doc -y

echo ""
echo "** UTILITY: Install Filezilla DEB package..."
echo ""
sudo nala update && sudo nala install filezilla -y

echo ""
echo "** UTILITY: Install OpenSSH Server DEB package..."
echo ""
sudo nala update && sudo nala install openssh-server -y

echo ""
echo "** UTILITY: Installing wine for Notepad++"
echo ""
sudo nala update && sudo nala install wine-stable -y

echo ""
echo "INTERNET: Remove Firefox snap and snapd..."
echo ""
sudo snap remove firefox 
sudo snap remove gtk-common-themes 
sudo snap remove gnome-3-38-2004 
sudo snap remove core20 
sudo snap remove bare 
sudo snap remove snapd 
sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service
sudo rm -rf /var/cache/snapd/
rm -rf ~/snap
sudo nala purge snapd -y

echo ""
echo "** GRAPHICS: Removing GIMP DEB package..."
echo ""
sudo nala purge gimp* -y

echo ""
echo "INTERNET: Removing Firefox snap and snapd..."
echo ""
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub org.mozilla.firefox

echo ""
echo "** GRAPHICS: Installing GIMP flatpak package..."
echo ""
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak -y install flathub org.gimp.GIMP

echo ""
echo "** INTERNET: Installing TOR Browser TXZ package in user home folder..."
echo ""
curl -L https://www.torproject.org/dist/torbrowser/11.5.1/tor-browser-linux64-11.5.1_it.tar.xz -o $tmp_dir/tor-browser-linux64-11.5.1_it.tar.xz
rm -rf ~/tor-browser_it/
tar -xvf $tmp_dir/tor-browser-linux64-11.5.1_it.tar.xz -C ~/
### sudo cp /home/uncledan/tor-browser_it/start-tor-browser.desktop /usr/share/applications/start-tor-browser.desktop
# ^^^ see if it can be added to user menu

echo ""
echo "** UTILITY: Installing FreeFileSync TGZ package..."
echo ""
curl -L https://freefilesync.org/download/FreeFileSync_11.23_Linux.tar.gz -o $tmp_dir/FreeFileSync_11.23_Linux.tar.gz
tar -xvzf $tmp_dir/FreeFileSync_11.23_Linux.tar.gz -C $tmp_dir
$tmp_dir/FreeFileSync_11.23_Install.run
# ^^^ Check if FreeFileSync can be completely silent

echo ""
echo "** MULTIMEDIA: Install Avidemux AppImage package, close Firefox when download is finished..."
echo ""
pkill -e -f firefox
flatpak run org.mozilla.firefox  --new-instance --private-window "https://www.fosshub.com/Avidemux.html?dwl=avidemux_2.8.0.appImage"
pkill -e -f avidemux
sudo rm -rf /opt/avidemux
sudo mkdir -p /opt/avidemux
sudo mv ~/Scaricati/avidemux_2.8.0.appImage /opt/avidemux/avidemux
sudo chown -R root:root /opt/avidemux
sudo chmod -R 755 /opt/avidemux
/opt/avidemux/avidemux
cat << EOF | sudo tee /usr/share/applications/avidemux.desktop 1> /dev/null
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
EOF

echo ""
echo "** INTERNET: Installing pCloud AppImage package, close Firefox when download is finished..."
echo ""
pkill -e -f firefox
flatpak run org.mozilla.firefox --new-instance --private-window "https://www.pcloud.com/how-to-install-pcloud-drive-linux.html?download=electron-64"
pkill -e -f pcloud
sudo rm -rf /opt/pcloud
sudo mkdir -p /opt/pcloud
sudo mv ~/Scaricati/pcloud /opt/pcloud/
sudo chown -R root:root /opt/pcloud
sudo chmod -R 755 /opt/pcloud
### Suggested from pCloud site but maybe unnecessary on Ubuntu Studio
### sudo add-apt-repository -y universe
### sudo apt install libfuse2
/opt/pcloud/pcloud

echo ""
echo "** UTILITY: Installing Notepad++ with wine..."
echo ""
curl -L https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.4/npp.8.4.4.Installer.x64.exe -o $tmp_dir/npp.8.4.4.Installer.x64.exe
wine $tmp_dir/npp.8.4.4.Installer.x64.exe

echo ""
echo "** UPDATE: Upgrade and clean all DEB packages (again)..."
echo ""
sudo nala upgrade -y

echo ""
echo "** UPDATE: Update all flatpak packages..."
echo ""
sudo flatpak update -y

echo ""
echo "DONE: reboot suggested."

### ----------------------------------------------------------------------
### THE END
### ----------------------------------------------------------------------
