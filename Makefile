SHELL := /bin/bash

.PHONY: install start run check diagnostics docker-build

install:
	npm install

start:
	npm start

run: start

check:
	./scripts/check-project.sh

diagnostics:
	./scripts/safe-diagnostics.sh

docker-build:
	docker build -t github-actions-self-hosted-runner-lab:local .
