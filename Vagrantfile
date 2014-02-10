# -*- mode: ruby -*-
# vi: set ft=ruby :

# Multi-VM Configuration: WebLogic Application Server and Oracle Database Server
# Author: Gary A. Stafford
# Based on David Lutz's https://gist.github.com/dlutzy/2469037
# Configures VMs based on Hosted Chef Server defined Environment and Node (vs. Roles)

# node configurations from json file
nodes = JSON.parse(File.read("nodes.json"))
nodes = nodes['nodes']

ENVIRONMENT = "Development"
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_plugin "vagrant-omnibus"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "vagrant-oracle-vm-saucy64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box"
  
  config.omnibus.chef_version = :latest
  
  # configures all forwarding ports in json file
  nodes.each do |node|
    config.vm.define node[0] do |config|
      node[1].each do |k,v|
        if k.include? ":port_"
          port = node[1][k]
          config.vm.network :forwarded_port, 
            host:  port[':host'], 
            guest: port[':guest'], 
            id:    port[':id']
        end
      end

      config.vm.hostname = node[1][':node']
      config.vm.network :public_network, ip: node[1][':ip']
      config.vm.synced_folder "#{ENV['HOME']}/Documents/GitHub/chef-artifacts", "/vagrant"

      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", node[1][':memory']]
        vb.customize ["modifyvm", :id, "--name",   node[1][':node']]
      end

      config.vm.provision :chef_client do |chef|
        chef.environment = ENVIRONMENT
        chef.provisioning_path = "/etc/chef"
        chef.chef_server_url = "https://api.opscode.com/organizations/your-environment"
        chef.validation_key_path = "~/.chef/your-user.pem"
        chef.node_name = node[1][':node']
        chef.validation_client_name = "your-user"
        chef.client_key_path = "/etc/chef/your-user.pem"
      end
    end
  end
end
