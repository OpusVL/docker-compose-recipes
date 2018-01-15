# docker-webtrees

## What is Webtrees?

Webtrees is the web's leading on-line collaborative genealogy application. It is open source software, and costs $ zero - yes, that means totally FREE!

All you need to use it is a website with PHP and MySQL installed.

It works from standard GEDCOM files, and is therefore compatible with every  major desktop application; and it aims to be efficient and effective by using the right combination of third-party tools, design techniques and open standards.

## How to use this image

### ...from the Docker CLI
`docker container run --name webtrees opusvl/webtrees:latest`

### ... via docker stack deploy or docker-compose
```
version: '3.4'
services:
  webtrees:
    image: opusvl/webtrees:latest
```
## Caveats and other miscellaneous or useful information

- Alone, this image isn't much good. Please see the example `docker-compose.yml`, `docker-compose.override.yml` and `.env` example files within the repository to see how you should best run this alongside nginx and MariaDB.

- Due to limitations with PHP-FPM, you will be required to mount the static files from the `webtrees` container into your `nginx` container. You can find an example of how this can be done within the [docker-compose.override.yml](https://github.com/OpusVL/docker-compose-recipes/blob/master/docker-webtrees/docker-compose.override.yml) file.

- Note that if you use the supplied example `nginx` container, you'll want to change the default `server_name` directive from `localhost` to the name of the virtual host you want to run Webtrees under.

- The `docker-compose.override.yml` file makes reference to two additional bind mounts (i.e. `- ${PWD}/database:/var/lib/mysql`) in order to make that data persistent. For convenience we've set a sensible default of `${PWD}/`, meaning that those binds will be created in the same location as the `docker-compose.yml` file. We recommend that you provision a dedicated location on your server to store bind mounts however, such as `/srv/container-volumes/webtrees/database` and `/srv/container-volumes/webtrees/nginx`.
