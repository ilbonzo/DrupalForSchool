#!/bin/bash
mkdir -p /etc/puppet/modules

#install puppet modules
puppet module install puppetlabs-apache
puppet module install puppetlabs-mysql

puppet module install rafaelfc/pear
puppet module install erikwebb/drush

apt-get update
