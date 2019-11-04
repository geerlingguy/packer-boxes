#!/bin/bash -eux

# Install Ansible dependencies.
apt -y update && apt-get -y upgrade
apt -y install python-pip python-dev libssl-dev libffi-dev

# Install Ansible. Upgrade order is important, otherwise different parts of the
# install will fail.
pip install --upgrade cffi
pip install ansible
pip install --upgrade setuptools
pip install --upgrade cryptography
