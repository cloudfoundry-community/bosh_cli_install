One-line installer for BOSH CLI
===============================

The BOSH CLI is distributed as a RubyGem requiring a modern Ruby 2.1+. If your target machine does not have a modern Ruby installed; or if you are unsure; then you can run the following:

```
curl -k -s https://raw.githubusercontent.com/cloudfoundry-community/traveling-bosh/master/scripts/installer | bash
```

This supports OS X and 32 & 64-bit Linux.

Run either as a normal user or superuser. The former will install into `~/bin/traveling-bosh`; the latter will install into `/usr/bin/traveling-bosh`.

For OS X and 64-bit Linux, the `spiff` helper for creating BOSH manifests will also be installed into your `$PATH`.

Test installers
---------------

To test against a 64-bit Linux and 32-bit Linux using Vagrant:

```
mkdir -p /tmp/lucid64
cd /tmp/lucid64
vagrant init lucid64 http://files.vagrantup.com/lucid64.box
vagrant up
vagrant ssh
```

For 32-bit:

```
mkdir -p /tmp/lucid32
cd /tmp/lucid32
vagrant init lucid32 http://files.vagrantup.com/lucid32.box
vagrant up
vagrant ssh
```

Inside either VM, run:

```
sudo apt-get update
sudo apt-get install curl -y

curl -k -s https://raw.githubusercontent.com/cloudfoundry-community/traveling-bosh/master/scripts/installer | bash

source /home/vagrant/.bashrc
bosh
```

On the 64-bit machines, `spiff` will also be installed:

```
spiff
```
