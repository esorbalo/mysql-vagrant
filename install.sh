#!/usr/bin/env bash

#sudo yum -y update

# if we need any dependencies, install them here

# Add community mysql to repository list

sudo yum -y install wget

# https://opensourcedbms.com/dbms/how-to-install-mysql-5-5-on-cent-os-6-3-linux-redhat-el-6/
wget -O MySQL-server-5.5.30-1.el6.x86_64.rpm http://www.mysql.com/get/Downloads/MySQL-5.5/MySQL-server-5.5.30-1.el6.x86_64.rpm/from/http://cdn.mysql.com/
wget -O MySQL-client-5.5.30-1.el6.x86_64.rpm http://www.mysql.com/get/Downloads/MySQL-5.5/MySQL-client-5.5.30-1.el6.x86_64.rpm/from/http://cdn.mysql.com/
wget -O MySQL-shared-5.5.30-1.el6.x86_64.rpm http://www.mysql.com/get/Downloads/MySQL-5.5/MySQL-shared-5.5.30-1.el6.x86_64.rpm/from/http://cdn.mysql.com/

sudo yum -y install perl

sudo rpm -ivh MySQL-shared-5.5.30-1.el6.x86_64.rpm
sudo rpm -ivh MySQL-client-5.5.30-1.el6.x86_64.rpm
sudo rpm -ivh --force MySQL-server-5.5.30-1.el6.x86_64.rpm

# restart mysql
# sudo service mysqld restart
sudo service mysql start

### secure the mysql installation

# set root password
sudo /usr/bin/mysqladmin -u root password 'password'

# allow remote access
mysql -u root -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;"

# drop the anonymous users
mysql -u root -ppassword -e "DROP USER ''@'localhost';"
mysql -u root -ppassword -e "DROP USER ''@'$(hostname)';"

# drop the demo database
mysql -u root -ppassword -e "DROP DATABASE test;"

# flush
mysql -u root -ppassword -e "FLUSH PRIVILEGES;"

# restart
# sudo service mysqld restart

# set to autostart
# sudo chkconfig mysqld on
