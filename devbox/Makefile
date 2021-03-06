ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PATH := $(ROOT_DIR)/utils/blackbox:$(PATH)
VAGRANT_DEFAULT_PROVIDER := virtualbox
CHEFDK_URL := https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/14.04/x86_64/chefdk_0.10.0-1_amd64.deb
BLACKBOX_URL := https://github.com/StackExchange/blackbox.git

devbox: Vagrantfile .downloadchefdk .sshkey
ifeq ("$(wildcard .vagrantup)","")
	@echo Starting vagrant box
	VAGRANT_DEFAULT_PROVIDER=$(VAGRANT_DEFAULT_PROVIDER) vagrant up && \
	touch $(ROOT_DIR)/.vagrantup
else
	@echo Vagrant box already starated
endif

.downloadchefdk:
ifeq ("$(wildcard files/chefdk.deb)","")
	@echo Downloading Chef Development kit
	mkdir -p $(ROOT_DIR)/files
	curl -o $(ROOT_DIR)/files/chefdk.deb -L $(CHEFDK_URL)
else
	@echo Chef Development kit already downloaded
endif

.downloadblackbox:
ifeq ("$(wildcard utils/blackbox)","")
	@echo Downloading blackbox
	mkdir -p $(ROOT_DIR)/utils/
	git clone $(BLACKBOX_URL) utils/blackbox
	rm -rf utils/blackbox/.git
else
	@echo Blackbox already installed
endif

.sshkey: .downloadblackbox
ifeq ("$(wildcard files/id_rsa)","")
	@echo Moving ssh key
	PATH=$(PATH); cp ../keys/sainsburys-test.pem files/id_rsa
else
	@echo Key already decrypted
endif

.decryptfiles: .downloadblackbox
ifeq ("$(wildcard aws-cred/credentials)","")
	@echo Decrypting encrypted files
	PATH=$(PATH); blackbox_decrypt_all_files
else
	@echo Files already decrypted
endif

clean: 
	vagrant destroy -f && rm -f .vagrantup

cleanall: clean
	rm -rf files/
