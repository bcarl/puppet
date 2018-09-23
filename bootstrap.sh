#!/bin/bash -e
# https://www.digitalocean.com/community/tutorials/how-to-set-up-a-masterless-puppet-environment-on-ubuntu-14-04

# install git
apt-get update
apt-get -y install git-core

# install puppet
wget https://apt.puppetlabs.com/puppet-release-$RELEASE.deb
dpkg -i puppet-release-$RELEASE.deb

# disable puppet
puppet agent --disable
killall puppet
systemctl disable puppet.service

# clone the 'puppet' repo
[ -e /etc/puppet ] && mv /etc/puppet /etc/puppet-bak
git clone "https://github.com/bcarl/puppet.git" /etc/puppet

# install puppet modules
for module in jfryman-nginx puppetlabs-firewall puppetlabs-stdlib puppetlabs-vcsrepo saz-ssh saz-sudo; do
  puppet module install $module
done

# run puppet initially to set up the auto-deploy mechanism
puppet apply /etc/puppet/manifests/site.pp
