#!/bin/bash -eux

# Work around bug with Vagrant's handling of stuff.
echo 'GRUB_CMDLINE_LINUX="biosdevname=0 net.ifnames=0"' >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

echo 'auto eth0' >> /etc/network/interfaces
echo 'iface eth0 inet dhcp' >> /etc/network/interfaces
echo 'auto eth1' >> /etc/network/interfaces
echo 'iface eth1 inet manual' >> /etc/network/interfaces

# Uninstall Ansible and remove PPA.
# apt -y remove --purge ansible
# apt-add-repository --remove ppa:ansible/ansible

# Uninstall Ansible and other Pip deps.
pip freeze | grep -v "^-e" | xargs pip uninstall -y
easy_install -m pip
apt -y purge --auto-remove python-setuptools python-dev

# Apt cleanup.
apt autoremove
apt update

# Delete unneeded files.
rm -f /home/vagrant/*.sh

# Zero out the rest of the free space using dd, then delete the written file.
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
