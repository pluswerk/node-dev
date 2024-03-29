export LS_COLORS="${LS_COLORS}di=1;34:"
alias ll='ls -alh'
export PATH=$PATH:~/.config/composer/vendor/bin:~/.composer/vendor/bin:./bin:./vendor/bin:./node_modules/.bin:~/.yarn/bin

# only enable docker aliases if docker-socket is mounted
CONTAINER_ID=$(basename $(findmnt /etc/hosts -o SOURCE | grep -o 'containers\/.\+\/'))
export HOST_DISPLAY_NAME=$HOSTNAME
if sudo docker ps -q &>/dev/null; then
  DOCKER_COMPOSE_PROJECT=$(sudo docker inspect ${CONTAINER_ID} | jq -r '.[0].Config.Labels."com.docker.compose.project"')
  export NODE_CONTAINER=$(sudo docker ps -f "name=${DOCKER_COMPOSE_PROJECT}" --format {{.Names}} | grep node)
  export HOST_DISPLAY_NAME=$(sudo docker inspect ${CONTAINER_ID} --format='{{.Name}}')
  export HOST_DISPLAY_NAME=${HOST_DISPLAY_NAME:1}
fi;

export HISTCONTROL=ignoreboth:erasedups

if [[ $CONTAINER_ID != ${HOSTNAME}* ]] ; then
  export HOST_DISPLAY_NAME=$HOSTNAME
fi

source ~/.bash_git

PS1='\033]2;$HOST_DISPLAY_NAME: \w\007\[\e[0;36m\][\[\e[1;31m\]\u\[\e[0;36m\]@\[\e[1;34m\]$HOST_DISPLAY_NAME\[\e[0;36m\]: \[\e[0m\]\w\[\e[0;36m\]]\[\e[0m\]\$\[\e[1;32m\]\s\[\e[0;33m\]$(__git_ps1)\[\e[0;36m\]> \[\e[0m\]\n$ ';

# Run SSH Agent and add key 7d
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  if [ -f ~/.ssh/id_rsa ]; then
  ssh-add -t 604800 ~/.ssh/id_rsa
  fi
  if [ -f ~/.ssh/id_ed25519 ]; then
    ssh-add -t 604800 ~/.ssh/id_ed25519
  fi
fi

if [ -v VIRTUAL_HOST ] ; then
  echo 'Frontend URLs:'
  echo $VIRTUAL_HOST | tr "," "\n" | awk '{print "  https://" $0}'
fi