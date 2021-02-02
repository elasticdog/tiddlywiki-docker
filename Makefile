DOCKER_HUB_REPOSITORY ?= elasticdog

UNIQUE_TAG := $(shell printf '%s.%s' "$$(date +%Y%m%d)" "$${CIRCLE_BUILD_NUM:-$$(git rev-parse --short=12 HEAD)}")
PATCH_VERSION := $(shell docker run -it --rm tiddlywiki --version | sed 's/[^0-9.]*//g')
MINOR_VERSION := $(shell echo "${PATCH_VERSION}" | awk -F. '{ print $$1"."$$2 }')
MAJOR_VERSION := $(shell echo "${PATCH_VERSION}" | awk -F. '{ print $$1 }')

.PHONY: all
all: build

.PHONY: build
build: SOURCE_COMMIT = $(shell git rev-parse HEAD)
build:
	docker build --build-arg "SOURCE_COMMIT=${SOURCE_COMMIT}" --tag tiddlywiki .

.PHONY: test
test:
	cd tests/ && dgoss run tiddlywiki --listen

.PHONY: tag
tag:
	# unique tag
	docker tag tiddlywiki "${DOCKER_HUB_REPOSITORY}/tiddlywiki:${UNIQUE_TAG}"
	# stable tags
	docker tag tiddlywiki "${DOCKER_HUB_REPOSITORY}/tiddlywiki:latest"
	docker tag tiddlywiki "${DOCKER_HUB_REPOSITORY}/tiddlywiki:${PATCH_VERSION}"
	docker tag tiddlywiki "${DOCKER_HUB_REPOSITORY}/tiddlywiki:${MINOR_VERSION}"
	docker tag tiddlywiki "${DOCKER_HUB_REPOSITORY}/tiddlywiki:${MAJOR_VERSION}"
	docker image ls "${DOCKER_HUB_REPOSITORY}/tiddlywiki"

.PHONY: deploy
deploy: tag
	# unique tag
	docker push "${DOCKER_HUB_REPOSITORY}/tiddlywiki:${UNIQUE_TAG}"
	# stable tags
	docker push "${DOCKER_HUB_REPOSITORY}/tiddlywiki:latest"
	docker push "${DOCKER_HUB_REPOSITORY}/tiddlywiki:${PATCH_VERSION}"
	docker push "${DOCKER_HUB_REPOSITORY}/tiddlywiki:${MINOR_VERSION}"
	docker push "${DOCKER_HUB_REPOSITORY}/tiddlywiki:${MAJOR_VERSION}"

.PHONY: clean
clean:
	docker image rm tiddlywiki
