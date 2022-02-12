#!/bin/bash -eux

# Remove Ansible and its dependencies.
pip3 install pip-autoremove
ln -s /usr/bin/pip3 /usr/bin/pip
/usr/local/bin/pip-autoremove ansible -y
rm -f /usr/bin/pip
pip3 uninstall pip-autoremove -y

# Zero out the rest of the free space using dd, then delete the written file.
echo "Writing zeroes to free space (this could take a while)."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
