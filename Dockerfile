FROM node:8.11.2

# Latest
RUN apt-get update -qq

# Install software
RUN apt-get install -y \
  build-essential \
  git \
  curl \
  vim

RUN apt-get install telnet

# Install Grunt, Gulp, Forever
RUN npm install -g \
  express \
  forever

# Define home directory
ENV HOME=/home/node
#ENV GIT_BRANCH=master

# Add id_rsa key
#RUN mkdir $HOME/.ssh/
#ADD id_rsa $HOME/.ssh/id_rsa

# Create known_hosts & Update SSH Config to add id_rsa
#RUN touch $HOME/.ssh/known_hosts && \
#    ssh-keyscan github.ibm.com >> $HOME/.ssh/known_hosts && \
#    echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config && \
#    chown -R node:node $HOME/.ssh/ && \
#    chmod 600 $HOME/.ssh/known_hosts && \
#    chmod 600 $HOME/.ssh/id_rsa

# Create Application Directory
RUN rm -rf $HOME/nodejs-test
RUN mkdir -p $HOME/nodejs-test
#RUN mkdir -p $HOME/nodejs-test/logs
#RUN chown -R node:node $HOME/nodejs-test

#USER node

# Removes ssh key error
# @see - http://askubuntu.com/questions/698997/key-load-public-invalid-format-with-scp-or-git-clone-on-ubuntu-15-10
#RUN ssh-keygen -f $HOME/.ssh/id_rsa -y > $HOME/.ssh/id_rsa.pub

# Clone the conf files into the docker container
#RUN git clone git@github.ibm.com:IdeaGarage/nodejs-test.git $HOME/nodejs-test
#RUN git clone git@github.ibm.com:CSE/ideaGarage_vsa.git $HOME/nodejs-test


# Add Secrets
#ADD .env $HOME/nodejs-test/.env
ADD . $HOME/nodejs-test/

#VOLUME ["/home/node/nodejs-test/logs/"]

# Add Certs
#ADD sbybz3023.sby.ibm.com.crt $HOME/nodejs-test/server.crt
#ADD sbybz3023.sby.ibm.com.key $HOME/nodejs-test/server.key

WORKDIR $HOME/nodejs-test

VOLUME ["/home/node/nodejs-test/logs/"]

#RUN git fetch origin "${GIT_BRANCH}"
#RUN git checkout --force "origin/${GIT_BRANCH}"

#RUN npm install
#RUN grunt build --force

EXPOSE 3000

CMD ["node", "."]