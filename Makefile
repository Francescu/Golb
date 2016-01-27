SHELL   :=/bin/bash
DOCKER_DEV_NAME = golb-dev
PORT = 8000

docker:
	docker build -t $(DOCKER_DEV_NAME) .
	docker rm container-$(DOCKER_DEV_NAME)
	docker run -d -p $(PORT):$(PORT) --name container-$(DOCKER_DEV_NAME) $(DOCKER_DEV_NAME)

dev-run:
	swift build 
	.build/debug/Server
