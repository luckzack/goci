export GOPATH := $(shell echo $$GOPATH):$(shell pwd)

ready:
	chmod +x scripts/*;

ci: ready
	./scripts/ci

goget: ready
	./scripts/goget

godep: ready
	./scripts/godep

test: ready
	./scripts/test

review: ready
	./scripts/review

build: ready
	./scripts/build

pack: ready
	./scripts/pack

rancherize: ready
	./scripts/rancherize

git: ready
	./scripts/git


