# Getting Started With Docker

## My Problem
CentOS has recently undergone a shift, and will no longer be the cool OS I thought it was going to be. This is great\* because I just finished deploying my application on a new CentOS 8 instance, and spent a lot of time configuring apache, php-fpm, and all my other dependencies. 

> **Hint:**
> It's not great. Sarcasum is the only way I can deal with the pain.

So how do I ensure that this doesn't happen again? Or if it does happen again, how do I make the transition less painful? As of writting this, I have no idea. But, i'm hoping docker is the answer.

## What is Docker
According to their [website](https://docs.docker.com/get-started/overview/) "Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly."

## Installing Docker
The installation process is simple. Follow the instructions and it should go smoothly. Once installed, you are prompted with a tutorial to help you get started. 

### Getting Help
You can get whatever you need from the man pages.

```shell
docker COMMAND --help
```

View all processes
```shell
docker ps -a
```

clean up & pruning:
```shell
docker contaier prune
```

### Building an Image
An image is a private file system that provides everything that our container needs. To build an image in the current directory:

```shell
docker build -t image .
```

### Containers
Run container:
```shell
docker run -d -p 80:80 image
```

- `-d` - detatched mode (runs in background)
- `-p`- map host port 80 to container port 80
- `image` - name of image to use

Stop container:
```shell
docker stop container_name
```

List all running containers:
```shell
docker container ls
```

Rename a container:
```shell
docker rename my_container new_container
```

