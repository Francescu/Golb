SHELL   :=/bin/bash
DOCKER_DEV_NAME = golb-dev
PORT = 8080

dev:
	docker build -t $(DOCKER_DEV_NAME) .
	docker run -d -p $(PORT):$(PORT) --name container-$(DOCKER_DEV_NAME) $(DOCKER_DEV_NAME)
