FROM node:8
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
#CMD ./node_modules/.bin/stubmatic -v -c ./test/mockserver/mockconfig.json & node index.js
#CMD ./node_modules/.bin/forever ./node_modules/.bin/stubmatic -v -c ./test/mockserver/mockconfig.json & ./node_modules/.bin/forever index.js
CMD npm run start:docker
EXPOSE 8000 7777