#!/bin/sh

# Run on VM to setup Puppet Agent node
# http://blog.kloudless.com/2013/07/01/automating-development-environments-with-vagrant-and-puppet/

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

    # Configure /etc/hosts file
    echo "" | sudo tee --append  /etc/hosts > /dev/null && \
    echo "# Host config for Puppet Master and Agent Nodes" | sudo tee --append  /etc/hosts > /dev/null && \
    echo "192.168.32.5    puppet" | sudo tee --append  /etc/hosts > /dev/null && \
    echo "192.168.32.10   node01" | sudo tee --append  /etc/hosts > /dev/null && \
    echo "192.168.32.20   node02" | sudo tee --append  /etc/hosts > /dev/null

    # Add optional alternate DNS names to /etc/puppet/puppet.conf
    echo "" && echo "[agent]\nserver=puppet" | sudo tee --append  /etc/puppet/puppet.conf > /dev/null

    sudo puppet agent --enable
fi