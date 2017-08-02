# Packer Example - Ubuntu 16.04 minimal Vagrant Box

**Current Ubuntu Version Used**: 16.04.2

**Pre-built Vagrant Box**:

  - [`vagrant init geerlingguy/ubuntu1604`](https://vagrantcloud.com/geerlingguy/boxes/ubuntu1604)
  - See older versions: http://files.midwesternmac.com/

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

## Usage and configuration options

### Default build - VirtualBox and VMware boxes

Make sure all the required software (listed above) is installed, then cd to the directory containing this README.md file, and run:

```bash
    $ packer build ubuntu1604.json
```

After a few minutes, Packer should tell you the box was generated successfully.

### Building box only for one provider

If you want to only build a box for one of the supported virtualization platforms (e.g. only build the VMware box), add `--only=vmware-iso` to the `packer build` command:

```bash
    $ packer build --only=vmware-iso ubuntu1604.json
```

The switch for build VirtualBox box only is: '--virtualbox-iso'.

### Selecting option for doesn't perform apt-get dist-upgrade command

Under creation of boxes operation apt-get dist-upgrade is performed by default. You you can change this behaviour using the 'perform_dist_upgrade' parameter.

```bash
    $ packer build -var 'perform_dist_upgrade=false' ubuntu1604.json
```

The operation 'apt-get dist-upgrade' doesn't perform update of distribution to the next e.g. 16.10 or 17.04 but only upgrade some additional packages (usually related to Linux kernel itself).

More about apt-get dist-upgrade you can read:

- man apt-get
- [Why use apt-get upgrade instead of apt-get dist-upgrade?](https://askubuntu.com/questions/194651/why-use-apt-get-upgrade-instead-of-apt-get-dist-upgrade/226213#226213)
- [Ubuntu 16.04 > Ubuntu Server Guide > Installation -> Upgrading](https://help.ubuntu.com/lts/serverguide/installing-upgrading.html)

### Selecting integration components for the VMware box

You can select what kind of integration components will be installed into the VMware box

- [open-vm-tools](https://sourceforge.net/projects/open-vm-tools/)
- [VMware Tools](https://kb.vmware.com/selfservice/search.do?cmd=displayKC&docType=kc&docTypeID=DT_KB_1_1&externalId=340)

Selection can be done by assigning value to the parameter vmware_install_open_vm_tools. You can do it

```bash
    $ packer build -var "vmware_install_open_vm_tools=true" ubuntu1404.json
```

By default VMware Tools are installed.

More about differences beetwen these two options you can read:

- [VMware support for Open VM Tools (2073803)](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=2073803)
- [the open-vm-tools project page on GitHub](https://github.com/vmware/open-vm-tools)



## Testing built boxes

There's an included Vagrantfile that allows quick testing of the built Vagrant boxes. From this same directory, run one of the following commands after building the boxes:

    # For VMware Fusion:
    $ vagrant up vmware --provider=vmware_fusion

    # For VirtualBox:
    $ vagrant up virtualbox --provider=virtualbox

## License

MIT license.

## Author Information

Created in 2016 by [Jeff Geerling](http://jeffgeerling.com/), author of [Ansible for DevOps](http://ansiblefordevops.com/).
