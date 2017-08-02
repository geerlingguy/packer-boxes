#!/bin/bash -eux

# Uninstall Ansible and dependencies, remove added Ansible repository, clean apt caches
apt-get -y remove --purge ansible
apt-add-repository --remove ppa:ansible/ansible
apt-get update
apt-get -y autoremove
apt-get clean

#Remove older linux kernels - source: https://askubuntu.com/posts/254585/revisions
echo $(dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p') $(dpkg --list | grep linux-headers | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p') | xargs sudo apt-get -y purge

# Delete unneeded files.
rm -f /home/vagrant/*.sh
rm -r /var/log/*.gz > /dev/null 2>&1

# Remove bash history
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history

# Cleanup log files
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# Whiteout /
echo "Free space on / is zeroed. Please wait."
count=`df --sync -kP / | tail -n1  | awk -F ' ' '{print $4}'`
let count--
dd if=/dev/zero of=/tmp/whitespace bs=1024 count=$count
rm /tmp/whitespace
 
# Whiteout /boot
echo "Free space on /boot is zeroed. Please wait."
count=`df --sync -kP /boot | tail -n1 | awk -F ' ' '{print $4}'`
let count--
dd if=/dev/zero of=/boot/whitespace bs=1024 count=$count
rm /boot/whitespace
 
swappart=`cat /proc/swaps | tail -n1 | awk -F ' ' '{print $1}'`
swapoff $swappart
dd if=/dev/zero of=$swappart
mkswap $swappart
swapon $swappart

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync

