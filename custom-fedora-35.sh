#!/bin/bash
echo "*** CUSTOMIZING..."
echo ""
echo "** Update all..."
echo ""
echo "* Update RPM and flatpak packages"
sudo dnf upgrade -y
sudo flatpak update
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
echo "** Installing VLC RPM package..."
echo ""
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
echo ""
echo "** Installing multimedia codecs and plugins RPM package..."
echo ""
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y
echo ""
echo "** OBS flatpak package..."
echo ""
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.obsproject.Studio -y
flatpak run com.obsproject.Studio
echo ""
echo "** Installing Zoom RPM package..."
echo ""
wget https://zoom.us/client/latest/zoom_x86_64.rpm
sudo dnf localinstall ./zoom_x86_64.rpm -y
rm -rf ./zoom_x86_64.rpm
echo ""
echo "** Installing Zoom RPM package..."
echo ""
wget https://binaries.webex.com/WebexDesktop-CentOS-Official-Package/Webex.rpm
sudo dnf localinstall ./Webex.rpm -y
rm -rf ./Webex.rpm
echo "** Installing Mozilla Thunderbird and other utilities RPM packages..."
sudo dnf install keepassxc vlc openssh-server git putty zip unzip p7zip p7zip-plugins thunderbird -y
echo ""
echo "** Remove Libreoffice RPM packages and install Libreoffice flatpak package..."
echo ""
sudo dnf remove libreoffice* -y
sudo flatpak install org.libreoffice.LibreOffice -y
flatpak run org.libreoffice.LibreOffice
echo ""
echo "** Installing Angry IP Scanner RPM package..."
echo ""
wget https://github.com/angryip/ipscan/releases/download/3.8.2/ipscan-3.8.2-1.x86_64.rpm
sudo dnf localinstall ./ipscan-3.8.2-1.x86_64.rpm -y
rm -rf ./ipscan-3.8.2-1.x86_64.rpm

***

echo ""
echo "** Installing pCloud AppImage..."
echo ""
wget https://p-lux2.pcloud.com/cBZu1eKrMZMqwjTqZZZfaPJr7Z2ZZNT0ZkZPF7pVZrHZrzZBpZpRZc5Z6pZopZ9pZApZGFZUJZkJZPpZkzZWTVkVZuTcIqtoQLr7OPrGNAbuQHueYMv7X/pcloud
sudo mkdir -p /opt/pcloud
sudo mv ./pcloud /opt/pcloud/
sudo chmod -R 755 /opt/pcloud
/opt/pcloud/pcloud


echo "** Install Snap Notepad++"
sudo snap install notepad-plus-plus

### CHECKED ABOVE ^^^ ###

echo ""
echo "** Installing FreeFileSync..."
echo ""
wget https://filedn.com/lAHAHtmqjaTjJxFAtUSMfN8/files/archive/Software/Linux/FreeFileSync_11.10_Linux.tar.gz
tar -xvzf FreeFileSync_11.10_Linux.tar.gz
rm -rf FreeFileSync_11.10_Linux.tar.gz
./FreeFileSync_11.10_Install.run
rm -rf FreeFileSync_11.10_Install.run
# ^^^ Check if FreeFileSync can be completely silent

echo ""
echo "ATTENZIONE! per attivare pCloud fare doppio click sul relativo eseguibile."
echo "Se non funziona riscaicare AppImage aggiornata da:"
echo "https://www.pcloud.com/it/how-to-install-pcloud-drive-linux.html"
echo ""
echo ""
# ^^^ Still some problems on pcloud, it would be nice to have it completely automatic.


sudo dnf autoremove -y

echo "DONE."
