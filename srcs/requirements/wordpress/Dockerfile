# Load base image
FROM debian:bookworm

# Install PHP-FPM + extensions
RUN apt-get update && \
    apt-get install -y php-fpm php-mysql wget unzip netcat-openbsd curl && \
    rm -rf /var/lib/apt/lists/*

# Create root
WORKDIR /var/www/html

# Install command line access
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy files
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/
COPY tools/setup_wordpress.sh /usr/local/bin/

# Enable execute for script and add permissions
RUN chmod +x /usr/local/bin/setup_wordpress.sh
RUN chown -R www-data:www-data /var/www/html

# Port forwarding
EXPOSE 9000

ENTRYPOINT [ "/usr/local/bin/setup_wordpress.sh" ]