IMG := codekoala/pypi
TAG := 1.2.1
IMG_TAG := $(IMG):$(TAG)

PYPI ?= /srv/pypi
PYPI_HOSTNAME ?= pypi.local
PYPI_NAME ?= pypi

build:
	docker build --pull --tag $(IMG_TAG) .

run:
	docker run -it --rm \
		--name $(PYPI_NAME) \
		-h $(PYPI_HOSTNAME) \
		-v $(PYPI):/srv/pypi:rw \
		-p 8080:80 \
		$(IMG_TAG)

clean:
	docker rmi `docker images -q $(IMG_TAG)`
