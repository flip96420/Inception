# Load base image
FROM debian:bookworm

# Install MariaDB
RUN apt-get update && apt-get install -y    \
    mariadb-server                          \
    && rm -rf /var/lib/apt/lists/*

# Create folder and set permissions
RUN mkdir -p /var/run/mysqld                \
    && chown -R mysql:mysql /var/run/mysqld \
    && chmod 755 /var/run/mysqld

# Copy files
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/init_db.sh /usr/local/bin/

# Enable execute script
RUN chmod +x /usr/local/bin/init_db.sh

# Port forwarding
EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/init_db.sh" ]