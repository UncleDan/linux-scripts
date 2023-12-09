### Project: UNCLEDAN CUSTOM WORKSTATION
### Base OS: OpenSUSE Tumbleweed

#!/bin/bash
FREEFILESYNC_VERSION="13.2"
IPSCAN_VERSION="3.9.1"
STRETCHLY_VERSION="1.15.1"
VEEAM_VERSION="1.0.8"
TORBROWSER_VERSION="13.0.6"

TMP_DIR=$(mktemp -d -t cl-$(date +%Y%m%d-%H%M%S)-XXXXXX)

### Additional software:
# 7zip (via repository)
# Angry IP Scanner (via RPM package)
# Anydesk (via external repository)
# Audacity (via repository)
# Avidemux (via repository)
# Code [Microsoft Virtual Studio Code] (via external repository)
# Filezilla (via repository)
# FreeFileSync TGZ package (via TGZ package)
# Git {via repository}
# Google Chrome (via external repository)
# Kdenlive (mediainfo frei0r-plugins) {via repository}
# KeepassXC {via repository}
# Libre Office (italiano) {via repository}
# NotepadQQ (Notepad++ clone) {via repository}
# OBS Studio {via repository}
# Olive Video Editor {via AppImage package}
# Only Office Desktop Editors {via flatpak}
# OpenSSH Server {via repository}
# pCloud {via AppImage Package}
# Putty {via repository}
# Stretchly {via flatpak}
# Supremo {Windows packege via wine}
# Teamviewer {via external repository}
# Thunderbird [Mozilla Thunderbird] {via repository}
# TOR Browser {via TXZ package}
# Veeam Backup Agent  {via external repository}*
# VirtualBox [Oracle VirtualBox] {via external repository}
# Webex {via RPM package}
# zip unzip {via repository}
# Zoom {via RPM package}

# * Error:
# WARNING: /usr/lib/dkms/common.postinst does not exist.
# ERROR: DKMS version is too old and blksnap was not
# built with legacy DKMS support.
# You must either rebuild blksnap with legacy postinst
# support or upgrade DKMS to a more current version.


sudo echo "***** CUSTOMIZING... *****"
echo ""

echo "** Set RTC time to avoid problems in dual boot..."
echo ""
sudo timedatectl set-local-rtc 1 --adjust-system-clock

### INSTALLATIONS FROM REPO ###

echo ""
echo "** Add AnyDesk repository and key..."
echo ""
sudo rpm --import https://keys.anydesk.com/repos/RPM-GPG-KEY
cat > $TMP_DIR/AnyDesk-OpenSUSE.repo << "EOF"
[anydesk]
name=AnyDesk OpenSUSE - stable
baseurl=http://rpm.anydesk.com/opensuse/$basearch/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOF
sudo zypper addrepo --repo $TMP_DIR/AnyDesk-OpenSUSE.repo

echo ""
echo "** Add Visual Studio repository and key..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode

echo ""
echo "** Add Google Chrome repository and key..."
sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub
sudo zypper addrepo http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome

echo ""
echo "** Add Teamviewer repository and key..."
sudo rpm --import https://linux.teamviewer.com/pubkey/currentkey.asc
cat > $TMP_DIR/teamviewer.repo  << "EOF"
[teamviewer]
name=TeamViewer - $basearch
baseurl=https://linux.teamviewer.com/yum/stable/main/binary-$basearch/
gpgkey=https://linux.teamviewer.com/pubkey/currentkey.asc
gpgcheck=1
repo_gpgcheck=1
enabled=1
type=rpm-md
EOF
sudo zypper addrepo --repo $TMP_DIR/teamviewer.repo

echo ""
echo "** Add Veeam repository and key..."
sudo rpm --import http://repository.veeam.com/keys/RPM-EFDCEA77
cat > $TMP_DIR/veeam.repo  << "EOF"
[veeam]
name=Veeam Backup for GNU/Linux - $basearch
baseurl=http://repository.veeam.com/backup/linux/agent/rpm/suse/openSUSE
enabled=1
autorefresh=1
gpgcheck=1
gpgkey=http://repository.veeam.com/keys/RPM-EFDCEA77
EOF
sudo zypper addrepo --repo $TMP_DIR/veeam.repo

echo ""
echo "** Install from repositories..."
sudo zypper -n refresh
sudo zypper -n install \
 anydesk \
 code \
 google-chrome-stable \
 teamviewer-suse \
 veeam \
 7zip \
 audacity \
 digikam \
 filezilla \
 gimp \
 git-core \
 inkscape xsane \
 kdenlive mediainfo frei0r-plugins \
 keepassxc \
 MozillaThunderbird \
 obs-studio \
 openssh-server\
 partitionmanager \
 putty \
 virtualbox \
 zip unzip

echo ""
echo "** Upgrade from repositories..."
sudo zypper -n dist-upgrade

echo ""
echo "** Adding user to group vboxusers (remember to reboot!)"
sudo gpasswd -a $(whoami) vboxusers

echo ""
echo "** Installing codecs, VLC (if not installed) and Avidemux from 'packman' repositories..."
echo ""
sudo zypper --gpg-auto-import-keys addrepo -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/' packman ### check why the key is not imported
sudo zypper refresh
sudo zypper -n dist-upgrade --from packman --allow-vendor-change
sudo zypper -n install --from packman \
 ffmpeg \
 gstreamer-plugins-{good,bad,ugly,libav} \
 libavcodec-full \
 vlc vlc-codecs \
 avidemux3-qt5

### INSTALLATIONS FROM RPM PACKAGES ###

echo ""
echo "** Installing Angry IP Scanner RPM package..."
echo ""
curl -L https://github.com/angryip/ipscan/releases/download/$IPSCAN_VERSION/ipscan-$IPSCAN_VERSION-1.x86_64.rpm -o $TMP_DIR/ipscan.rpm
echo ""
echo "If an error is reported, choose to continue ignoring the signature (at your own risk)..." ## check if you can do better
echo ""
sudo zypper install $TMP_DIR/ipscan.rpm

echo ""
echo "** Installing Webex RPM package..."
sudo rpm --import https://binaries.webex.com/WebexDesktop-Ubuntu-Official-Package/webex_public.key
curl -L https://binaries.webex.com/WebexDesktop-CentOS-Official-Package/Webex.rpm -o $TMP_DIR/webex.rpm
echo ""
echo "If an error is reported, choose to continue ignoring the dependencies (at your own risk)..." ## check if you can do better
echo ""
sudo zypper install $TMP_DIR/webex.rpm

echo ""
echo "** Installing Zoom RPM package..."
curl -L https://zoom.us/client/latest/zoom_openSUSE_x86_64.rpm -o $TMP_DIR/zoom.rpm
echo ""
echo "If an error is reported, choose to continue ignoring the signature (at your own risk)..." ## check if you can do better
echo ""
sudo zypper install $TMP_DIR/zoom.rpm

### INSTALLATIONS FROM APPIMAGE ###

mkdir -p ~/AppImages

echo ""
echo "Installing Olive Video Editor AppImage package, click on the download for Linux icon and close Firefox when download is finished..."
echo ""
pkill -e -f firefox ; firefox --new-instance --private-window "https://www.olivevideoeditor.org/download"
mv ~/Scaricati/Olive-*.zip $TMP_DIR/Olive.zip
7z e $TMP_DIR/Olive.zip -o$TMP_DIR
sudo mv $TMP_DIR/Olive-*.AppImage /usr/bin/olive-editor
sudo chown root:root /usr/bin/olive-editor ; sudo chmod 755 /usr/bin/olive-editor
sudo 7z e /usr/bin/olive-editor org.olivevideoeditor.Olive.desktop -o/usr/share/applications/ # check icon and decide if moving to ~/AppImages

echo ""
echo "** Installing pCloud AppImage..."
echo ""
pkill -e -f firefox ; firefox --new-instance --private-window "https://www.pcloud.com/how-to-install-pcloud-drive-linux.html?download=electron-64"
sudo rm -f /usr/bin/pcloud
sudo mv ~/Scaricati/pcloud /usr/bin/pcloud
sudo chown root:root /usr/bin/pcloud ; sudo chmod 755 /usr/bin/pcloud
/usr/bin/pcloud

### INSTALLATIONS FROM FLATHUB ###

echo "** Installing Onlyoffice Desktop Editors as flatpak..." ## openSUSE is not mentioned for RPM
sudo flatpak install -y https://dl.flathub.org/repo/appstream/org.onlyoffice.desktopeditors.flatpakref

echo "** Installing Stretchly as flatpak..."
sudo flatpak install -y https://dl.flathub.org/repo/appstream/net.hovancik.Stretchly.flatpakref

### INSTALLATIONS FROM TAR GZ/XZ ###

echo ""
echo "** Installing FreeFileSync TGZ package..."
echo ""
curl -L "https://freefilesync.org/download/FreeFileSync_${FREEFILESYNC_VERSION}_Linux.tar.gz"  -o $TMP_DIR/freefilesync.tar.gz
tar -xvzf $TMP_DIR/freefilesync.tar.gz -C $TMP_DIR
sudo $TMP_DIR/FreeFileSync_${FREEFILESYNC_VERSION}_Install.run
# ^^^ Check if FreeFileSync can be completely silent
rm -f ~/Scrivania/{FreeFileSync,RealTimeSync}.desktop
# ^^^ remove icons on desktop if createf by chance

echo ""
echo "Installing TOR Browser TXZ package..."
curl -L https://www.torproject.org/dist/torbrowser/${TORBROWSER_VERSION}/tor-browser-linux-x86_64-${TORBROWSER_VERSION}.tar.xz -o $TMP_DIR/tor-browser.tar.xz
tar -xvf $TMP_DIR/tor-browser.tar.xz -C ~
chmod +x ~/tor-browser/start-tor-browser.desktop ; cd ~/tor-browser/ ; ./start-tor-browser.desktop --register-app ; cd ~

### INSTALLATIONS FROM WINDOWS PACKAGES ###

echo ""
echo "Installing Supremo to be run with wine in home folder, close Firefox when download is finished..."
pkill -e -f firefox ; firefox --new-instance --private-window "https://www.supremocontrol.com/it/supremo-download/?autoDownload=1"
7z e ~/Scaricati/Supremo.exe .rsrc/1033/ICON/3.ico -o$TMP_DIR
mv $TMP_DIR/3.ico ~/.local/share/icons/Supremo.ico
mkdir -p ~/.wine/drive_c/'Program Files (x86)'/Supremo
mv ~/Scaricati/Supremo.exe ~/.wine/drive_c/'Program Files (x86)'/Supremo/Supremo.exe
cat <<EOF > ~/.local/share/applications/Supremo.desktop
[Desktop Entry]
Comment=
Exec=env WINEPREFIX=/home/$(whoami)/.wine wine '/home/$(whoami)/.wine/drive_c/Program Files (x86)/Supremo/Supremo.exe'
GenericName=Supremo Remote Control
Icon=/home/$(whoami)/.local/share/icons/Supremo.ico
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

echo ""
echo "If you want you can set KDE theme to \"Breeze Dark\" (Brezza scuro) and style to \"Oxygen\" (Oxygen) and move the dock to the top side."
echo ""
echo "DONE."
