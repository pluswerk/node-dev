ARG FROM=node:lts
FROM $FROM

ENV PATH=$PATH:./node_modules/.bin

RUN apt-get update && \
  apt-get install -y sudo vim nano less tree bash-completion mariadb-client iputils-ping sshpass gdb jq && \
  usermod -aG sudo node && \
  echo "node ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  curl -fsSL https://get.docker.com/ | sh && \
  rm -rf /var/lib/apt/lists/*

COPY .additional_bashrc.sh /home/node/.additional_bashrc.sh
COPY .vimrc /home/node/.vimrc
COPY .vimrc /home/root/.vimrc
RUN echo "source ~/.additional_bashrc.sh" >> /home/node/.bashrc &&  \
 curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > /home/node/.bash_git
