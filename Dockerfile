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

ENV HOME=/home/node

RUN rm -rf $HOME/nodejs-test
RUN mkdir -p $HOME/nodejs-test

ADD . $HOME/nodejs-test/

WORKDIR $HOME/nodejs-test

VOLUME ["/home/node/nodejs-test/logs/"]

EXPOSE 3000

CMD ["node", "."]