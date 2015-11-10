OS = $(shell uname)
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PATH := $(ROOT_DIR)/output/packer_util:$(PATH)
VAGRANT_DEFAULT_PROVIDER := virtualbox
CHEFDK_URL := https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/14.04/x86_64/chefdk_0.10.0-1_amd64.deb

vagrantup: Vagrantfile .downloadchefdk
	VAGRANT_DEFAULT_PROVIDER=$(VAGRANT_DEFAULT_PROVIDER) vagrant up && \
	touch .vagrantup

.downloadchefdk:
ifeq ($(wildcard $(ROOT_DIR)/files/chefdk.deb),)
	@echo Downloading Chef Development kit
	curl -o $(ROOT_DIR)/files/chefdk.deb -L $(CHEFDK_URL)
else
	@echo Chef Development kit already downloaded
endif

ssh: vagrantup
	vagrant ssh

clean: 
	vagrant destroy -f && rm -f .vagrantup 
