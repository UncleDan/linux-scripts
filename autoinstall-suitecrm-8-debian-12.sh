#!bin/bash
echo "               __        _            __        ____"
echo "  ____ ___  __/ /_____  (_)___  _____/ /_____ _/ / /"
echo " / __ `/ / / / __/ __ \/ / __ \/ ___/ __/ __ `/ / / "
echo "/ /_/ / /_/ / /_/ /_/ / / / / (__  ) /_/ /_/ / / /  "
echo "\__,_/\__,_/\__/\____/_/_/ /_/____/\__/\__,_/_/_/   "
echo "                                                    "

TMP_DIR=$(mktemp -d -t $(date +%Y%m%d%H%M%S)-XXXXXXXXXXXXXX)

cd $TMP_DIR
apt update
apt upgrade -y
apt install -y rsync unzip wget apache2 php8.2 php8.2-cli php8.2-common php8.2-curl php8.2-gd php8.2-intl php8.2-json php8.2-mbstring php8.2-mysql php8.2-soap php8.2-xml php8.2-zip
# apt install -y php8.2-imap php8.2-ldap ## optional

Just a start!!!