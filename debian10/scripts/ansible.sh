#!/bin/bash -eux

# Install Ansible dependencies.
apt -y update && apt-get -y upgrade
apt -y install python-pip python-dev

# Install Ansible.
pip install ansible
