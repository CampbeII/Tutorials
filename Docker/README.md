# Getting Started With Docker
Looking for quick answers? Checkout the [cheatsheet](cheatsheet.md)

## My Problem
CentOS has recently undergone a shift, and will no longer be the cool OS I thought it was going to be. This is great\* because I just finished deploying my application on a new CentOS 8 instance, and spent a lot of time configuring apache, php-fpm, and all my other dependencies. 

> **Hint:**
> It's not great. Sarcasum is the only way I can deal with the pain.

So how do I ensure that this doesn't happen again? Or if it does happen again, how do I make the transition less painful? As of writting this, I have no idea. But, i'm hoping docker is the answer.
> **Future Me:**
> Docker is the answer

## What is Docker?
According to their [website](https://docs.docker.com/get-started/overview/) "Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly."

## Installing Docker
The [installation process](https://docs.docker.com/get-docker/) is simple. Follow the instructions and it should go smoothly. Once installed, you are prompted with a tutorial to help you get started. At this point you can choose to use the dashboard or work from the command line.

### How it Works
You start by pulling images from [docker hub](https://hub.docker.com/). This can be an Operating System, a programming language, or a program. Images are then used to create `containers` which take the `image` and run it, applying your specified configurations.

## Dockerfile
Configurations are applied to your images through a `Dockerfile` which may include copying your specific `httpd.conf` or running a specific command at build time.

## docker-compose
Docker compose is a YAML file that can automatically build your whole development environment using multiple images. Here you can specify volumes to persist data, networks so conatiners can communicate, and more. 

# 1. How to Set Up Docker
- [Building the local environment](setup.md)
