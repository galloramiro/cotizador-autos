# Makefile
# ============================================================================
# Globals
# ============================================================================
CONTAINER_NAME:=cotizador-autos
TAG:=$(shell git log -1 --pretty=format:"%H")

# ============================================================================
# Development Commands
# ============================================================================

.PHONY: build
build: ## Build the docker image.
	docker build \
		--build-arg VERSION=$(TAG) \
		-t $(CONTAINER_NAME) . \

.PHONY: lock-dependencies
lock-dependencies: ## Lock poetry dependencies.
	docker run \
		-v `pwd`:/app \
		-it $(CONTAINER_NAME) poetry lock \

.PHONY: lint
lint: ## Run service linting.
	docker run \
		-v $(shell pwd)/src:/app/src \
		-v $(shell pwd)/.pylintrc:/app/.pylintrc \
		$(CONTAINER_NAME) \
		poetry run pylint /app/src

.PHONY: bash
bash: ## Apply migrations.
	docker run -v `pwd`:/app -it $(CONTAINER_NAME) bash

.PHONY: get docker pipenv
get-virtual-env: .
	docker run -it $(CONTAINER_NAME) /bin/bash -c "poetry env info -p"
