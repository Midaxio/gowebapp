#!/bin/bash

set -xeo pipefail

sudo locale-gen en_GB.UTF-8
sudo dpkg -i /tmp/files/chefdk.deb
sudo apt-get -y install git
