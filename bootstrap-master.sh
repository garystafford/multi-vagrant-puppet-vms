#!/bin/sh

# Run on VM to setup Puppet Master server
# http://blog.kloudless.com/2013/07/01/automating-development-environments-with-vagrant-and-puppet/

if ps aux | grep "puppet master" | grep -v grep > /dev/null
then
    echo "Puppet Master is already installed. Exiting..."
else
    wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb && \
    sudo dpkg -i puppetlabs-release-trusty.deb && \
    sudo apt-get update -yq && sudo apt-get upgrade -yq && \
    sudo apt-get install -yq puppetmaster git

    echo "" | sudo tee --append  /etc/hosts > /dev/null && \
    echo "# Host config for vagrant-docker-puppet demo" | sudo tee --append  /etc/hosts > /dev/null && \
    echo "192.168.32.5    puppet" | sudo tee --append  /etc/hosts > /dev/null && \
    echo "192.168.32.10   node01" | sudo tee --append  /etc/hosts > /dev/null && \
    echo "192.168.32.20   node02" | sudo tee --append  /etc/hosts > /dev/null && \
    echo "192.168.32.30   node03" | sudo tee --append  /etc/hosts > /dev/null

    sudo sed -i 's/.*\[main\].*/&\ndns_alt_names = puppet,puppetvm,puppetvm.com/' /etc/puppet/puppet.conf

    sudo cp /vagrant/site.pp /etc/puppet/manifests/site.pp
    sudo puppet module install puppetlabs-ntp
    sudo puppet module install garethr-docker
    sudo puppet apply /etc/puppet/manifests/site.pp

    # not working right now...do manually...
    #sudo service puppetmaster stop
    #sudo puppet master --verbose --no-daemonize & sleep 2 && kill -INT # need to add force break ctrl c
    #sudo service puppetmaster start
fi
