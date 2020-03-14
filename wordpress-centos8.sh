#!/bin/bash
# Source: https://linuxconfig.org/install-wordpress-on-redhat-8

# PARAMETERS (memo)
# mysql_wordpress_database
# mysql_wordpress_user
# mysql_wordpress_password
# mysql_root_password
# mywordpress.test

# Install all prerequisites.
# 
# The following command will install all prerequisites and tools required to perform the WordPress installation:
dnf install httpd php-mysqlnd php-fpm php-json php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip mariadb-server curl git rsync tar zip unzip -y
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
mysql -u root -e "CREATE DATABASE mysql_wordpress_database;
CREATE USER \`mysql_mysql_wordpress_user\`@\`localhost\` IDENTIFIED BY 'mysql_wordpress_password';
GRANT ALL ON mysql_wordpress_database.* TO \`mysql_mysql_wordpress_user\`@\`localhost\`;
FLUSH PRIVILEGES;
EXIT"
# Secure your MariaDB installation and set root password
# Hint from: https://stackoverflow.com/questions/24270733/automate-mysql-secure-installation-with-echo-command-via-a-shell-script
mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('mysql_root_password') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE db='test' OR db='test\\_%';
FLUSH PRIVILEGES;
EXIT"
# *** WORK SUSPENDEND HERE FOR: VIRTUALHOST NOT WORKING ***
# Create VirtualHost to handle the site
cat > /etc/httpd/conf.d/zz-mywordpress.test.conf <<EOF
<VirtualHost *:80>
    ServerAdmin admin@mywordpress.test

    # If your host doesn't have a registered DNS name, enter its IP address here.
    #ServerName www.mywordpress.test:80
    #ServerAlias mywordpress.test:80

    DocumentRoot "/var/www/mywordpress.test"

    <Directory "/var/www/mywordpress.test">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    <IfModule dir_module>
        DirectoryIndex disabled
    </IfModule>

    <Files ".ht*">
        Require all denied
    </Files>

    ErrorLog "logs/mywordpress.test_error_log"
    LogLevel warn
</VirtualHost>
EOF
#
# Restart Apache:
systemctl restart httpd.service
# Download and extract WordPress. Start by downloading the WordPress installation package and extracting its content:
curl https://wordpress.org/latest.tar.gz --output wordpress.tar.gz
tar xf wordpress.tar.gz
# Create files and folders to avoid permission issues

# Move the extracted WordPress directory into the /var/www/mywordpress.test directory:
mv wordpress /var/www/mywordpress.test
# Lastly in this step, change permissions and change file SELinux security context:
chown -R apache:apache /var/www/mywordpress.test
chcon -t httpd_sys_rw_content_t /var/www/mywordpress.test -R
# Access WordPress installation wizard and perform the actual WordPress installation. Navigate your browser to http://localhost/wordpress or http://SERVER-HOST-NAME/wordpress and follow the instructions.
# Enter previously configured database details.
# Enter previously configured database details as per Step 5.
#  
# Start WordPress installation by clicking on the Run the installation button.
# Provide the requested information by the WordPress wizard.
# This screen will show once the WordPress installation was successful.
