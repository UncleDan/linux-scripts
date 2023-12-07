#!/bin/bash
FREEFILESYNC_VERSION="12.5"
IPSCAN_VERSION="3.9.1"
STRETCHLY_VERSION="1.15.1"
VEEAM_VERSION="1.0.8"
TORBROWSER_VERSION="12.5.3"

TMP_DIR=$(mktemp -d -t cl-$(date +%Y%m%d-%H%M%S)-XXXXXX)

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
echo "** Install from repositories..."
sudo zypper -n refresh
sudo zypper -n install anydesk \
 code \
 google-chrome-stable \
 teamviewer-suse \
 7zip \
 audacity \
 filezilla \
 kdenlive mediainfo frei0r-plugins \
 keepassxc \
 openssh-server\
 partitionmanager \
 putty \
 thunderbird \
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
echo ""
curl -L https://zoom.us/client/latest/zoom_openSUSE_x86_64.rpm -o $TMP_DIR/zoom.rpm
sudo rpm --import https://zoom.us/linux/download/pubkey
sudo zypper -n install $TMP_DIR/zoom.rpm


### INSTALLATIONS FROM APPIMAGE ###

mkdir -p ~/AppImages

echo ""
echo "** Installing Onlyoffice Desktop Editors as AppImage..." ## openSUSE is not mentioned for RPM
rm -f ~/AppImages/DesktopEditors-x86_64.AppImage
curl -L https://github.com/ONLYOFFICE/appimage-desktopeditors/releases/download/v7.5.1/DesktopEditors-x86_64.AppImage -o ~/AppImages/DesktopEditors-x86_64.AppImage
chmod +x ~/AppImages/DesktopEditors-x86_64.AppImage
~/AppImages/DesktopEditors-x86_64.AppImage ## check wrond display size or switch to flathub (MBs??)

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
mv ~/Scaricati/pcloud ~/AppImages/pCloud.AppImage
chmod +x ~/AppImages/pCloud.AppImage
/opt/pcloud/pcloud

echo ""
echo "** Stretchly as AppImage..." ## missing dependencies for RPM
rm -f ~/AppImages/Stretchly.AppImage
wget -O ~/AppImages/Stretchly.AppImage https://github.com/hovancik/stretchly/releases/download/v$STRETCHLY_VERSION/Stretchly-$STRETCHLY_VERSION.AppImage
chmod +x ~/AppImages/Stretchly.AppImage
~/AppImages/Stretchly.AppImage ## check icon or switch to flatub (much more MBs!)

##### |||
##### VVV CHECK FROM HERE !!!

### INSTALLATIONS FROM TAR GZ/XZ ###

echo ""
echo "** Installing FreeFileSync..."
echo ""
curl -L https://freefilesync.org/download/FreeFileSync_11.22_Linux.tar.gz -o $TMP_DIR/FreeFileSync_11.22_Linux.tar.gz
tar -xvzf $TMP_DIR/FreeFileSync_11.22_Linux.tar.gz -C $TMP_DIR/
$TMP_DIR/FreeFileSync_11.22_Install.run
### ^^^ Check if FreeFileSync can be completely silentecho ""
echo "** Installing wine and Notepad++"
echo ""
sudo zypper -n install wine
curl -L https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.2/npp.8.4.2.Installer.x64.exe -o $TMP_DIR/npp.8.4.2.Installer.x64.exe
wine $TMP_DIR/npp.8.4.2.Installer.x64.exe
echo ""
echo "** Installing Oracle Virtualbox"
echo ""
sudo zypper -n install virtualbox
sudo gpasswd -a $USER vboxusers
echo ""
echo "A reboot might be required before Virtualbox first launche."
echo ""
echo "** Installing \"Studio\" features..."
echo ""
echo "* AUDIO: JACK, CARLA, Audacity, Qtractor, Hydrogen RPM packages..."
echo ""
sudo zypper -n install jack carla audacity qtractor hydrogen carla-vst
echo ""
echo "* AUDIO: Ardour flatpak package..."
echo ""
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub org.ardour.Ardour -y
echo ""
echo "** Installing Yoshimi RPM package from repo..."
echo ""
sudo zypper addrepo https://download.opensuse.org/repositories/multimedia:proaudio/openSUSE_Tumbleweed/multimedia:proaudio.repo
echo ""
echo "Official key not available: to continue choose always trusted key (at your own risk)" ## check if you can do better
echo ""
sudo zypper refresh
sudo zypper -n install yoshimi
echo ""
echo "* GRAPHICS: Blender, Inkscape, GIMP RPM packages..."
echo ""
sudo zypper -n install blender inkscape gimp
### Missing Pixopixel http://twilightedge.com/mac/pikopixel/
echo ""
echo "* PHOTOGRAPY: Darktable, Shotwell flatpak packages..."
echo ""
sudo flatpak install flathub org.darktable.Darktable -y
sudo flatpak install flathub org.gnome.Shotwell -y
echo ""
echo "* VIDEO: Openshot, Ffmpeg, Kdenlive(*) RPM packages..."
echo ""
sudo zypper -n install openshot ffmpeg kdenlive
echo ""
echo "* VIDEO: OBS(*) flatpak package..."
echo ""
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub com.obsproject.Studio -y
### not necessary anymore: flatpak run com.obsproject.Studio
echo ""
echo "If you want you can set KDE theme to \"Breeze Dark\" (Brezza scuro) and style to \"Oxygen\" (Oxygen) and move the dock to the top side."
echo ""
echo "DONE."
