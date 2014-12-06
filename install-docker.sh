#!/bin/sh

# Docker
curl -sSL https://get.docker.com/ubuntu/ | sudo sh

# Fig
sudo curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > /usr/local/bin/fig
sudo chmod +x /usr/local/bin/fig

# Pull Ubuntu image
sudo docker pull ubuntu:latest

