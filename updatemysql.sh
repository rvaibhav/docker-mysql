#!/bin/sh

mysql -uroot -p <<EOF
use mysql;
update user set password=PASSWORD("password") where User='root@localhost';
CREATE DATABASE ejabberd;
source ejabberd.sql;
CREATE USER 'root'@'%' IDENTIFIED BY 'password'
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
quit;
EOF
