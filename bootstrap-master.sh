#!/bin/sh

# Run on VM to bootstrap Puppet Master server
# http://blog.kloudless.com/2013/07/01/automating-development-environments-with-vagrant-and-puppet/

if ps aux | grep "puppet master" | grep -v grep 2> /dev/null
then
    echo "Puppet Master is already installed. Exiting..."
else
    # Install Puppet Master
    wget https://apt.puppetlabs.com/puppet6-release-focal.deb && \
    sudo dpkg -i puppet6-release-focal.deb && \
    sudo apt-get update -yq && sudo apt-get upgrade -yq && \
    sudo apt-get install -yq puppetmaster git

    # Configure /etc/hosts file
    echo "" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "# Host config for Puppet Master and Agent Nodes" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "10.0.0.101   puppet" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "10.0.0.102   node01" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "10.0.0.103   node02" | sudo tee --append /etc/hosts 2> /dev/null

    # Add optional alternate DNS names to /etc/puppet/puppet.conf
    sudo sed -i 's/.*\[main\].*/&\ndns_alt_names = puppet/' /etc/puppet/puppet.conf

    # Install some initial puppet modules on Puppet Master server
    sudo puppet module install puppetlabs-ntp
    sudo puppet module install garethr-docker
    sudo puppet module install puppetlabs-git
    sudo puppet module install puppetlabs-vcsrepo
    sudo puppet module install garystafford-fig

    # symlink manifest from Vagrant synced folder location
    # ln -s /vagrant/site.pp /etc/puppet/manifests/site.pp
fi
