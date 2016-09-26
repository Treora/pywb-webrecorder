DATA_VOLUME = pywb-webrecorder-data
IMAGE_NAME = pywb-webrecorder-localbuild
CONTAINER_NAME = pywb-webrecorder

.PHONY: help
help:
	# Usage:
	#     make stop (if started)
	#     make rebuild  (= make build rm create)
	#     make start

.PHONY: rebuild
rebuild: build rm create

.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .

.PHONY: create
create:
	docker create \
		--name $(CONTAINER_NAME) \
		-p 8080:8080 \
		--restart always \
		-v $(DATA_VOLUME):/data \
		$(IMAGE_NAME)

.PHONY: start
start:
	docker start $(CONTAINER_NAME)

.PHONY: stop
stop:
	docker stop $(CONTAINER_NAME)

.PHONY: rm
rm:
	docker rm $(CONTAINER_NAME) > /dev/null || true
