SHELL := /bin/bash
NODE20 := ./scripts/run-with-node20.sh
START_APP := ./scripts/start-app.sh

.PHONY: install start run test check diagnostics docker-build

install:
	$(NODE20) "if [ -f package-lock.json ]; then npm ci; else npm install; fi"

start:
	$(START_APP)

run: start

test:
	$(NODE20) "npm test"

check:
	./scripts/check-project.sh

diagnostics:
	./scripts/safe-diagnostics.sh

docker-build:
	docker build -t github-actions-self-hosted-runner-lab:local .
