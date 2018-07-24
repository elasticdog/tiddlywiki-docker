DOCKER_HUB_REPOSITORY ?= elasticdog

.PHONY: all
all: build

.PHONY: build
build: SOURCE_COMMIT = $(shell git rev-parse HEAD)
build:
	docker build --build-arg "SOURCE_COMMIT=${SOURCE_COMMIT}" --tag tiddlywiki .

.PHONY: test
test:
	cd tests/ && dgoss run tiddlywiki --server

.PHONY: tag
tag: UNIQUE_TAG = $(shell printf '%s.%s' "$$(date +%Y%m%d)" "$${CIRCLE_BUILD_NUM:-$$(git rev-parse --short=12 HEAD)}")
tag: PATCH_VERSION = $(shell docker run -it --rm tiddlywiki --version | sed 's/[^0-9.]*//g')
tag: MINOR_VERSION = $(shell echo "${PATCH_VERSION}" | awk -F. '{ print $$1"."$$2 }')
tag: MAJOR_VERSION = $(shell echo "${PATCH_VERSION}" | awk -F. '{ print $$1 }')
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
	docker push "${DOCKER_HUB_REPOSITORY}/tiddlywiki"

.PHONY: clean
clean:
	docker image rm tiddlywiki
