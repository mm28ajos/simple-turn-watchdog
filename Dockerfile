FROM node:17-bullseye

WORKDIR /usr/src/app

COPY package*.json ./

RUN apt update && apt install -y chromium-browser libnss3 libatk-bridge2.0-0 libcups2 libgbm-dev libxkbcommon0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libasound2

RUN npm ci --only=production

COPY src/* ./ 

CMD [ "node", "server.js" ]