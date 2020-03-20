#!/bin/bash
# Based on: https://linuxconfig.org/install-wordpress-on-redhat-8

# PARAMETERS (memo)
# mysql_wordpress_database
# mysql_wordpress_user
# mysql_wordpress_password
# mysql_root_password
# mywordpress.test
# /var/www/mywordpress.test
# 111111111111111111111111111111SaLt111111111111111111111111111111
# 222222222222222222222222222222SaLt222222222222222222222222222222
# 333333333333333333333333333333SaLt333333333333333333333333333333
# 444444444444444444444444444444SaLt444444444444444444444444444444
# 555555555555555555555555555555SaLt555555555555555555555555555555
# 666666666666666666666666666666SaLt666666666666666666666666666666
# 777777777777777777777777777777SaLt777777777777777777777777777777
# 888888888888888888888888888888SaLt888888888888888888888888888888
# wpprefix_

echo "###############################################################################"
echo "# WordPress Auto Installation Script for CentOS 8 by Daniele Lolli (UncleDan) #"
echo "###############################################################################"
echo -e "\n\n*** START Installing all prerequisites..."
dnf install httpd mariadb-server php-bcmath php-curl php-fpm php-gd php-intl php-json php-mbstring php-mysqlnd php-soap php-xml php-xmlrpc php-zip unzip  -y
# dnf install git rsync tar wget zip -y
echo "*** DONE Installing all prerequisites."
echo -e "\n\n*** START Opening HTTP and optionally HTTPS port 80 and 443 on your firewall..."
firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
echo "*** DONE Opening HTTP and optionally HTTPS port 80 and 443 on your firewall."
echo -e "\n\n*** START Starting Apache webserver and the MariaDB services..."
systemctl start mariadb
systemctl start httpd
echo "*** DONE starting Apache webserver and the MariaDB services."
echo -e "\n\n*** START Configuring both the Apache webserver and the MariaDB services to start after reboot..."
systemctl enable mariadb
systemctl enable httpd
echo "*** DONE Configuring both the Apache webserver and the MariaDB services to start after reboot."
echo -e "\n\n*** START Creating a new database for WordPress and a new user with password with all privileges on it..."
mysql -u root -e "CREATE DATABASE mysql_wordpress_database;
CREATE USER \`mysql_wordpress_user\`@\`localhost\` IDENTIFIED BY 'mysql_wordpress_password';
GRANT ALL ON mysql_wordpress_database.* TO \`mysql_wordpress_user\`@\`localhost\`;
FLUSH PRIVILEGES;
EXIT"
echo "*** DONE Creating a new database for WordPress and a new user with password with all privileges on it."
echo -e "\n\n*** START Securing your MariaDB installation and set root password..."
# Hint from: https://stackoverflow.com/questions/24270733/automate-mysql-secure-installation-with-echo-command-via-a-shell-script
mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('mysql_root_password') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE db='test' OR db='test\\_%';
FLUSH PRIVILEGES;
EXIT"
echo "*** DONE Securing your MariaDB installation and set root password."
echo -e "\n\n*** START Stopping Apache and PHP services, or it will fail because the site folder does not exist yet..."
systemctl stop httpd
systemctl stop php-fpm
echo "*** DONE Stopping Apache and PHP services, or it will fail because the site folder does not exist yet."
echo -e "\n\n*** START Adjusting new httpd.conf with custom folder and and rewrite enabled..."
sed -i "122 s|/var/www/html|/var/www/mywordpress.test|g ;
        134 s|/var/www/html|/var/www/mywordpress.test|g ;
        154 s|AllowOverride None|AllowOverride All|g" /etc/httpd/conf/httpd.conf
echo "*** DONE Adjusting new httpd.conf with custom folder and and rewrite enabled."
echo -e "\n\n*** START Downloading and extracting WordPress..."
curl https://it.wordpress.org/latest-it_IT.zip --output __TEMP__.zip && unzip -o __TEMP__.zip && rm -f __TEMP__.zip
echo "*** DONE Downloading and extracting WordPress..."
echo -e "\n\n*** START Creating files and folders to avoid permission issues..."
touch wordpress/.htaccess
mkdir -p wordpress/wp-content/uploads
mkdir -p wordpress/wp-content/upgrade
echo "*** DONE Creating files and folders to avoid permission issues."
echo -e "\n\n*** START Creating WordPress config file..."
cp wordpress/wp-config-sample.php wordpress/wp-config.php
sed -i "s|^define('DB_NAME',.*|define('DB_NAME', 'mysql_wordpress_database');|g ; 
        s|^define('DB_USER',.*|define('DB_USER', 'mysql_wordpress_user');|g ; 
        s|^define('DB_PASSWORD',.*|define('DB_PASSWORD', 'mysql_wordpress_password');|g ; 
        s|^define('AUTH_KEY',.*|define('AUTH_KEY',         '111111111111111111111111111111SaLt111111111111111111111111111111');|g ; 
        s|^define('SECURE_AUTH_KEY',.*|define('SECURE_AUTH_KEY',  '222222222222222222222222222222SaLt222222222222222222222222222222');|g ; 
        s|^define('LOGGED_IN_KEY',.*|define('LOGGED_IN_KEY',    '333333333333333333333333333333SaLt333333333333333333333333333333');|g ; 
        s|^define('NONCE_KEY',.*);|define('NONCE_KEY',        '444444444444444444444444444444SaLt444444444444444444444444444444');|g ; 
        s|^define('AUTH_SALT',.*|define('AUTH_SALT',        '555555555555555555555555555555SaLt555555555555555555555555555555');|g ; 
        s|^define('SECURE_AUTH_SALT',.*;|define('SECURE_AUTH_SALT', '666666666666666666666666666666SaLt666666666666666666666666666666');|g ; 
        s|^define('LOGGED_IN_SALT',.*|define('LOGGED_IN_SALT',   '777777777777777777777777777777SaLt777777777777777777777777777777');|g ; 
        s|^define('NONCE_SALT',.*|define('NONCE_SALT',       '888888888888888888888888888888SaLt888888888888888888888888888888');|g ;
		s|^\$table_prefix =.*|\$table_prefix = 'wpprefix_';|g" wordpress/wp-config.php
echo "*** DONE Creating WordPress config file."
echo -e "\n\n*** START Removing useless themes and plugins and installing useful ones..."
rm -f wordpress/wp-content/plugins/hello.php
rm -rf wordpress/wp-content/plugins/akismet/
curl https://downloads.wordpress.org/plugin/askimet.latest-stable.zip --output __TEMP__.zip && unzip -o __TEMP__.zip && rm -f __TEMP__.zip
mv -f askimet/ wordpress/wp-content/plugins/
curl https://downloads.wordpress.org/plugin/elementor.latest-stable.zip --output __TEMP__.zip && unzip -o __TEMP__.zip && rm -f __TEMP__.zip
mv -f elementor/ wordpress/wp-content/plugins/
rm -rf wordpress/wp-content/themes/twentyseventeen/
rm -rf wordpress/wp-content/themes/twentynineteen/
curl https://downloads.wordpress.org/theme/hello-elementor.latest-stable.zip --output __TEMP__.zip && unzip -o __TEMP__.zip && rm -f __TEMP__.zip
mv -f hello-elementor/ wordpress/wp-content/themes/
echo "*** DONE Removing useless themes and plugins and installing useful ones."
echo -e "\n\n*** START Moving the extracted WordPress directory into the /var/www/ folder..."
mv wordpress /var/www/mywordpress.test
echo "*** DONE Moving the extracted WordPress directory into the /var/www/ folder."
echo -e "\n\n*** START Adjusting permissions and change file SELinux security context..."
chown -R apache:apache /var/www/mywordpress.test/
chcon -t httpd_sys_rw_content_t /var/www/mywordpress.test/ -R
find /var/www/mywordpress.test/ -type d -exec chmod 750 {} \;
find /var/www/mywordpress.test/ -type f -exec chmod 640 {} \;
echo "*** DONE Adjusting permissions and change file SELinux security context."
echo -e "\n\n*** START Setting SElinux to allow outgoing connections (or plugins and themes won't install!)..."
setsebool -P httpd_can_network_connect on
echo "*** DONE Setting SElinux to allow outgoing connections (or plugins and themes won't install!)."
echo -e "\n\n*** START Adjusting PHP parameters for file uploads, memory usage and time limits for WordPress..."
echo "; Adjust PHP parameters for file uploads, memory usage and time limits for WordPress
upload_max_filesize = 256M
post_max_size = 256M
memory_limit = 512M
max_execution_time = 180" > /etc/php.d/99-wordpress.ini 
echo "*** DONE Adjusting PHP parameters for file uploads, memory usage and time limits for WordPress."
echo -e "\n\n*** START Restarting PHP and Apache services..."
systemctl restart php-fpm
systemctl restart httpd
echo -e "\n\n*** DONE Restarting Apache service."
echo -e "\n\n*** START Erasing dependencies now unnecessary..."
dnf erase unzip  -y
echo -e "\n\n*** DONE Erasing dependencies now unnecessary."
echo -e "\n\n*** FINISH: you can now access WordPress installation wizard and perform the"
echo "    actual WordPress installation. Navigate your browser to"
echo "    http://SERVER-IP-ADDRESS/ or http://SERVER-HOST-NAME/"
echo -e "    and follow the instructions.\n\n"
