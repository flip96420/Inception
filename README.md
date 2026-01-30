***This project has been created as part of the 42 curriculum by pschmunk***

# Description
### Overview
This project is about understanding docker and how docker containers get built, communicate with each other using images and the docker compose.

### Goals
- Learn about docker containers and how to build them
- Learn the difference between images and containers
- Learn how to manage multiple containers using a docker compose
- Learn how to build and manage a docker network
- Learn how to ensure secure connection through ssl and docker network usage

# Instructions
### Prerequisites
```
Docker
Docker Compose
Make
GIT
```

### How to run this project
- Before you can start making the project, you have to provide a .env seperately, due to .env containing passwords etc, which would otherwise break safety regulations if beeing published.

- After doing that you can just call the `make` command in the root directory and docker compose will take care of the rest.

- You can use `make fclean` to clean up.

# Rersources

#### Docker container, images and docker-compose
- https://www.youtube.com/watch?v=DQdB7wFEygo

#### Docker commands / Project guide
- https://dev.to/alejiri/docker-nginx-wordpress-mariadb-tutorial-inception42-1eok

#### Nginx overview and basic understanding
- http://nginx.org/en/docs/beginners_guide.html
- https://www.youtube.com/watch?v=iInUBOVeBCc

#### Markdown Visualizer tool
- https://markdownlivepreview.com/

#### AI Usage
 - AI was used and limited for debugging in specific cases, mainly in figuring out connection problems, letting it scan for typos etc. but rarely for acquiring knowledge for the sake of research.


## Project description

### Design choices
Due to the architecture of the project itself, the design choices are very limited to ensure the docker composes functionality. Services need to be strictly seprated, each with their own directory and Dockerfile, otherwise the compose will not work. Similar to any other installation, the folder structure of the project must be kept intact and everything needs to be in its place.

### Virtual Machines vs Docker
Docker containers are much more lightweight, because the container doesn't require a full OS setup to work. It rather borrows your machines OS with a combination of image installation to ensure functionally. This makes Docker more portable and easier to run. Generally you could say that they behave similar, but have different apllications. VM's are often beeing used with the intent to use a specific operating system or even multiple operating systems in mind, where as containers are often just used to ensure that a piece of software works on different machines, which makes them very popular for cross plattform web applications.

### Secrets vs Environment Variables
They work similar, but secrets have an extra security layer by only beeing read during runtime. They are not beeing exposed anywhere inside a container, unlike env.

### Docker Network vs Host Network
Docker networks are isolated, to ensure you can run the containers securely just inside the network and dont expose them to the host network. This way, when running multiple services you can set a specific entrypoint for just one of them, while letting the others just communicate internally.

### Docker Volumes vs Bind Mounts
Docker volumes are directly managed by docker which is stored in /var/lib/docker/volumes/`. This means they provide a persistent portable storage. On other hand bind mounts directly connects a host directory to the container which is nor portable and it always requires a hardcorded path a path on the host machine, which has to be created manualy before running a dockerfile.
