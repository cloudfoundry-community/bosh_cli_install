One-line installer for BOSH CLI
===============================

The BOSH CLI is distributed as a RubyGem requiring a modern Ruby 2.1+. If your target machine does not have a modern Ruby installed; or if you are unsure; then you can run the following:

```
curl -k -s https://raw.githubusercontent.com/cloudfoundry-community/bosh_cli_install/master/binscripts/installer | bash
```

This supports OS X and 32 & 64-bit Linux.

Run either as a normal user or superuser. The former will install into `~/bin/bosh-cli`; the latter will install into `/usr/bin/bosh-cli`.

Test installers
---------------

To test against a 64-bit Linux and 32-bit Linux using Vagrant:

```
mkdir -p /tmp/lucid64
cd /tmp/lucid64
vagrant init lucid64 http://files.vagrantup.com/lucid64.box
vagrant up
vagrant ssh
sudo apt-get update
sudo apt-get install curl -y

curl -k -s https://raw.githubusercontent.com/cloudfoundry-community/bosh_cli_install/master/binscripts/installer | bash -s 1.2788.0

source /home/vagrant/.bashrc
bosh
```

```
mkdir -p /tmp/lucid32
cd /tmp/lucid32
vagrant init lucid32 http://files.vagrantup.com/lucid32.box
vagrant up
vagrant ssh
sudo apt-get update
sudo apt-get install curl -y

curl -k -s https://raw.githubusercontent.com/cloudfoundry-community/bosh_cli_install/master/binscripts/installer | bash -s 1.2788.0

source /home/vagrant/.bashrc
bosh
```
