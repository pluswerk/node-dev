FROM node:lts

ENV PATH=$PATH:./node_modules/.bin

RUN apt-get update && \
  apt-get install -y sudo vim nano less tree bash-completion iputils-ping && \
  usermod -aG sudo node && \
  echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  rm -rf /var/lib/apt/lists/*

COPY .additional_bashrc.sh /home/node/.additional_bashrc.sh
COPY .vimrc /home/node/.vimrc
COPY .vimrc /home/root/.vimrc
RUN echo "source ~/.additional_bashrc.sh" >> /home/node/.bashrc

# add .git-completion.bash and  .git-prompt.bash
RUN curl https://raw.githubusercontent.com/git/git/v$(git --version | awk 'NF>1{print $NF}')/contrib/completion/git-completion.bash > /home/node/.git-completion.bash && \
  curl https://raw.githubusercontent.com/git/git/v$(git --version | awk 'NF>1{print $NF}')/contrib/completion/git-prompt.sh > /home/node/.git-prompt.sh
