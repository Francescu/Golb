SHELL   :=/bin/bash
DOCKER_DEV_NAME = golb-dev
DBNAME = Golb
PORT = 8002

docker:
	docker build -t $(DOCKER_DEV_NAME) .
	docker run -d -p $(PORT):$(PORT) --name container-$(DOCKER_DEV_NAME) $(DOCKER_DEV_NAME)

clean:
	swift build --clean
	rm -rf ./Packages
	docker rm container-$(DOCKER_DEV_NAME)

local:
	swift build 
	export GOLB_POSTGRES_CONNECTION=postgresql://localhost/$(DBNAME) && .build/debug/Server

database:
	psql -lqt | cut -d \| -f 1 | grep -wq $(DBNAME) || createdb $(DBNAME)
