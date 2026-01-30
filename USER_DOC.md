# Inception - User Documentation

This Inception project sets up a web server environment with a database, running a preconfigured WordPress website
## Provided Services:
- **Nginx**
- **Wordpress**
- **Maria DB**

Each service is running independently on it's own a a container and communicates through docker network.

The whole docker compose process can be controlled via the provided Makefile.

## Starting / Installing
Before using the Makefile, you must provide a `.env` file.  
Details about this setup are explained in the **Credentials Management** section.
To build this project you have to go to the root of the cloned repository and use the `make` command.
This command runs Docker Compose in the background, which creates and starts the three Docker containers with their predefined services.

Next, add the following line to your `/etc/hosts`
`127.0.0.1 pschmunk.42.fr`. 
This is needed when you type url into your browser `pschmunk.42.fr` so your system can resolves the domain locally instead of asking a DNS server.

## Stopping
To stop all current running containers use the make command `make stop`, which calls `docker compose stop`. 

## Uninstalling
To clean everything up related to docker containers and images use `make fclean`. This command also deletes the directory `/home/username/data`, which is required by the project subject.
Afterwards remove the following line from your `/etc/hosts` 
and remove the line you added `127.0.0.1 pschmunk.42.fr`.

## Credentials Managment
You should put your .env file into root/srcs. You can also find examples in the env.example file which is located in the root directory. The .env file should define following variables:
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

## Accessing the Website and the administration panel
### Website access
Once the project is running, you can accessed the wordpress site via:
- https://pschmunk.42.fr

### WordPress Administration Panel
You can access the WordPress admin dashboard via following url:
- https://pschmunk.42.fr/wp-login.php
- Log in using the Wordpress user credentials you defined in your env.

### Checking Service Status
To check the status of the docker container you can use the make command `make status`
which run following command
- `docker ps` shows all containers as Up (healthy).
- `docker network ls` shows your `inception_network`.
- `docker volume ls ` show your docker volumes.