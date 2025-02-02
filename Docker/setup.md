# Pull the Official Images
In order to replicate my current environment i'm going to pull the official images from docker hub.
```shell
docker pull amazonlinux;
docker pull mysql;
docker pull minio/minio;
docker pull php;
docker pull nginx;
```

## Build A Folder Structure
Create the directory structure that will contain our environemnt. This command will:
- `mkdir env;` - Make a directory called "env".
- `cd env` - Change the "env directory".

There are quicker ways to do this, but I want to keep it simple.

```shell
mkdir env; 
cd env;
```

Create folders for each image. These directories will contain the specific files.
```sh
mkdir nginx;
mkdir php;
mkdir mysql;

```
## Docker Compose
Docker compose is a simple yaml file that will automatically run our images, configure networking, and setup volumes. In the `env` directory open up `docker-compose.yml` with your favourite text editor.

```yaml
services:
    nginx: 
        image: nginx
        container_name: nginx
        volumes:
            - ./nginx/sites:/var/www/sites
            - ./nginx:/etc/nginx/nginx.conf
        ports:
            - 80:80
            - 443:443
        depends on:
            - php
    php:
        image: php:fpm
        container_name: php
        volumes:
            - ./nginx/sites:/var/www/sites
        ports:
            - 9000:9000
```

## Setup PHP
Working on it!

## Setup MySQL
Inside our `mysql` directory.

### Export
```sh
docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE --no-tablespaces > backup.sql
```

### Import:
```sh
cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root --no-tablespaces DATABASE
```
