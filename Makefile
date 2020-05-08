TAG ?= $(shell git describe --tags)
DOCKER_IMAGE ?=	moul/actions-base:$(TAG)

include rules.mk
