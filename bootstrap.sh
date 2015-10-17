#!/bin/bash -e
# https://www.digitalocean.com/community/tutorials/how-to-set-up-a-masterless-puppet-environment-on-ubuntu-14-04

## Install Git and Puppet
apt-get update
apt-get -y install git-core puppet

# Clone the 'puppet' repo
[ -e /etc/puppet ] && mv /etc/puppet /etc/puppet-bak
git clone "https://github.com/bcarl/puppet.git" /etc/puppet

# Install Puppet modules
for module in puppetlabs-firewall puppetlabs-stdlib saz-ssh saz-sudo; do
  puppet module install $module
done

# Run Puppet initially to set up the auto-deploy mechanism
puppet apply /etc/puppet/manifests/site.pp
