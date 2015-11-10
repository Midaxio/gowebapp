OS = $(shell uname)
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PATH := $(ROOT_DIR)/output/packer_util:$(PATH)
VAGRANT_DEFAULT_PROVIDER := virtualbox
CHEFDK_URL := https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/14.04/x86_64/chefdk_0.10.0-1_amd64.deb

vagrant: packerinstall vagrantup
	PATH=$(PATH); packer build -only local\
    	$$(vagrant ssh-config | perl -ne 'print " -var Null$$1=$$2" if /(User|Port|HostName|IdentityFile) (\S+)/') \
        packer-template.json

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
