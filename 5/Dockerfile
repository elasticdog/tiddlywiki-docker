FROM node:alpine

ENV TIDDLYWIKI_VERSION=5.1.17

ARG SOURCE_COMMIT
LABEL maintainer="Aaron Bull Schaefer <aaron@elasticdog.com>"
LABEL source="https://github.com/elasticdog/tiddlywiki-docker"
LABEL source-commit="${SOURCE_COMMIT:-unknown}"

# https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md#handling-kernel-signals
RUN apk add --no-cache tini
RUN npm install -g tiddlywiki@${TIDDLYWIKI_VERSION}

EXPOSE 8080

VOLUME /tiddlywiki
WORKDIR /tiddlywiki

ENTRYPOINT ["/sbin/tini", "--", "tiddlywiki"]
CMD ["--help"]
