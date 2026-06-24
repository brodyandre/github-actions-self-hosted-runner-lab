FROM node:20-alpine

WORKDIR /usr/src/app

COPY package.json ./package.json
COPY app ./app

ENV NODE_ENV=production
EXPOSE 3000

CMD ["node", "app/server.js"]
