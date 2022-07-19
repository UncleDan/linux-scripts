#!/bin/bash
echo "***** CUSTOMIZING... *****"
echo ""
echo "** Set RTC time to avoid problems in dual boot..."
echo ""
sudo timedatectl set-local-rtc 1 --adjust-system-clock
echo "** BTRFS is the way, updating and tweaking ..."
echo ""
## From: https://mutschler.dev/linux/ubuntu-btrfs-20-04/
sudo apt update
sudo apt -y upgrade
sudo apt -y dist-upgrade
sudo apt -y autoremove
sudo apt -y autoclean
sudo systemctl enable fstrim.timer
echo ""
echo "*REBOOT* and run 'custom-ubuntustudio-jelly-part2.sh'"
