set -e

echo "Starting MariaDB init..."

# Init data dir if it doesnt exist already
if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Initializing data directory..."
	mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

# Start server without networking
echo "Starting temporary MariaDB server for setup..."
mysqld --skip-networking --socket=/run/mysqld/mysqld.sock --user=mysql &
pid="$!"

# Wait for MariaDB
echo "Waiting for MariaDB..."
until mysqladmin --socket=/run/mysqld/mysqld.sock ping >/dev/null 2>&1; do
	sleep 1
done
echo "MariaDB is ready!"

# Create DB and users
echo "Running setup SQL..."
mysql --socket=/run/mysqld/mysqld.sock -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Quit server
echo "Shutting down temporary MariaDB..."
mysqladmin --socket=/run/mysqld/mysqld.sock -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Wait for shutdown
wait "$pid" || true

# Start Server again with networking
echo "Initialization complete. Starting MariaDB..."
exec mysqld --user=mysql --datadir=/var/lib/mysql --socket=/run/mysqld/mysqld.sock