#!/bin/bash
echo "** Uninstalling old versions packages..."
echo ""
echo "* apt purge wine*"
sudo apt purge -y wine*
sudo apt autoremove -y
echo ""
echo ""
echo "*** INSTALLING..."
echo ""
sudo dpkg --add-architecture i386 
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
rm -rf winehq.key
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
sudo apt update
sudo apt install -y --install-recommends winehq-stable
echo ""
echo ""
echo "DONE."
