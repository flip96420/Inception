# Load base image
FROM debian:bookworm

# Install nginx + openssl
RUN apt-get update && apt-get install -y	\
	nginx									\
	openssl									\
	&& rm -rf /var/lib/apt/lists/*

# Ensure nginx runs as www-data with correct UID
RUN usermod -u 33 www-data && groupmod -g 33 www-data

# Create folder
RUN mkdir -p /etc/nginx/ssl

# Copy files
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY tools/generate_ssl.sh /usr/local/bin/

# Enable execute on scripts
RUN chmod +x /usr/local/bin/*.sh

# Port forwarding
EXPOSE 443

ENTRYPOINT [ "/usr/local/bin/generate_ssl.sh" ]