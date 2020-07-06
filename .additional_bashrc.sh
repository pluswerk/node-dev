alias ll='ls -alh'
source ~/.git-completion.bash
source ~/.git-prompt.sh

if [[ $CONTAINER_ID != ${HOSTNAME}* ]] ; then
  export HOST_DISPLAY_NAME=$HOSTNAME
fi

PS1='\033]2;'$(pwd)'\007\[\e[0;36m\][\[\e[1;31m\]\u\[\e[0;36m\]@\[\e[1;34m\]$HOST_DISPLAY_NAME\[\e[0;36m\]: \[\e[0m\]\w\[\e[0;36m\]]\[\e[0m\]\$\[\e[1;32m\]\s\[\e[0;33m\]$(__git_ps1)\[\e[0;36m\]> \[\e[0m\]\n$ ';

# Run SSH Agent and add key 7d
if [ -z "$SSH_AUTH_SOCK" ] ; then
  eval `ssh-agent -s`
  ssh-add -t 604800 ~/.ssh/id_rsa
fi
