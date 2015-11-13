OS = $(shell uname)
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PATH := $(ROOT_DIR)/utils/blackbox:$(PATH)
VAGRANT_DEFAULT_PROVIDER := virtualbox
CHEFDK_URL := https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/14.04/x86_64/chefdk_0.10.0-1_amd64.deb
BLACKBOX_URL := https://github.com/StackExchange/blackbox.git

provision-ec2: 
	ansible-playbook -i provision/hosts provision/provision.yaml

bootstrap: provision-ec2
	ansible-playbook --step -i provision/hosts -l remote provision/install-chef.yaml

cleanall: clean
	rm -rf files/
