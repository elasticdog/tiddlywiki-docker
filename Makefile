DOCKER_HUB_REPOSITORY ?= elasticdog

.PHONY: all
all: build

.PHONY: build
build:
	docker build -t tiddlywiki .

.PHONY: test
test:
	cd tests/ && dgoss run tiddlywiki --server

.PHONY: tag
tag: PATCH_VERSION := $(shell docker run -it --rm tiddlywiki --version | sed 's/[^0-9.]*//g')
tag: MAJOR_VERSION := $(shell echo "${PATCH_VERSION}" | sed 's/\..*//')
tag:
	docker tag tiddlywiki "${DOCKER_HUB_REPOSITORY}/tiddlywiki:latest"
	docker tag tiddlywiki "${DOCKER_HUB_REPOSITORY}/tiddlywiki:${PATCH_VERSION}"
	docker tag tiddlywiki "${DOCKER_HUB_REPOSITORY}/tiddlywiki:${MAJOR_VERSION}"
	docker image ls "${DOCKER_HUB_REPOSITORY}/tiddlywiki"

.PHONY: deploy
deploy: tag
	docker push "${DOCKER_HUB_REPOSITORY}/tiddlywiki"

.PHONY: clean
clean:
	docker image rm tiddlywiki
