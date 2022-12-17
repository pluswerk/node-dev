# node-dev

NODE-DEV is a small package that adds some tools to ease the development inside a node container.

It is derived from [pluswerk/php-dev](https://github.com/pluswerk/php-dev/) and includes `git`, `ssh`, `vim`, `nano`, `ping`, `mysql`, `mysqldump`, and autocomplete for `git`

It comes with versions for: `current/19`, `lts/18`, `17`, `16`, `15`, `14`, `13` and `12`.

# example docker-compose.yml
````yml
version: '3.5'

services:
  node:
    image: pluswerk/node-dev:lts
    volumes:
      - ./:/app
    working_dir: /app
    environment:
      #      Don't forget to connect via bash start.sh
      - APPLICATION_UID=${APPLICATION_UID:-1000}
      - APPLICATION_GID=${APPLICATION_GID:-1000}
    stop_signal: SIGKILL
    entrypoint: bash -c 'groupmod -g $$APPLICATION_GID node; usermod -u $$APPLICATION_UID node; tail -f /dev/null'

networks:
  default:
    name: global
    external: true

````

View it on [Docker Hub](https://hub.docker.com/r/pluswerk/node-dev).
