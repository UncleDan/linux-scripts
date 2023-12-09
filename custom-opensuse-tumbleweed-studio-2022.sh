#!/bin/bash
echo "*** CUSTOMIZING..."
echo ""
echo "** Update all..."
echo ""
sudo zypper -n refresh
sudo zypper -n dist-upgrade
tmp_dir=$(mktemp -d -t ci-$(date +%Y-%m-%d-%H-%M-%S)-XXXXXXXXXX)
echo ""
echo "** Installing Google Chrome RPM package..."
echo ""
sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub
sudo zypper addrepo http://dl.google.com/linux/chrome/rpm/stable/x86_64 Google-Chrome
sudo zypper -n install google-chrome-stable
echo ""
echo "** Installing Teamviewer RPM package..."
echo ""
curl -L https://download.teamviewer.com/download/linux/teamviewer-suse.x86_64.rpm -o $tmp_dir/teamviewer-suse.x86_64.rpm
sudo rpm --import https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc
sudo zypper -n install $tmp_dir/teamviewer-suse.x86_64.rpm
sudo zypper -n refresh
echo ""
echo "** Installing Anydesk RPM package from repo..."
echo ""
cat > $tmp_dir/AnyDesk-OpenSUSE.repo << "EOF" 
[anydesk]
name=AnyDesk OpenSUSE - stable
baseurl=http://rpm.anydesk.com/opensuse/$basearch/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOF
sudo zypper addrepo --repo $tmp_dir/AnyDesk-OpenSUSE.repo ## test if it works with file in temporary folder
sudo rpm --import https://keys.anydesk.com/repos/RPM-GPG-KEY
sudo zypper -n install anydesk
echo ""
echo "** Installing KDE Partition Manager RPM package..."
echo ""
sudo zypper -n install partitionmanager
echo ""
echo "** Installing Visual Studio Code RPM package from repo..."
echo ""
sudo zypper addrepo https://packages.microsoft.com/yumrepos/vscode vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo zypper -n refresh
sudo zypper -n install code
echo ""
echo "** Installing Mozilla Thunderbird RPM package..."
echo ""
sudo zypper -n install thunderbird
echo "** Installing other utilities RPM packages..."
sudo zypper -n install keepassxc putty zip
### LibreOffice already up to date ###
# echo ""
# echo "** Remove Libreoffice RPM old packages and install Libreoffice RPM latest packages package..."
# echo ""
# sudo dnf remove libreoffice* -y
# wget https://libreoffice.mirror.garr.it/libreoffice/stable/7.3.2/rpm/x86_64/LibreOffice_7.3.2_Linux_x86-64_rpm.tar.gz
# tar -xvzf ./LibreOffice_7.3.2_Linux_x86-64_rpm.tar.gz
# rm -rf LibreOffice_7.3.2_Linux_x86-64_rpm.tar.gz
# vsudo dnf localinstall ./LibreOffice_7.3.2.2_Linux_x86-64_rpm/RPMS/*.rpm -y
# rm -rf ./LibreOffice_7.3.2.2_Linux_x86-64_rpm/
# wget https://libreoffice.mirror.garr.it/libreoffice/stable/7.3.2/rpm/x86_64/LibreOffice_7.3.2_Linux_x86-64_rpm_langpack_it.tar.gz
# tar -xvzf ./LibreOffice_7.3.2_Linux_x86-64_rpm_langpack_it.tar.gz
# rm -rf LibreOffice_7.3.2_Linux_x86-64_rpm_langpack_it.tar.gz
# sudo dnf localinstall ./LibreOffice_7.3.2.2_Linux_x86-64_rpm_langpack_it/RPMS/*.rpm -y
# rm -rf ./LibreOffice_7.3.2.2_Linux_x86-64_rpm_langpack_it/
echo ""
echo "** Installing Onlyoffice Desktop Editors flatpak package..." ## openSUSE is not mentioned for RPM compatibility
echo ""
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub org.onlyoffice.desktopeditors -y
echo ""
echo "** Installing Microsoft fonts RPM helper package..."
echo ""
sudo zypper -n install fetchmsttfonts
### GIMP added in the grapghics section
# echo ""
# echo "** Installing The GIMP RPM package..."
# echo ""
# sudo zypper -n install gimp
echo ""
echo "** Installing codecs and VLC (if not installed) RPM packages..."
echo ""
sudo zypper --gpg-auto-import-keys addrepo -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/' packman ### check if key gets imported
sudo zypper refresh
sudo zypper -n dist-upgrade --from packman --allow-vendor-change
sudo zypper -n install --from packman ffmpeg gstreamer-plugins-{good,bad,ugly,libav} libavcodec-full vlc-codecs vlc
echo ""
echo "** Installing Avidemux RPM package from repo..."
echo ""
sudo zypper -n install avidemux3-qt5
echo ""
echo "** Installing Zoom RPM package..."
echo ""
curl -L https://zoom.us/client/latest/zoom_openSUSE_x86_64.rpm -o $tmp_dir/zoom_openSUSE_x86_64.rpm
sudo rpm --import https://zoom.us/linux/download/pubkey
sudo zypper -n install $tmp_dir/zoom_openSUSE_x86_64.rpm
echo ""
echo "** Installing Webex RPM package..."
curl -L https://binaries.webex.com/WebexDesktop-CentOS-Official-Package/Webex.rpm -o $tmp_dir/Webex.rpm
sudo rpm --import https://binaries.webex.com/WebexDesktop-Ubuntu-Official-Package/webex_public.key
echo ""
echo "If an error is reported, choose to continue ignoring the dependencies (at your own risk)..." ## check if you can do better
echo ""
sudo zypper install $tmp_dir/Webex.rpm
echo ""
echo "** Installing pCloud AppImage..."
echo ""
firefox --new-instance --private-window "https://www.pcloud.com/how-to-install-pcloud-drive-linux.html?download=electron-64"
sudo rm -rf /opt/pcloud
sudo mkdir -p /opt/pcloud
sudo mv ~/Scaricati/pcloud /opt/pcloud/
sudo chmod -R 755 /opt/pcloud
/opt/pcloud/pcloud
echo ""
echo "** Installing Angry IP Scanner RPM package..."
echo ""
curl -L https://github.com/angryip/ipscan/releases/download/3.8.2/ipscan-3.8.2-1.x86_64.rpm -o $tmp_dir/ipscan-3.8.2-1.x86_64.rpm
echo ""
echo "If an error is reported, choose to continue ignoring the signature (at your own risk)..." ## check if you can do better
echo ""
sudo zypper install $tmp_dir/ipscan-3.8.2-1.x86_64.rpm
echo ""
echo "** Installing FreeFileSync..."
echo ""
curl -L https://freefilesync.org/download/FreeFileSync_11.22_Linux.tar.gz -o $tmp_dir/FreeFileSync_11.22_Linux.tar.gz
tar -xvzf $tmp_dir/FreeFileSync_11.22_Linux.tar.gz -C $tmp_dir/
$tmp_dir/FreeFileSync_11.22_Install.run
### ^^^ Check if FreeFileSync can be completely silentecho ""
echo "** Installing wine and Notepad++"
echo ""
sudo zypper -n install wine
curl -L https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.2/npp.8.4.2.Installer.x64.exe -o $tmp_dir/npp.8.4.2.Installer.x64.exe
wine $tmp_dir/npp.8.4.2.Installer.x64.exe
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