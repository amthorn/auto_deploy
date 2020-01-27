.PHONY: build
build:
	docker build -t avthorn/auto_deploy:latest .

.PHONY: push
push:
	docker push avthorn/auto_deploy:latest

.PHONY: up
up:
	docker-compose up --build
