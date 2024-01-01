FROM node:16-bullseye AS build
WORKDIR /app
COPY package.json package-lock.json ./
COPY . .
#RUN npm ci
RUN npm install --force
RUN npm run build

FROM node:16-bullseye AS deploy
WORKDIR /app

RUN apt update
RUN apt install -y iputils-ping

COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/build ./build
COPY --from=build /app/svelte.config.js .
COPY --from=build /app/package.json ./

ENV PORT=3000
CMD [ "node", "./build" ]
