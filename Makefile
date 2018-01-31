SHELL:=bash
OPENCV_VERSION ?= 2.4.13.5
CONTAINER_NAME ?= willprice/opencv2-cuda8
SINGULARITY_NAME ?= opencv2-4-13-cuda8.img
TAG ?= $(OPENCV_VERSION)-cuda8


.PHONY: build
build:
	docker build -t $(CONTAINER_NAME) .

version.txt: build
	./tag.sh "$(CONTAINER_NAME)" > version.txt

.PHONY: push
push: version.txt
	docker push $(CONTAINER_NAME)

.PHONY: singularity
singularity: $(SINGULARITY_NAME)

$(SINGULARITY_NAME): tag
	singularity  build $@ Singularity
