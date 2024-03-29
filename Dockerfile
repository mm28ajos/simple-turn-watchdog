FROM node:lts-slim

WORKDIR /usr/src/app

RUN apt update && apt upgrade -y && apt install -y chromium git \
    &&  git clone https://github.com/webrtc/samples \
    && mv samples/src /usr/src/app/ \
    && rm -rf samples/ \
    && apt-get purge -y git && apt autoremove -y \
    && chown -R node:node /usr/src/app

COPY package.json ./

USER node

RUN npm install

COPY --chown=node:node src/ ./ 

EXPOSE 3000

CMD [ "node", "server.js" ]
