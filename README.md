# node-dev

NODE-DEV is a small package that adds some tools to ease the development inside a node container.

It is derived from [pluswerk/php-dev](https://github.com/pluswerk/php-dev/) and includes `git`, `ssh`, `vim`, `nano`, `ping`, `mysql`, `mysqldump`, and autocomplete for `git`

It comes with versions for: `current`/`21`, `20`, `19`, `lts`/`18`, `17`, `16`, `15`, `14`, `13` and `12`.

All images after `18` are also available as `alpine` versions. eg: `lts-alpine`, `current-alpine`, `20-alpine`

# example docker-compose.yml
````yml
version: '3.5'

services:
  node:
    image: ghcr.io/pluswerk/node-dev:lts-alpine
    volumes:
      - ./:/app
      # the docker socket is optional if no node container is needed
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ~/.ssh:/home/node/.ssh
      - ~/.gitconfig:/home/node/.gitconfig
    working_dir: /app
    environment:
      #      Don't forget to connect via bash start.sh
      - APPLICATION_UID=${APPLICATION_UID:-1000}
      - APPLICATION_GID=${APPLICATION_GID:-1000}
    stop_signal: SIGKILL
    entrypoint: bash -c 'groupmod -g $$APPLICATION_GID node; usermod -u $$APPLICATION_UID node; sleep infinity'

networks:
  default:
    name: global
    external: true

````

View all tags: [Github Container Registry](https://github.com/pluswerk/node-dev/pkgs/container/node-dev/versions?filters%5Bversion_type%5D=tagged).
