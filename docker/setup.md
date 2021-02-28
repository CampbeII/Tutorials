# My Environment
In order to replicate my current environment i'm going to pull some images from docker hub.'

```shell
docker pull amazonlinux;
docker pull mysql;
docker pull minio/minio;
docker pull php
docker pull rust
docker pull nginx
```
Verify the images are all there with:

```shell
docker images
```
## Container Networking
Reference: [Documentation](https://docs.docker.com/get-started/07_multi_container/)

1. Create the network

```shell
docker network create network-name
```
2. Start a MySQL container and attach it to the network. On make sure to use back ticks on windows.

```shell
docker run -d \
    --network cm-network --network-alias mysql \
    --name mysql \ 
    -v mysql-data:/var/lib/mysql \
    -e connection
```
- `--network` - specifies the network we built
- `--network-alias` - label our network
- `--name` - label container
- `-v`  - bind & mount a volume
- `--env-file` - set an environment variable file named connection

## Connect to the image
List all the current docker processes to determine the ID of mysql
```shell
docker container ls

CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                 NAMES
86dfaefef6f5   mysql     "docker-entrypoint.s"   21 minutes ago   Up 21 minutes   3306/tcp, 33060/tcp   mysql
```

Launch an interactive shell:
```shell
docker exec -it ID mysql -p
```

## Persisting data using Volumes
Reference: [Documentation](https://docs.docker.com/storage/volumes/)

Create volume
```shell
docker volume create linux-data
docker volume ls
docker volume rm linux-data
```
- Helps data persist
- When you run a container and specifiy a volume that does not exist, it will be created.



