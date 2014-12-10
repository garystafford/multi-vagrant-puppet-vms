#!/bin/sh

# Docker (https://docs.docker.com/installation/ubuntulinux/#ubuntu-trusty-1404-lts-64-bit)
curl -sSL https://get.docker.com/ubuntu/ | sudo sh

# Pull Ubuntu image
sudo docker pull ubuntu:latest

# Fig (http://www.fig.sh/install.html)
sudo curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > /usr/local/bin/fig
sudo chmod +x /usr/local/bin/fig


# export module from geppetto first...
rm -rf /usr/local/bin/fig
sudo cp -r /home/gstafford/WebstormProjects/multi-vagrant-puppet-vms/site.pp /etc/puppet/manifests/site.pp
sudo puppet module install -f /home/gstafford/Downloads/gstafford-fig-0.1.0.tar.gz
sudo puppet apply site.pp --debug
fig --version # test install