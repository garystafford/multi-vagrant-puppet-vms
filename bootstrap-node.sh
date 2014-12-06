#!/bin/sh

# Run on VM to setup Puppet Agent node
# http://blog.kloudless.com/2013/07/01/automating-development-environments-with-vagrant-and-puppet/

set -e

if ps aux | grep "puppet agent" | grep -v grep > /dev/null
then
    echo "Puppet Agent is already installed. Moving on..."
else
    sudo apt-get install -yq puppet
fi


if cat /etc/crontab | grep puppet > /dev/null
then
    echo "Puppet Agent is already configured. Exiting..."
else
    sudo apt-get update -yq && sudo apt-get upgrade -yq

    sudo puppet resource cron puppet-agent ensure=present user=root minute=30 \
        command='/usr/bin/puppet agent --onetime --no-daemonize --splay'

    sudo puppet resource service puppet ensure=running enable=true

    sleep 2

    echo "\n# Host config for vagrant-docker-puppet demo" | sudo tee --append  /etc/hosts > /dev/null && \
    echo "192.168.1.77    gstafford-X555LA"   | sudo tee --append  /etc/hosts > /dev/null && \
    echo "192.168.32.5    puppet"             | sudo tee --append  /etc/hosts > /dev/null && \
    echo "192.168.32.10   node01.example.com" | sudo tee --append  /etc/hosts > /dev/null && \
    echo "192.168.32.20   node02.example.com" | sudo tee --append  /etc/hosts > /dev/null && \
    echo "192.168.32.30   node03.example.com" | sudo tee --append  /etc/hosts > /dev/null

    sleep 2

    # certs did not work with alt dns names like puppetmaster01
    echo "\n[agent]\nserver=puppet" | sudo tee --append  /etc/puppet/puppet.conf > /dev/null

    # Is this what gets cert sent to master? 'restart' failed.
    sudo service puppet stop && \
    sleep 2 && \
    sudo service puppet start

    sudo puppet agent --enable
fi