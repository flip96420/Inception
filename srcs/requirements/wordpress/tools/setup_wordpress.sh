#!/bin/sh

set -e

# Replace PHP-FPM listen line dynamically
echo ${WORDPRESS_PORT}
echo ${MYSQL_TCP_PORT}
sed -i "s|^listen = .*|listen = 0.0.0.0:${WORDPRESS_PORT}|" /etc/php/8.2/fpm/pool.d/www.conf

# Go to WordPress directory
cd /var/www/html

# Wait for the database to be ready
until nc -z "$WORDPRESS_DB_HOST" "$MYSQL_TCP_PORT"; do
    sleep 4
done

# Configure WordPress if not already
if [ ! -f wp-config.php ]; then
    echo "WordPress not configured. Setting up..."

    # Download WordPress
	if [ ! -f "/var/www/html/wp-settings.php" ]; then
        wp core download --allow-root
    fi

    # Create wp-config.php
  wp config create \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="$WORDPRESS_DB_HOST:$MYSQL_TCP_PORT" \
        --allow-root

    # Install WordPress
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PW" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    # Optional: create extra user
    wp user create "$WORDPRESS_USER" "$WORDPRESS_EMAIL" \
        --user_pass="$WORDPRESS_USER_PW" \
        --role=author \
        --allow-root

    chmod -R 777 /var/www/html
else
    echo "WordPress already configured. Continuing..."
fi

# Start PHP-FPM in foreground
exec /usr/sbin/php-fpm8.2 -F -R