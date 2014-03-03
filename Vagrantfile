# -*- mode: ruby -*-
# vi: set ft=ruby :

# Multi-VM Configuration: Builds Web, Application, and Database Servers using JSON config file
# Configures VMs based on Hosted Chef Server defined Environment and Node (vs. Roles)
# Author: Gary A. Stafford

# read vm and chef configurations from JSON files
nodes_config = (JSON.parse(File.read("nodes.json")))['nodes']
chef_config  = (JSON.parse(File.read("chef.json")))['chef']

VAGRANTFILE_API_VERSION = "2"

Vagrant.require_plugin "vagrant-omnibus"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box     = "vagrant-oracle-vm-saucy64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box"

  config.omnibus.chef_version = :latest

  nodes_config.each do |node|
    node_name   = node[0] # name of node
    node_values = node[1] # content of node

    config.vm.define node_name do |config|    
      # configures all forwarding ports in JSON array
      ports = node_values['ports']
      ports.each do |port|
        config.vm.network :forwarded_port,
          host:  port[':host'],
          guest: port[':guest'],
          id:    port[':id']
      end

      config.vm.hostname = node_values[':node']
      config.vm.network :private_network, ip: node_values[':ip']

      # syncs local repository of large third-party installer files (quicker than downloading each time)
      config.vm.synced_folder "#{ENV['HOME']}/Documents/git_repos/chef-artifacts", "/vagrant"

      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", node_values[':memory']]
        vb.customize ["modifyvm", :id, "--name", node_values[':node']]
      end

      # chef configuration section
      config.vm.provision :chef_client do |chef|
        chef.environment = chef_config[':environment']
        chef.provisioning_path = chef_config[':provisioning_path']
        chef.chef_server_url = chef_config[':chef_server_url']
        chef.validation_key_path = chef_config[':validation_key_path']
        chef.node_name = node_values[':node']
        chef.validation_client_name = chef_config[':validation_client_name']
        chef.client_key_path = chef_config[':client_key_path']
      end
    end
  end
end