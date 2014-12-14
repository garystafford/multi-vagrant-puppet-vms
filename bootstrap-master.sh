#!/bin/sh

# Run on VM to bootstrap Puppet Master server
# http://blog.kloudless.com/2013/07/01/automating-development-environments-with-vagrant-and-puppet/

if ps aux | grep "puppet master" | grep -v grep 2> /dev/null
then
    echo "Puppet Master is already installed. Exiting..."
else
    # Install Puppet Master
    wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb && \
    sudo dpkg -i puppetlabs-release-trusty.deb && \
    sudo apt-get update -yq && sudo apt-get upgrade -yq && \
    sudo apt-get install -yq puppetmaster git

    # Configure /etc/hosts file
    echo "" | sudo tee --append  /etc/hosts 2> /dev/null && \
    echo "# Host config for Puppet Master and Agent Nodes" | sudo tee --append  /etc/hosts 2> /dev/null && \
    echo "192.168.32.5    puppet" | sudo tee --append  /etc/hosts 2> /dev/null && \
    echo "192.168.32.10   node01" | sudo tee --append  /etc/hosts 2> /dev/null && \
    echo "192.168.32.20   node02" | sudo tee --append  /etc/hosts > /dev/null

    # Add optional alternate DNS names to /etc/puppet/puppet.conf
    sudo sed -i 's/.*\[main\].*/&\ndns_alt_names = puppet,puppetvm,puppetvm.com/' /etc/puppet/puppet.conf

    # Install some initial puppet modules on Puppet Master server
    sudo puppet module install puppetlabs-ntp
    sudo puppet module install garethr-docker
    sudo puppet module install puppetlabs-git
    sudo puppet module install puppetlabs-vcsrepo

    # Copy main manifest from Vagrant synced folder location
    sudo cp /vagrant/site.pp /etc/puppet/manifests/site.pp

    # Apply the site.pp manifest to the Puppet Master server
    sudo puppet apply /etc/puppet/manifests/site.pp 2> /dev/null

    # not working right now...do manually...
    #sudo service puppetmaster stop
    #sudo puppet master --verbose --no-daemonize & sleep 2 && kill -INT # need to add force break ctrl c
    #sudo service puppetmaster start
fi
