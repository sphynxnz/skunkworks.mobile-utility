FROM node:8
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
CMD npm run start:docker
EXPOSE 8000 7777