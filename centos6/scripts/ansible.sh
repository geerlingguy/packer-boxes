#!/bin/bash -eux

# Install Ansible.
yum update
yum -y install epel-release
yum -y install git python-setuptools gcc sudo libffi-devel python-devel openssl-devel ansible
yum clean all
