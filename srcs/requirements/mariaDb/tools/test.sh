#!/bin/sh

mkdir -p /run/mysqld

# set permissions
chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then

    mysql_install_db #> /dev/null 2>&1
    cat > /tmp/init_database.sql << EOF 
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM    mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASS';
CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED by '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
FLUSH PRIVILEGES;
EOF
    echo "create user for wordpress..."
    mysqld  --init-file /tmp/init_database.sql 2> /dev/null
    rm -rf /tmp/init_database.sql
fi

echo "starting mariadb server..."
exec mysqld --user=root 