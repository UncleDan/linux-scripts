#!/bin/bash
echo "***** Tweaking the installer... *****"
echo ""
sudo sed -i 's|btrfs: defaults,noatime,space_cache,autodefrag|btrfs: defaults,noatime,autodefrag,ssd,compress=zstd:1|g' /etc/calamares/modules/fstab.conf
sudo sed -i 's|btrfs: discard,compress=lzo|btrfs: discard|g' /etc/calamares/modules/fstab.conf
echo ""
echo "Now you can safely run the installer."
