# Packer Example - Ubuntu 16.04 minimal Vagrant Box

**Current Ubuntu Version Used**: 16.04

This example build configuration installs and configures Ubuntu 16.04 x86_64 minimal using Ansible, and then generates two Vagrant box files, for:

  - VirtualBox
  - VMware

The example can be modified to use more Ansible roles, plays, and included playbooks to fully configure (or partially) configure a box file suitable for deployment for development environments.

## Requirements

The following software must be installed/present on your local machine before you can use Packer to build the Vagrant box file:

  - [Packer](http://www.packer.io/)
  - [Vagrant](http://vagrantup.com/)
  - [VirtualBox](https://www.virtualbox.org/) (if you want to build the VirtualBox box)
  - [VMware Fusion](http://www.vmware.com/products/fusion/) (or Workstation - if you want to build the VMware box)
  - [Ansible](http://docs.ansible.com/intro_installation.html)

You will also need some Ansible roles installed so they can be used in the building of the VM. To install the roles:

  1. Run `$ ansible-galaxy install -r requirements.txt` in this directory.
  2. If your local Ansible roles path is not the default (`/etc/ansible/roles`), update the `role_paths` inside `ubuntu1604.json` to match your custom location.

If you don't have Ansible installed (perhaps you're using a Windows PC?), you can simply clone the required Ansible roles from GitHub directly (use [Ansible Galaxy](https://galaxy.ansible.com/) to get the GitHub repository URLs for each role listed in `requirements.txt`), and update the `role_paths` variable to match the location of the cloned role.

## Usage

Make sure all the required software (listed above) is installed, then cd to the directory containing this README.md file, and run:

    $ packer build ubuntu1604.json

After a few minutes, Packer should tell you the box was generated successfully.

If you want to only build a box for one of the supported virtualization platforms (e.g. only build the VMware box), add `--only=vmware-iso` to the `packer build` command:

    $ packer build --only=vmware-iso ubuntu1604.json

## License

MIT license.

## Author Information

Created in 2016 by [Jeff Geerling](http://jeffgeerling.com/), author of [Ansible for DevOps](http://ansiblefordevops.com/).
