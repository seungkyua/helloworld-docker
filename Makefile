.PHONY: build clean docker

default: build

all: build docker

build: build-darwin build-linux

build-darwin:
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o bin/helloworld-docker-darwin-amd64 .

build-linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o bin/helloworld-docker-linux-amd64 .

clean:
	rm -rf ./bin

docker:
	docker build --no-cache -t seungkyua/helloworld-docker -f Dockerfile .
