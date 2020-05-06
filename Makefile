VERSION ?= "v1.0.0"
LXCFS_VERSION ?= "3.1.2"

all: prep binaries docker

prep:
	mkdir -p bin

binaries: linux64

linux64:
	CGO_ENABLED=0 GOOS=linux go build -mod=vendor -a -installsuffix cgo -o bin/lxcfs-admission-webhook

pack-linux64: linux64
	upx --brute bin/lxcfs-admission-webhook

docker: pack-linux64
	docker build -t pasientskyhosting/lxcfs-admission-webhook:$(VERSION) .
	docker build -t pasientskyhosting/lxcfs:$(LXCFS_VERSION) --build-arg LXCFS_VERSION=$(LXCFS_VERSION) lxcfs-image/

docker-push:
	docker push pasientskyhosting/lxcfs-admission-webhook:$(VERSION)
	docker push pasientskyhosting/lxcfs:$(LXCFS_VERSION)
