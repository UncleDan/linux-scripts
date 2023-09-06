#!/bin/bash
FREEFILESYNC_VERSION="12.5"
IPSCAN_VERSION="3.9.1"
STRETCHLY_VERSION="1.14.1"
VEEAM_VERSION="1.0.8"
TORBROWSER_VERSION="12.5.2"

TMP_DIR=$(mktemp -d -t cl-$(date +%Y%m%d-%H%M%S)-XXXXXX)

sudo echo "***** CUSTOMIZING... *****"
echo ""

echo "** Set RTC time to avoid problems in dual boot..."
echo ""
sudo timedatectl set-local-rtc 1 --adjust-system-clock


echo ""
echo "** Add Anydesk repository and key..."
wget -O- https://keys.anydesk.com/repos/DEB-GPG-KEY | gpg --dearmor --yes | sudo tee /usr/share/keyrings/anydesk.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/anydesk.gpg] http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list > /dev/null

echo ""
echo "** Add Google Chrome repository and key..."
wget -O- https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor --yes | sudo tee /usr/share/keyrings/google-linux-signing-key.gpg  > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux-signing-key.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
## in case google reverts the apt list
sudo cp /usr/share/keyrings/google-linux-signing-key.gpg /etc/apt/trusted.gpg.d/google-linux-signing-key.gpg

echo ""
echo "** Add Oracle VirtualBox repository and key..."
## it seems that mx repository has priority!
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor --yes | sudo tee /usr/share/keyrings/oracle-virtualbox-2016.gpg  > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bookworm contrib" | sudo tee /etc/apt/sources.list.d/oracle-virtualbox.list > /dev/null

echo ""
echo "** Add Teamviewer repository and Key..."
sudo wget -O /usr/share/keyrings/TeamViewer2017.asc https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/TeamViewer2017.asc] https://linux.teamviewer.com/deb stable main" | sudo tee /etc/apt/sources.list.d/teamviewer.list > /dev/null

echo ""
echo "** Add Virtual Studio Code repository and key..."
wget -O- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor --yes | sudo tee /usr/share/keyrings/packages.microsoft.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

echo ""
echo "Updating and upgraging..."
sudo apt update
sudo apt upgrade -y

echo ""
echo "Downloading DEB additional packages..."
echo ""
wget -O $TMP_DIR/ipscan.deb https://github.com/angryip/ipscan/releases/download/${IPSCAN_VERSION}/ipscan_${IPSCAN_VERSION}_amd64.deb
wget -O $TMP_DIR/onlyoffice.deb https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb
wget -O $TMP_DIR/stretchly.deb https://github.com/hovancik/stretchly/releases/download/v${STRETCHLY_VERSION}/Stretchly_${STRETCHLY_VERSION}_amd64.deb
wget -O $TMP_DIR/veeam-repo.deb https://filedn.com/lAHAHtmqjaTjJxFAtUSMfN8/files/archive/Software/Linux/veeam-release-deb_${VEEAM_VERSION}_amd64.deb
sudo dpkg -i $TMP_DIR/veeam-repo.deb
wget -O $TMP_DIR/webex.deb https://binaries.webex.com/WebexDesktop-Ubuntu-Official-Package/Webex.deb
wget -O $TMP_DIR/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb

echo " Installing DEB packages..."
echo ""
sudo apt install -y \
 avidemux \
 audacity \
 filezilla \
 keepassxc \
 libreoffice-l10n-it hyphen-it mythes-it libreoffice-help-it hunspell hunspell-it \
 obs-studio \
 openssh-server \
 putty putty-doc \
 p7zip-full \
 thunderbird-l10n-it \
 winehq-staging:i386 \
 zip unzip \
 anydesk \
 google-chrome-stable \
 virtualbox \
 teamviewer \
 code \
 $TMP_DIR/ipscan.deb \
 $TMP_DIR/onlyoffice.deb \
 $TMP_DIR/stretchly.deb \
 veeam blksnap \
 $TMP_DIR/webex.deb \
 $TMP_DIR/zoom.deb

echo ""
echo "** Installing FreeFileSync TGZ package..."
echo ""
wget -O $TMP_DIR/freefilesync.tar.gz "https://freefilesync.org/download/FreeFileSync_${FREEFILESYNC_VERSION}_Linux.tar.gz"
tar -xvzf $TMP_DIR/freefilesync.tar.gz -C $TMP_DIR
sudo $TMP_DIR/FreeFileSync_${FREEFILESYNC_VERSION}_Install.run
# ^^^ Check if FreeFileSync can be completely silent
rm -f ~/Scrivania/FreeFileSync.desktop
rm -f ~/Scrivania/RealTimeSync.desktop
# ^^^ remove icons on desktop if createf by chance

echo ""
echo "Installing pCloud AppImage package, close Firefox when download is finished..."
echo ""
pkill -e -f firefox
firefox --new-instance --private-window "https://www.pcloud.com/how-to-install-pcloud-drive-linux.html?download=electron-64"
pkill -e -f pcloud ; sudo rm -rf /usr/bin/pcloud
sudo mv ~/Scaricati/pcloud /usr/bin/pcloud
sudo chown root:root /usr/bin/pcloud
sudo chmod 755 /usr/bin/pcloud
### Suggested from pCloud site but maybe unnecessary on Ubuntu Studio
### sudo add-apt-repository -y universe
### sudo apt install libfuse2
echo "Launching pCloud to create menu, close with Ctrl+C to continue..."
/usr/bin/pcloud

echo ""
echo "Installing Olive Video Editor AppImage package, click on the download for Linux icon and close Firefox when download is finished..."
echo ""
pkill -e -f firefox ; firefox --new-instance --private-window "https://www.olivevideoeditor.org/download"
mv ~/Scaricati/Olive-*.zip $TMP_DIR/Olive.zip
7z e $TMP_DIR/Olive.zip -o$TMP_DIR
sudo mv $TMP_DIR/Olive-*.AppImage /usr/bin/olive-editor
sudo chown root:root /usr/bin/olive-editor ; sudo chmod 755 /usr/bin/olive-editor
sudo 7z e /usr/bin/olive-editor org.olivevideoeditor.Olive.desktop -o/usr/share/applications/

echo ""
echo "Installing TOR Browser TXZ package..."
echo ""
wget -O $TMP_DIR/tor-browser.tar.xz https://www.torproject.org/dist/torbrowser/${TORBROWSER_VERSION}/tor-browser-linux64-${TORBROWSER_VERSION}_ALL.tar.xz
tar -xvf $TMP_DIR/tor-browser.tar.xz -C ~
chmod +x ~/tor-browser/start-tor-browser.desktop
cd ~/tor-browser/ ; ./start-tor-browser.desktop --register-app ; cd ~

echo ""
echo "Installing Supremo to be run with wine in home folder, close Firefox when download is finished..."
echo ""
pkill -e -f firefox ; firefox --new-instance --private-window "https://www.supremocontrol.com/it/supremo-download/?autoDownload=1"
7z e ~/Scaricati/Supremo.exe .rsrc/1033/ICON/3.ico -o$TMP_DIR
mv $TMP_DIR/3.ico /home/uncledan/.local/share/icons/Supremo.ico
mkdir -p .wine/drive_c/'Program Files (x86)'/Supremo
mv ~/Scaricati/Supremo.exe /home/uncledan/.wine/drive_c/'Program Files (x86)'/Supremo/Supremo.exe
cat <<EOF > /home/uncledan/.local/share/applications/Supremo.desktop
[Desktop Entry]
Comment=
Exec=env WINEPREFIX=/home/uncledan/.wine /opt/wine-staging/bin/wine '/home/uncledan/.wine/drive_c/Program Files (x86)/Supremo/Supremo.exe'
GenericName=Supremo Remote Control
Icon=/home/uncledan/.local/share/icons/Supremo.ico
Name=Supremo
NoDisplay=false
Path=
StartupNotify=true
Terminal=false
TerminalOptions=
Type=Application
X-KDE-SubstituteUID=false
X-KDE-Username=
EOF

### ----------------------------------------------------------------------
### THE END
### ----------------------------------------------------------------------
