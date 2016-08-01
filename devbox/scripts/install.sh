#!/bin/bash

set -xeo pipefail

DEV_USER=vagrant

locale-gen en_GB.UTF-8
dpkg -i /tmp/files/chefdk.deb
mv /tmp/files/id_rsa /home/${DEV_USER}/.ssh/
chown $DEV_USER /home/${DEV_USER}/.ssh/id_rsa
chmod 0600 /home/${DEV_USER}/.ssh/id_rsa
apt-get update
apt-get -y install git python-pip python-dev libffi-dev libssl-dev build-essential
pip install ansible==1.9.4
pip install awscli
pip install boto
