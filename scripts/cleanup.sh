#!/bin/bash -eux

# Uninstall Ansible and remove PPA.
apt-get -y remove --purge ansible
apt-add-repository --remove ppa:ansible/ansible
apt-get update
apt-get -y autoremove
apt-get clean

#Remove older linux kernels - source: https://askubuntu.com/posts/254585/revisions
#dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p' | xargs sudo apt-get -y purge
echo $(dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p') $(dpkg --list | grep linux-headers | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p') | xargs sudo apt-get -y purge

# Delete unneeded files.
rm -f /home/vagrant/*.sh
rm -r /var/log/*.gz

# Zero out the rest of the free space using dd, then delete the written file.
echo "Free space on / is zeroed. Please wait."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
