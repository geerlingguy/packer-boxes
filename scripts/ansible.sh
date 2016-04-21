#!/bin/bash -eux

# Install pip.
apt -y install python-setuptools python-dev
easy_install pip

# Install Ansible.
pip install ansible

# TODO: Switch to official apt repo after the following issue is resolved:
# https://github.com/ansible/ansible/issues/15524

# Install Ansible repository.
# apt -y update && apt-get -y upgrade
# apt -y install software-properties-common
# apt-add-repository ppa:ansible/ansible

# Install Ansible.
# apt -y update
# apt -y install ansible
