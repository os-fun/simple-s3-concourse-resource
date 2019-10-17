IMAGE_NAME ?= splatform/concourse-simple-s3-resource

.PHONY: test
test: image
	IMAGE_NAME=$(IMAGE_NAME) test/check_test.sh
	IMAGE_NAME=$(IMAGE_NAME) test/in_test.sh

.PHONY: image
image:
	docker build -t $(IMAGE_NAME) .
