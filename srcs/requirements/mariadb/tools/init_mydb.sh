#!/bin/bash

export DB_ROOT_PASSWORD=test
export DB_USER=test_user
export DB_USER_PASSWORD=test1

# make sure environment vars are set
if [ -z "$DB_ROOT_PASSWORD" ]; then
  echo "Error: DB_ROOT_PASSWORD environment variable is not set."
  exit 1
fi

if [ -z "$DB_USER" ] || [ -z "$DB_ROOT_PASSWORD" ]; then
  echo "Error: DB_USER and/ or DB_USER_PASSWORD environment variable is not set."
  exit 1
fi

# to change ownership of database files in /run/mysqld /var/lib/mysqld
mkdir -p /var/lib/mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld

#give commands to database using root user, no password to begin with
echo "Intializing database"
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql --rpm >/dev/null

echo "Intializing database and users"
mysqld --user=mysql --bootstrap << EOF
USE mysql;
FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS my_inception_db CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON my_inception_db.* TO '${DB_USER}'@'%';

FLUSH PRIVILEGES;
EOF


# GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%';
# GRANT SELECT ON mysql.* TO '${DB_USER}'@'%';
