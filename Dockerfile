FROM node

WORKDIR /project

RUN npm install express

RUN mkdir /public

COPY server.js /project

COPY public/index.html /project/public/

EXPOSE 3000

CMD ["node", "server.js"]
