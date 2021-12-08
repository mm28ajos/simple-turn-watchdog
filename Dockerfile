FROM node:17-bullseye

WORKDIR /usr/src/app

COPY package*.json ./

RUN apt update && apt install -y chromium

RUN npm ci --only=production

COPY src/* ./ 

CMD [ "node", "server.js" ]