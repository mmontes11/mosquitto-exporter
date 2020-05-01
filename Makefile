BUILD_DIR:=bin
MOSQUITTO_EXPORTER_BINARY:=$(BUILD_DIR)/mosquitto_exporter
IMAGE := mmontes11/mosquitto-prometheus-exporter
LDFLAGS=-s -w -X main.GITCOMMIT=`git rev-parse --short HEAD`
CGO_ENABLED=0
GOARCH=arm64

.PHONY: help
help:
	@echo
	@echo "Available targets:"
	@echo "  * build             - build the binary, output to $(ARC_BINARY)"
	@echo "  * linux             - build the binary, output to $(ARC_BINARY)"
	@echo "  * docker            - build docker image"

.PHONY: build

clean:
	rm -rf bin

build: clean
	@mkdir -p $(BUILD_DIR)
	go build -o $(MOSQUITTO_EXPORTER_BINARY) -ldflags="$(LDFLAGS)" .

linux: export GOOS=linux
linux: build

docker:
	docker build -t $(IMAGE) .

push:
	docker push $(IMAGE)
