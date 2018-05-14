FROM node:9.11-stretch as builder
ENV NODE_ENV=production
WORKDIR /usr/app/dist
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN apt-get update -q && apt-get install -q python make gcc g++
RUN npm install --production --silent
COPY . .

FROM node:9.11-alpine
ENV NODE_ENV=production
WORKDIR /usr/src/app
COPY --from=builder /usr/app/dist .
# HEALTHCHECK --interval=10s --timeout=30s --start-period=2s --retries=5 CMD [ "curl", "http://localhost:8081/" ]
CMD ["npm", "start"]