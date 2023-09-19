#!/bin/bash

# make sure /run/mysqld exists
if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
fi

# set permissions
chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then

    # Start MariaDB service for background
    mysql_install_db 2> /dev/null 

    # Create SQL statements file
    cat << EOF > /tmp/mariaDb.sql
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$USER_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
ALTER USER 'root'@'%' IDENTIFIED BY '$ROOT_PASS';
FLUSH PRIVILEGES;
EOF

    # Run SQL commands
    mysqld --init-file /tmp/mariaDb.sql 2> /dev/null
    rm -rf /tmp/mariaDb.sql
fi

# Start MariaDB service for foreground
exec mysqld --user=root 2> /dev/null

