ARG FROM=node:lts
ARG DIST_ADDON=-alpine
FROM $FROM AS base-alpine

# Install additional software Alpine:
RUN apk add --no-cache bash curl openssh-client-default sudo vim nano git-perl git-lfs less tree bash-completion mariadb-client iputils sshpass gdb tzdata findmnt jq docker-cli file && \
    echo "node ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


FROM $FROM AS base
RUN apt-get update && \
  apt-get install -y sudo vim nano git-lfs less tree bash-completion mariadb-client iputils-ping sshpass gdb jq && \
  usermod -aG sudo node && \
  echo "node ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  curl -fsSL https://get.docker.com/ | sh && \
  usermod -aG docker node && \
  rm -rf /var/lib/apt/lists/*

FROM base${DIST_ADDON}

ENV PATH=$PATH:./node_modules/.bin

COPY bin/* /usr/local/bin/
COPY .additional_bashrc.sh .additional_bashrc_ps1.sh /home/node/
COPY .vimrc /home/node/.vimrc
COPY .vimrc /home/root/.vimrc
RUN echo "source ~/.additional_bashrc.sh" >> /home/node/.bashrc &&  \
 curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > /home/node/.bash_git
