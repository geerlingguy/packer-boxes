#!/bin/bash -eux

# Uninstall Ansible and remove PPA.
apt -y remove --purge ansible
apt-add-repository --remove ppa:ansible/ansible

# Apt cleanup.
apt autoremove -y
apt update

#  Blank netplan machine-id (DUID) so machines get unique ID generated on boot.
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

# Delete unneeded files.
rm -f /home/vagrant/*.sh

# Zero out the rest of the free space using dd, then delete the written file.
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
