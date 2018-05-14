FROM node:9.11-stretch as builder
ENV NODE_ENV production
WORKDIR dist/
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN apt-get update && apt-get install python make gcc g++ git
RUN npm install --production
COPY . .

FROM node:9.11-alpine:latest
ENV NODE_ENV=production
WORKDIR /usr/src/app
COPY --from=builder dist/ .
EXPOSE 8082
EXPOSE 8081
EXPOSE 5001
CMD npm start