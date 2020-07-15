#!/bin/bash -eux

# Install Ansible repository.
apt-get -y update && apt-get -y upgrade
#Docker pre-req install packages that allow apt to work over https
apt-get -y install  ansible apt-transport-https ca-certificates software-properties-common

#Install any other useful packages
#apt-add-repository ppa:ansible/ansible

#Add GPG Key for official docker to system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

#Add GPG Key for K8s
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

#Add GPG Key for Ansible
curl -fsSL http://ppa.launchpad.net/ansible/ansible/ubuntu/dists/bionic/Release.gpg | apt-key add -

#Add Docker repo to apt sources
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

#Add K8s to apt sources will need to be updated to focal fossa when it becomes available
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

#Update repo for Docker
apt-get -y update

#Install Docker, Ansible and K8s 
apt-get -y install docker-ce
apt-get -y install kubelet kubeadm kubectl kubernetes-cni