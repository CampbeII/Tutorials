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

### Building an Image
An image is a private file system that provides everything that our container needs. To build an image in the current directory:

```shell
docker build -t image .
```

### Run a Container
We'll need to start a container based on the image we built. 
- `-d` - detatched mode (runs in background)
- `-p 80:80`- map host port 80 to container port 80
- `image` - name of image to use

```shell
docker run -d -p 80:80 image
```

### First look at the Dashboard
The dashboard is stunningly simple. I can see that I have a container running along with the original repo. I'm going to delete all of these and attempt to replicate my environment.
![docker dashboard](images/docker-dashboard.jpg)

### Integrating with ECS
My current application runs on an EC2 image. I was very happy to read how simple it is to integrate docker with aws.

>AWS and Docker have collaborated to make a simplified developer experience that enables you to deploy and manage containers on Amazon ECS directly using Docker tools. You can now build and test your containers locally using Docker Desktop and Docker Compose, and then deploy them to Amazon ECS on Fargate.

This is exactly what I need.

My first step is to install the amazonlinux image. 

```shell
docker pull amazonlinux
```

You can view your new image by clicking the "Images" tab. 
![docker image](images/new-image.jpg)

Run a new container by 
```shell
docker run -d -p

