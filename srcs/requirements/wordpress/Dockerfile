# Load base image
FROM debian:bookworm

# Install PHP-FPM + extensions
RUN apt-get update && apt-get install -y	\
	php8.2-fpm								\
	php8.2-mysql							\
	php8.2-curl								\
	php8.2-gd								\
	php8.2-intl								\
	php8.2-mbstring							\
	php8.2-soap								\
	php8.2-xml								\
	php8.2-zip								\
	wget									\
	curl									\
	&& ln -s /usr/sbin/php-fpm8.2 /usr/local/bin/php-fpm \
	&& rm -rf /var/lib/apt/lists/*

# Create root
WORKDIR /var/www/html

# Copy files
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/
COPY tools/setup_wordpress.sh /usr/local/bin/

# Enable execute for script
RUN chmod +x /usr/local/bin/setup_wordpress.sh

# Port forwarding
EXPOSE 9000

ENTRYPOINT [ "/usr/local/bin/setup_wordpress.sh" ]