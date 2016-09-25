REGISTRY = bigr.bios.cf.ac.uk:4567
NAME = sacim/centos7-tl
IMAGE = $(REGISTRY)/$(NAME)

.PHONY: all build push run test clean

all: build

build:
	docker build --no-cache --rm -t $(IMAGE) .

# docker login required for push
push:
	docker push $(IMAGE)

run:
	docker run -it $(IMAGE) bash

test:
	docker run -i $(IMAGE) bash < tests.sh

clean:
ifeq ($(strip $(IMAGE)),) 
	echo "Nothing to delete" 
else 
	docker ps -a | awk '{ print $$1,$$2 }' | grep "$(IMAGE)" | awk '{print $$1 }' | xargs -I {} docker rm {} 
endif
