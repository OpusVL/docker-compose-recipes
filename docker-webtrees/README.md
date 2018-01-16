# docker-webtrees

# Supported tags and respective `Dockerfile` links

- [`1.7.9`, `latest` (*webtrees/Dockerfile*)](https://github.com/OpusVL/docker-compose-recipes/blob/master/docker-webtrees/webtrees/Dockerfile)

# Quick reference

-	**Where to file issues**:  
	[https://github.com/OpusVL/docker-compose-recipes/issues](https://github.com/OpusVL/docker-compose-recipes/issues)

-	**Maintained by**:  
	[OpusVL](http://opusvl.com)

## What is Webtrees?

Webtrees is the web's leading on-line collaborative genealogy application. It is open source software, and costs $ zero - yes, that means totally FREE!

All you need to use it is a website with PHP and MySQL installed.

It works from standard GEDCOM files, and is therefore compatible with every  major desktop application; and it aims to be efficient and effective by using the right combination of third-party tools, design techniques and open standards.

> [wikipedia.org/wiki/Webtrees](https://en.wikipedia.org/wiki/Webtrees)

![logo](https://wiki.webtrees.net/en/w/skins/webtrees-135x135.png)

## How to use this image

### ... from the Docker CLI
`docker container run --name webtrees opusvl/webtrees:latest`

If you're running this image from the CLI alone (without the assistance of an orchestration tool like Docker Compose) there's some preparation you'll need to do in the form of provisioning an nginx container which you can share a volume between so that the static content can be served.

We strongly recommend you use the Compose method detailed below.

### ... via docker stack deploy or docker-compose
```
version: '3.4'
services:
  webtrees:
    image: opusvl/webtrees:latest
```

Running this image alongside an nginx container in this form is as easy as:
```
  nginx:
    depends_on:
    - webtrees
    image: nginx:latest
    ports:
    - published: 80
      target: 80
    restart: on-failure
    volumes:
    - webtrees:/var/www/html:ro

  webtrees:
    image: opusvl/webtrees:latest
    restart: on-failure
    volumes:
    - webtrees:/var/www/html:rw
```

Be sure to see the example [`docker-compose.yml` and `docker-compose.override.yml`](https://github.com/OpusVL/docker-compose-recipes/tree/master/docker-webtrees) files for our recommended best-practice deployment. 

## Caveats and other miscellaneous or useful information

- Alone, this image isn't much good. Please see the example `docker-compose.yml`, `docker-compose.override.yml` and `.env` example files within the repository to see how you should best run this alongside nginx and MariaDB.

- Due to limitations with PHP-FPM, you will be required to mount the static files from the `webtrees` container into your `nginx` container. You can find an example of how this can be done within the [docker-compose.override.yml](https://github.com/OpusVL/docker-compose-recipes/blob/master/docker-webtrees/docker-compose.override.yml) file.

- Note that if you use the supplied example `nginx` container, you'll want to change the default `server_name` directive from `localhost` to the name of the virtual host you want to run Webtrees under. The `webtrees.conf` nginx configuration file can be found [here](https://github.com/OpusVL/docker-compose-recipes/blob/master/docker-webtrees/nginx/webtrees.conf).

- The `docker-compose.override.yml` file makes reference to two additional bind mounts (i.e. `- ${PWD}/database:/var/lib/mysql`) in order to make that data persistent. For convenience we've set a sensible default of `${PWD}/`, meaning that those binds will be created in the same location as the `docker-compose.yml` file. We recommend that you provision a dedicated location on your server to store bind mounts however, such as `/srv/container-volumes/webtrees/database` and `/srv/container-volumes/webtrees/nginx`.
