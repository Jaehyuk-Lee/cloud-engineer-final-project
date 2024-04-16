FROM node:20-alpine3.18

WORKDIR /app

COPY ./app /app

RUN npm install

EXPOSE 3000

CMD ["node", "server.js"]
