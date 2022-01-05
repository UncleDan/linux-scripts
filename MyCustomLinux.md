# MyCustomLinux (Linux Customization)

## MX Linux KDE x64

* Move bar to Top via MX Script "Rifiniture"
* Update vis Discover
* Install Codecs via MX Script "Installa Codecs"
* Teamviewer via deb package
```
curl -L https://download.teamviewer.com/download/linux/teamviewer_amd64.deb -o /tmp/[MyCustomLinux]_teamviewer.deb && sudo apt install /tmp/[MyCustomLinux]_teamviewer.deb -y
```
* Google Chrome debian package
```
curl -L https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /tmp/[MyCustomLinux]_google-chrome-stable.deb && sudo apt install /tmp/[MyCustomLinux]_google-chrome-stable.deb -y
```
* MS Visual Code via deb package
```
curl -L https://az764295.vo.msecnd.net/stable/899d46d82c4c95423fb7e10e68eba52050e30ba3/code_1.63.2-1639562499_amd64.deb -o /tmp/[MyCustomLinux]_code.deb && sudo apt install /tmp/[MyCustomLinux]_code.deb -y
```
* Libreoffice via Flatpak (remove apt version)
```
sudo apt remove libreoffice-common -y && sudo apt autoremove -y && flatpak install flathub org.libreoffice.LibreOffice -y
```
* Gimp via Flatpak (remove apt version)
```
sudo apt remove gimp -y && sudo apt autoremove -y && flatpak install flathub org.gimp.GIMP -y
```
* Firefox via Flatpak (remove apt version)
```
sudo apt remove firefox -y && sudo apt autoremove -y && flatpak install flathub org.mozilla.firefox -y
```
* Thunderbird via Flatpak (remove apt version)
```
sudo apt remove thunderbird -y && sudo apt autoremove -y && flatpak install flathub org.mozilla.Thunderbird -y
```
* 7zip via APT (p7zip*)
```
sudo apt install p7zip* -y
```
* pCloud via AppImage (move to /opt before running)
* WhatsAppQT via Flatpak
```
flatpak install flathub io.bit3.WhatsAppQT -y
```
* KeepassXC via Flatpak
```
flatpak install flathub org.keepassxc.KeePassXC -y
```
* Putty via APT (putty*)
```
sudo apt install putty* -y
```
* VLC via Flatpak (remove apt version)
```
flatpak install flathub org.videolan.VLC
```
* Open SSH server via APT
```
sudo apt install openssh-server -y
```
* Filezilla via Flatpak
```
flatpak install flathub org.filezillaproject.Filezilla -y
```
* Angry IP scanner via debian package
```
curl -L https://github.com/angryip/ipscan/releases/download/3.7.6/ipscan_3.7.6_amd64.deb -o /tmp/[MyCustomLinux]_ipscan.deb && sudo apt install /tmp/[MyCustomLinux]_ipscan.deb -y
```
* FreeFileSync via tgz installer (link for rel. 11.16)
```
mkdir -p /tmp/[MyCustomLinux]_freefilesync/ && curl -L https://freefilesync.org/get_file.static.php?hash=65527ed00b091cf46a065dc7dffde470 -o /tmp/[MyCustomLinux]_freefilesync.tgz && tar -xvzf /tmp/[MyCustomLinux]_freefilesync.tgz -C /tmp/[MyCustomLinux]_freefilesync/ && /tmp/[MyCustomLinux]_freefilesync/FreeFileSync_11.16_Install.run
```
* Zoom?
* Webex?
________________


## Checklist

________________


## custom-kubuntu-focal.sh - Latest commit d455c2d on 4 Nov 2021
```
#!/bin/bash
echo "*** CUSTOMIZING..."
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
sudo apt autoremove -y
echo ""
echo "** Set RTC time to avoid problems in dual boot..."
echo ""
sudo timedatectl set-local-rtc 1 --adjust-system-clock
echo ""
echo "** Install APT utilities and other stuff..."
sudo apt install keepassx vlc openssh-server xrdp xorgxrdp git putty wine-stable zip unzip p7zip-full filezilla curl flatpak -y
echo ""
echo "** Creating temporary folder..."
echo ""
tmp_dir=$(mktemp -d -t ci-$(date +%Y-%m-%d-%H-%M-%S)-XXXXXXXXXX)
echo ""
echo "** Installing Google Chrome deb package..."
echo ""
curl -L https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o $tmp_dir/google-chrome.deb
sudo apt install $tmp_dir/google-chrome.deb -y
echo ""
echo "** Installing Teamviewer deb package..."
echo ""
curl -L https://download.teamviewer.com/download/linux/teamviewer_amd64.deb -o $tmp_dir/teamviewer.deb
sudo apt install $tmp_dir/teamviewer.deb -y
echo ""
echo "** Installing Visual Studio Code deb package..."
echo ""
curl -L https://az764295.vo.msecnd.net/stable/c13f1abb110fc756f9b3a6f16670df9cd9d4cf63/code_1.61.1-1634175470_amd64.deb -o $tmp_dir/code.deb
sudo apt install $tmp_dir/code.deb -y
echo ""
echo "** Installing Angry IP Scanner deb package..."
echo ""
curl -L https://github.com/angryip/ipscan/releases/download/3.7.6/ipscan_3.7.6_amd64.deb -o $tmp_dir/ipscan.deb
sudo apt install $tmp_dir/ipscan.deb -y
echo ""
echo "** Remove APT Firefox, Thunderbird, Gimp and Libreoffice..."
echo ""
sudo apt remove firefox thunderbird gimp libreoffice-common -y
sudo apt autoremove -y
echo ""
echo "** Adding Flathub support..."
sudo apt install plasma-discover-backend-flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
echo ""
echo "** Install Flatpak Firefox, Thunderbird, Gimp and Libreoffice..."
flatpak install flathub org.mozilla.firefox -y
flatpak install flathub org.mozilla.Thunderbird -y
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub org.libreoffice.LibreOffice -y
flatpak install flathub us.zoom.Zoom -y
# MEMO: check if icons appear in the menu
# flatpak run org.mozilla.firefox &
# flatpak run org.mozilla.Thunderbird &
# flatpak run org.gimp.GIMP &
# flatpak run org.libreoffice.LibreOffice &
# flatpak run us.zoom.Zoom &
echo ""
echo "** Install Snap Notepad++"
sudo snap install notepad-plus-plus
echo ""
echo "** Installing FreeFileSync..."
echo ""
curl -L https://freefilesync.org/get_file.static.php?hash=e474d2e42d253131b69e3a213b203691 -o $tmp_dir/freefilesync.tgz
tar -xvzf $tmp_dir/freefilesync.tgz -C $tmp_dir
$tmp_dir/FreeFileSync_11.14_Install.run
# ^^^ Check if FreeFileSync can be completely silent
echo ""
echo "** Installing pCloud AppImage..."
echo ""
google-chrome --incognito https://p-lux4.pcloud.com/cBZML0tunZ9jjz8wZZZldipi7Z2ZZif5ZkZg7ypVZHZSRZtFZtpZ57ZXHZoHZPFZTVZLzZozZhHZ2zZ2HZhAHEXZL9J6wWKK1B7NQxwwAgdrj5biyDI7/pcloud
sudo mv $HOME/Scaricati/pcloud /usr/bin/pcloud
sudo chmod +x /usr/bin/pcloud
echo "pCloud client will open for installation, just close it when you see the login mask..."
/usr/bin/pcloud
# MEMO: if you need to delete pCloud, delete the AppImage file and $HOME/.local/share/applications/appimagekit-pcloud.desktop
echo ""
echo "Cleanup"
rm -rf $tmp_dir
echo ""
echo "DONE."
```
