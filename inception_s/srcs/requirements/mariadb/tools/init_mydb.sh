#!/bin/sh

# make sure environment vars are set
if [ -z "$MARIADB_ROOT_PASSWORD" ]; then
  echo "Error: MARIADB_ROOT_PASSWORD environment variable is not set."
  exit 1
fi

if [ -z "$MARIADB_USER" ] || [ -z "$MARIADB_USER_PASSWORD" ]; then
  echo "Error: MARIADB_USER and/ or MARIADB_USER_PASSWORD environment variable is not set."
  exit 1
fi

#give commands to database using root user, no password to begin with
# echo "MARIA DB CURRENT DIRECTORY"
# ls -la

if [ -f "/var/lib/mysql/.install_complete" ]; then
  echo "Database already intialized."
else
  touch /var/lib/mysql/.install_complete
  echo "Intializing database and users"
  mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql --rpm > /dev/null
  mysqld --user=mysql --bootstrap << EOF
  USE mysql;
  FLUSH PRIVILEGES;

  ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';
  CREATE DATABASE IF NOT EXISTS my_inception_db CHARACTER SET utf8 COLLATE utf8_general_ci;
  CREATE USER '${MARIADB_USER}'@'%' IDENTIFIED by '${MARIADB_USER_PASSWORD}';
  GRANT ALL PRIVILEGES ON my_inception_db.* TO '${MARIADB_USER}'@'%';

  FLUSH PRIVILEGES;
EOF
fi
echo "Running database with mysqld_safe script"
# while [ true ]; do
#   sleep 1
# done

exec mysqld_safe --defaults-file=/etc/my.cnf

# GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_USER}'@'%';
# GRANT SELECT ON mysql.* TO '${MARIADB_USER}'@'%';
