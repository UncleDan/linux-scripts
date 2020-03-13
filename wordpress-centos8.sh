#!/bin/bash
# Source: https://linuxconfig.org/install-wordpress-on-redhat-8

# Install all prerequisites.
# 
# The following command will install all prerequisites and tools required to perform the WordPress installation:
dnf install httpd php-mysqlnd php-fpm php-json php-zip mariadb-server curl rsync tar zip unzip -y
# Open HTTP and optionally HTTPS port 80 and 443 on your firewall:
firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
# Start both the Apache webserver and the MariaDB services:
systemctl start mariadb
systemctl start httpd
# Enable MariaDB and httpd to start after system reboot:
systemctl enable mariadb
systemctl enable httpd
# Create a new database wordpress and give new user admin access to the wordpress database with password pass:
mysql -u root -e "CREATE DATABASE wordpress_db;
CREATE USER \`wordpress_user\`@\`localhost\` IDENTIFIED BY 'MySuperSecretPassword1!';
GRANT ALL ON wordpress_db.* TO \`wordpress_user\`@\`localhost\`;
FLUSH PRIVILEGES;
EXIT"
# (Optional) Secure your MariaDB installation and set root password:
# mysql_secure_installation
#
# Download and extract WordPress. Start by downloading the WordPress installation package and extracting its content:
curl https://wordpress.org/latest.tar.gz --output wordpress.tar.gz
tar xf wordpress.tar.gz
# Copy the extracted WordPress directory into the /var/www/html directory:
rsync -azP -delete wordpress/ /var/www/html/
# Lastly in this step, change permissions and change file SELinux security context:
chown -R apache:apache /var/www/html/wordpress
chcon -t httpd_sys_rw_content_t /var/www/html/wordpress -R
# Access WordPress installation wizard and perform the actual WordPress installation. Navigate your browser to http://localhost/wordpress or http://SERVER-HOST-NAME/wordpress and follow the instructions.
# Enter previously configured database details.
# Enter previously configured database details as per Step 5.
#  
# Start WordPress installation by clicking on the Run the installation button.
# Provide the requested information by the WordPress wizard.
# This screen will show once the WordPress installation was successful.
