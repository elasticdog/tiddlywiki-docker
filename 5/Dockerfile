FROM node:alpine
LABEL maintainer="Aaron Bull Schaefer <aaron@elasticdog.com>"

ENV TIDDLYWIKI_VERSION=5.1.17

# https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md#handling-kernel-signals
RUN apk add --no-cache tini
RUN npm install -g tiddlywiki@${TIDDLYWIKI_VERSION}

EXPOSE 8080

VOLUME /tiddlywiki
WORKDIR /tiddlywiki

ENTRYPOINT ["/sbin/tini", "--", "tiddlywiki"]
CMD ["--help"]
