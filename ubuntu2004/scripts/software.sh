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

#Add .NET Core SDK see https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#2004-
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb

#Update repo for Docker
apt-get -y update

#Install Docker, Ansible, K8s, dotnet core 3.1 and Open JDK 8
apt-get -y install docker-ce
apt-get -qy install kubelet=1.16.13-00 kubeadm=1.16.13-00 kubectl=1.16.13-00
apt-get -y install dotnet-sdk-3.1
apt-get -y install openjdk-11-jre-headless
