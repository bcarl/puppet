#!/bin/bash -e
# https://www.digitalocean.com/community/tutorials/how-to-set-up-a-masterless-puppet-environment-on-ubuntu-14-04

## Install Git
apt-get update
apt-get -y install git-core

# Clone the 'puppet' repo
[ -e /etc/puppet ] && mv /etc/puppet /etc/puppet-bak
git clone "https://github.com/bcarl/puppet.git" /etc/puppet

# Install and disable Puppet
apt-get -y install puppet
killall puppet
systemctl disable puppet.service

# Install Puppet modules
for module in jfryman-nginx puppetlabs-firewall puppetlabs-ntp puppetlabs-stdlib puppetlabs-vcsrepo saz-ssh saz-sudo; do
  puppet module install $module
done

# Run Puppet initially to set up the auto-deploy mechanism
puppet apply /etc/puppet/manifests/site.pp
