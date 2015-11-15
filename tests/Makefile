ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PATH := $(ROOT_DIR)/utils/blackbox:$(PATH)
VAGRANT_DEFAULT_PROVIDER := virtualbox
CHEFDK_URL := https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/14.04/x86_64/chefdk_0.10.0-1_amd64.deb
BLACKBOX_URL := https://github.com/StackExchange/blackbox.git
CURL_COMMAND := curl http://localhost:8888

proxyup: Vagrantfile
ifeq ("$(wildcard .vagrantupproxy)","")
	@echo Starting vagrant box
	VAGRANT_DEFAULT_PROVIDER=$(VAGRANT_DEFAULT_PROVIDER) vagrant up proxy --provision
	@touch .vagrantupproxy
endif

app1up: Vagrantfile
ifeq ("$(wildcard .vagrantupapp1)","")
	@echo Starting vagrant box
	VAGRANT_DEFAULT_PROVIDER=$(VAGRANT_DEFAULT_PROVIDER) vagrant up app1 --provision
	@touch .vagrantupapp1
endif

app2up: Vagrantfile
ifeq ("$(wildcard .vagrantupapp2)","")
	@echo Starting vagrant box
	VAGRANT_DEFAULT_PROVIDER=$(VAGRANT_DEFAULT_PROVIDER) vagrant up app2 --provision
	@touch .vagrantupapp2
endif

allup: proxyup app1up app2up
	@echo All boxes started

localtest: allup
	@$(CURL_COMMAND)  && \
	printf '\n'
	@$(CURL_COMMAND)

clean: 
	vagrant destroy -f && rm -f .vagrantup*

