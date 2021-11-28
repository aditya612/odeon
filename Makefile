SHELL := /usr/bin/env bash
VERSION := $(shell cat pubspec.yaml | grep "^version: " | cut -c 10- | sed 's/+/\-/')
BUILD_ROOT := ../build-package
BASE_NAME := odeon-$(VERSION)
BUILD_DIR := $(BUILD_ROOT)/$(BASE_NAME)
BIN_TAR := $(BUILD_ROOT)/$(BASE_NAME).tar
SRC_TAR := $(BUILD_ROOT)/$(BASE_NAME)-src.tar
FLUTTER := flutter

all: version bin

version:
	@echo VERSION is $(VERSION)
	@echo BUILD_ROOT is $(BUILD_ROOT)

distclean:
	$(FLUTTER) clean
	rm -rf $(BUILD_ROOT)

odeon: distclean
	$(FLUTTER) pub get
	$(FLUTTER) build linux --release

bin: odeon
	mkdir -p $(BUILD_DIR)
	cp -a build/linux/x64/release/bundle/* $(BUILD_DIR)
	# cp -a assets/resources $(BUILD_DIR)
	tar -C $(BUILD_ROOT) -c -v -f $(BIN_TAR) $(BASE_NAME)
	xz -z $(BIN_TAR)

src:
	mkdir -p $(BUILD_ROOT)
	tar -C .. -c -v -f $(SRC_TAR) --exclude .git --transform 's/^odeon/$(BASE_NAME)/' odeon
	rm ${SRC_TAR}.xz
	xz -z $(SRC_TAR)