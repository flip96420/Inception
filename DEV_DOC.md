# Inception – Developer Documentation

## Overview

The project deploys a WordPress website using Docker Compose with 3 services:
- **Nginx**
- **WordPress (PHP-FPM)**
- **MariaDB**

All services run in isolated Docker containers and communicate via a private Docker network and using nginx as the main process/entrypoint to ensure SSL Encryption is beeing used.


## 1. Environment Setup from Scratch

### 1.1 Prerequisites

To install:
- Docker
- Docker Compose (v2)
- Make
- Git
- Text editor of your chose

The project is linux-based and `Ubuntu 24.04.3 LTS` image was used as a reference.


### 1.2 .env Setup

Env directory: `srcs/.env`

Example file: `root/env.example`

The .env file must define the following variables:
- DOMAIN_NAME
- MYSQL_ROOT_PASSWORD
- MYSQL_DATABASE
- MYSQL_USER
- MYSQL_PASSWORD
- MYSQL_TCP_PORT

- WORDPRESS_DB_NAME
- WORDPRESS_DB_USER
- WORDPRESS_DB_PASSWORD
- WORDPRESS_DB_HOST
- WORDPRESS_TABLE_PREFIX
- WORDPRESS_PORT
- WORDPRESS_TITLE
- WORDPRESS_ADMIN_USER
- WORDPRESS_ADMIN_PW
- WORDPRESS_ADMIN_EMAIL
- WORDPRESS_USER
- WORDPRESS_USER_PW
- WORDPRESS_EMAIL

### 1.3 Hostname Configuration
To access the project locally, add the following entry to `/etc/hosts`:

Example: `127.0.0.1 pschmunk.42.fr`


## 2. Building and Launching the Project

### Using Makefile

- **Build and start containers**
`make all`

- **Build containers**
`make build`

- **Start containers**
`make up`

- **Stop running containers**
`make down`

- **Stop and remove containers**
`make clean`

- **Stop and remove containers + volumes**
`make fclean`

- **call fclean and then all in one command**
`make re`


### Using Docker Compose Directly

- **Build images and start all services** `docker compose up --build -d`

- **Stop and remove all services** `docker compose down`

- **Rebuild a specific service** `docker compose build <service_name>`

- **Full clearing everything** `docker compose -p inception down -v`

## 3. Managing Containers and Volumes

### Container managment
**List all running containers** `docker ps`

**List all containers** `docker ps -a`

**Inspect a container log** `docker logs <container_name>`

**Stop a specific container:** `docker stop <container_name>`

**Remove a stopped container:** `docker rm <container_name>`

**Bash into a container:** `docker exec -it <container_name> bash`

**Drop the nuke** `docker system prune -a --volumes -f`

### Volumes management

**List all volumes:**
`docker volume ls`

**Inspect a specific volume**
`docker volume inspect <volume_name>`

**Remove unused volumes:**
`docker volume prune`

### Network management

**List all networks** `docker network ls`

**Inspect a network** `docker network inspect <network_name>`

### Accessing the MariaDB Database

**Open a shell in the MariaDB container and log in as root:** `docker exec mariadb mysql -u root -p`

**List all databases** `SHOW DATABASES;`

**Select the Wordpress database** `USE wordpress_db;`

**List all tables in the database** `SHOW TABLES;`

**Show the content of a table in the database** `SELECT * FROM table_name;`

### other noteworthy commands
**Check if a page is accesible via port 80**
`curl -v http://tbui-quo.42.fr:80`

## 4. Project Data Storage and Persistence
Docker volumes ensure data persistence across container restarts, specifically for:

- MariaDB database data

- WordPress files and uploads

It has required from the subject we also mount them on the host machine under path `/home/$USER/data`
These are only get cleaned with the `make fclean` command.
