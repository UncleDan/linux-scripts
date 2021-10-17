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
echo "** Install APT utilities and missing localizations (keepassx vlc openssh-server xrdp xorgxrdp git putty wine-stable zip unzip p7zip-full filezilla curl)..."
sudo apt install keepassx vlc openssh-server xrdp xorgxrdp git putty wine-stable zip unzip p7zip-full filezilla curl firefox-locale-it thunderbird-locale-it libreoffice-l10n-it hunspell hunspell-it hyphen-it libreoffice-help-it mythes-it -y
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
### ----- CUT BEGIN - Thunderbird already updated in 'Impish' -----
### echo ""
### echo "** Remove APT Thunderbird 68.x ..."
### echo ""
### sudo apt remove thunderbird -y
### sudo apt autoremove -y
### echo ""
### echo "** Install Snap Thunderbird 78.x ..."
### echo ""
### sudo snap install thunderbird
### echo ""
### ----- CUT END - Thunderbird already updated in 'Impish' -----
### CHECHED ABOVE ^^^
echo ""
echo "** Installing Visual Studio Code deb package..."
echo ""
curl -L https://az764295.vo.msecnd.net/stable/c13f1abb110fc756f9b3a6f16670df9cd9d4cf63/code_1.61.1-1634175470_amd64.deb -o $tmp_dir/code.deb
sudo apt install $tmp_dir/code.deb -y
### ----- CUT BEGIN - LibreOffice already updated in 'Impish' -----
### echo ""
### echo "** Remove APT Libreoffice 6.x ..."
### echo ""
### sudo apt-get remove --purge libreoffice*
### sudo apt autoremove -y
### echo ""
### echo "** Install Snap Libreoffice 7.x ..."
### echo ""
### sudo snap install libreoffice
### ----- CUT END - LibreOffice already updated in 'Impish' -----
echo "** Remove APT Gimp (if present)..."
echo ""
sudo apt purge gimp* -y
sudo apt autoremove -y
echo ""
echo "** Install Snap Gimp ..."
echo ""
sudo snap install gimp
echo ""
echo "** Install Snap Notepad++"
sudo snap install notepad-plus-plus
echo ""
echo "** Installing Angry IP Scanner deb package..."
echo ""
curl -L https://github.com/angryip/ipscan/releases/download/3.7.6/ipscan_3.7.6_amd64.deb -o $tmp_dir/ipscan.deb
sudo apt install $tmp_dir/ipscan.deb -y
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
sudo curl -L https://p-lux4.pcloud.com/cBZML0tunZ9jjz8wZZZ7prki7Z2ZZufHZkZg7ypVZHZSRZtFZtpZ57ZXHZoHZPFZTVZLzZozZhHZ2zZ2HZhAHEXZuaXtLMXg9LBevdAObLbmMF9E5Nby/pcloud -o /usr/bin/pcloud
sudo chmod +x /usr/bin/pcloud
echo "pCloud client will open for installation, just close it when you see the login mask..."
/usr/bin/pcloud
# MEMO: if you need to delete pCloud, delete the AppImage file and $HOME/.local/share/applications/appimagekit-pcloud.desktop
echo ""
echo "Cleanup"
echo ""
echo "DONE."
