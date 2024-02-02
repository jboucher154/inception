#!/bin/bash

# make sure environment vars are set
if [ -z "$DB_ROOT_PASSWORD" ]; then
  echo "Error: DB_ROOT_PASSWORD environment variable is not set."
  exit 1
fi

if [ -z "$DB_USER" ] || [ -z "$DB_ROOT_PASSWORD" ]; then
  echo "Error: DB_USER and/ or DB_USER_PASSWORD environment variable is not set."
  exit 1
fi

# might want to change ownership of database files in /run/mysqld /var/lib/mysqld
mkdir -p /var/log/mysqld
chown -R mysql:mysql /var/log/mysqld
chown -R mysql:mysql /run/mysqld

#start maraidb in background
echo "Starting database in background"
mysqld &
#give time for it to load
sleep 5
#give commands to database using root user, no password to begin with
echo "Checking status of 'my_inception_db'"
if mysql -u root -p"$DB_ROOT_PASSWORD" -e "USE my_inception_db;" 2>/dev/null; then
  echo "Database 'my_inception_db' already intialized."
else
	echo "Intializing database and users"
	mysql -u root -p << EOF
	CREATE DATABASE IF NOT EXISTS my_inception_db;
	USE my_inception_db;

	ALTER USER 'root' IDENTIFIED BY '$DB_ROOT_PASSWORD' HOST 'localhost';
	GRANT ALL PRIVILEGES ON my_inception_db.* TO 'root'@'%';
	CREATE USER '$DB_USER' IDENTIFIED BY '$DB_USER_PASSWORD';
	GRANT ALL PRIVILEGES ON my_inception_db.* TO '$DB_USER'@'%';

	FLUSH PRIVILEGES;
EOF
fi

# shutdown the database
echo "Shutting down database"
mysqladmin -u root -p"$DB_ROOT_PASSWORD" shutdown

#runs server in safemode, automatic restart if issues encountered
# echo "Starting database in safe mode"
# mysqld_safe --defaults-file=/etc/my.cnf

## root user not log in???
# while [ true ] 
# do
# 	sleep 1
# done
