# Cheatsheet

## General
- `docker COMMAND --help` - Get help about a command
- `docker ps -a` - List all processes

## Images 
An operating system or program.

- `docker pull IMAGE` - pull an image from docker hub
- `docker image ls` || `docker images` - list images
- `docker image rm IMAGE` - Remove image

## Containers
- `docker logs [OPTIONS] CONTAINER` - View logs for a container
- `docker container ls ` - List running containers
- `docker rename my_container new_container` - Change the name of container
- `docker container prune` - Remove all stopped containers

## Networking
Creating a network will allow containers to talk to each other.

- `docker netework create NETWORK-NAME` - Create a network with label
- `docker netework rm NETWORK-NAME` - Remove network
- `docker netework ls` - List networks

## Volumes
- `docker volume create NAME` - create a volume
- `docker volume ls` - List volumes
- `docker volume rm NAME` - Remove volumes

## Interaction
How to interact with containers
- `docker exec -it ID /bin/bash` - Get a bash shell in container use `sh` if bash isn't available.'
- `docker cp IMAGE:/location/on/image .` - Copy file from container


## Dockerfile
- `FROM NAME` - The name of the image you will be using
- `COPY FILE REMOTE_LOC` - Copy a file from current dir to remote dir

## Docker Compose
- `docker-compose -d up` - bring up your env
- `docker-compose down --volumes` - clean up, with optionally removing volumes
