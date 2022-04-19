#!/bin/bash
echo "*** CUSTOMIZING..."
echo ""
echo "** Update all..."
echo ""
echo "* Update RPM and flatpak packages"
echo ""
sudo dnf upgrade -y
sudo flatpak update
echo ""
echo "* Install EPEL repositories..."
echo ""
sudo dnf install \
    https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
    https://dl.fedoraproject.org/pub/epel/epel-next-release-latest-9.noarch.rpm
echo ""
echo "* Install NTFS support..."
echo ""
sudo dnf install ntfs-3g -y
echo ""
echo "** Installing Google Chrome RPM package..."
echo ""
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf localinstall ./google-chrome-stable_current_x86_64.rpm -y
rm -rf ./google-chrome-stable_current_x86_64.rpm
echo ""
echo "** Installing Teamviewer RPM package..."
echo ""
wget https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
sudo dnf localinstall ./teamviewer.x86_64.rpm -y
rm -rf ./teamviewer.x86_64.rpm
echo ""
echo "** Installing Visual Studio Code RPM package..."
echo ""
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update -y
sudo dnf install code -y
echo ""
echo "** Installing VLC flatpak package..."
echo ""
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install org.videolan.VLC -y
flatpak run org.videolan.VLC
echo ""
echo "** Installing multimedia codecs and plugins RPM package..."
echo ""
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} --exclude=gstreamer1-plugins-bad-free-devel -y
### STILL TO COME gstreamer1-plugin-openh264 gstreamer1-libav - REQUIRED??? 
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y
echo ""
echo "** OBS flatpak package..."
echo ""
sudo flatpak install flathub com.obsproject.Studio -y
flatpak run com.obsproject.Studio
echo ""
echo "** Installing Zoom RPM package..."
echo ""
wget https://zoom.us/client/latest/zoom_x86_64.rpm
sudo dnf localinstall ./zoom_x86_64.rpm -y
rm -rf ./zoom_x86_64.rpm
echo ""
echo "** Installing Webex RPM package..."
echo ""
wget https://binaries.webex.com/WebexDesktop-CentOS-Official-Package/Webex.rpm
sudo dnf localinstall ./Webex.rpm -y
rm -rf ./Webex.rpm
echo ""
echo "** Installing Mozilla Thunderbird and other utilities RPM packages..."
echo ""
sudo dnf install openssh-server git zip unzip p7zip p7zip-plugins thunderbird -y
echo ""
echo "** Installing Webex RPM package..."
echo ""
sudo flatpak install org.keepassxc.KeePassXC -y
flatpak run org.keepassxc.KeePassXC
### STILL TO COME??? putty
echo ""
echo "** Remove Libreoffice RPM old packages and install Libreoffice RPM latest packages package..."
echo ""
sudo dnf remove libreoffice* -y
wget https://libreoffice.mirror.garr.it/libreoffice/stable/7.3.2/rpm/x86_64/LibreOffice_7.3.2_Linux_x86-64_rpm.tar.gz
tar -xvzf ./LibreOffice_7.3.2_Linux_x86-64_rpm.tar.gz
rm -rf LibreOffice_7.3.2_Linux_x86-64_rpm.tar.gz
sudo dnf localinstall ./LibreOffice_7.3.2.2_Linux_x86-64_rpm/RPMS/*.rpm -y
rm -rf ./LibreOffice_7.3.2.2_Linux_x86-64_rpm/
wget https://libreoffice.mirror.garr.it/libreoffice/stable/7.3.2/rpm/x86_64/LibreOffice_7.3.2_Linux_x86-64_rpm_langpack_it.tar.gz
tar -xvzf ./LibreOffice_7.3.2_Linux_x86-64_rpm_langpack_it.tar.gz
rm -rf LibreOffice_7.3.2_Linux_x86-64_rpm_langpack_it.tar.gz
sudo dnf localinstall ./LibreOffice_7.3.2.2_Linux_x86-64_rpm_langpack_it/RPMS/*.rpm -y
rm -rf ./LibreOffice_7.3.2.2_Linux_x86-64_rpm_langpack_it/
echo ""
echo "** Installing Onlyoffice Desktop Editors RPM package..."
echo ""
wget https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors.x86_64.rpm
sudo dnf localinstall ./onlyoffice-desktopeditors.x86_64.rpm -y
rm -rf ./onlyoffice-desktopeditors.x86_64.rpm
echo ""
echo "** Installing Angry IP Scanner RPM package..."
echo ""
wget https://github.com/angryip/ipscan/releases/download/3.8.2/ipscan-3.8.2-1.x86_64.rpm
sudo dnf localinstall ./ipscan-3.8.2-1.x86_64.rpm -y
rm -rf ./ipscan-3.8.2-1.x86_64.rpm
echo ""
echo "** Installing pCloud AppImage..."
echo ""
firefox --new-instance --private-window "https://www.pcloud.com/how-to-install-pcloud-drive-linux.html?download=electron-64"
sudo rm -rf /opt/pcloud
sudo mkdir -p /opt/pcloud
sudo mv ~/Scaricati/pcloud /opt/pcloud/
sudo chown -R root:root/opt/pcloud
sudo chmod -R 755 /opt/pcloud
/opt/pcloud/pcloud
echo ""
echo "** Installing FreeFileSync..."
echo ""
wget https://freefilesync.org/download/FreeFileSync_11.20_Linux.tar.gz
tar -xvzf FreeFileSync_11.20_Linux.tar.gz
rm -rf FreeFileSync_11.20_Linux.tar.gz
./FreeFileSync_11.20_Install.run
rm -rf FreeFileSync_11.20_Install.run
# ^^^ Check if FreeFileSync can be completely silent
echo ""
echo "** Install wine and Notepad++"
echo ""
### STILL TO COME 
### sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/34/winehq.repo
### sudo dnf install winehq-stable -y
### wget https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.3.3/npp.8.3.3.Installer.x64.exe
### wine ./npp.8.3.3.Installer.x64.exe
### rm -rf ./npp.8.3.3.Installer.x64.exe
# ^^^ Check why notepad++ runs only from console by running "wine ~/.wine/drive_c/Program\ Files/Notepad++/notepad++.exe"
sudo dnf autoremove -y
echo "DONE."
