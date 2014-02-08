# -*- mode: ruby -*-
# vi: set ft=ruby :

# Multi-VM Configuration: WebLogic Application Server and Oracle Database Server
# Author: Gary A. Stafford
# Inspired from David Lutz's https://gist.github.com/dlutzy/2469037
# Configures VMs based on Chef Server defined Environment and Node (vs. Roles)

# node definitions
nodes = JSON.parse(File.read("nodes.json"))
nodes = nodes['nodes']

environment = "Development"
VAGRANTFILE_API_VERSION = "2"
Vagrant.require_plugin "vagrant-omnibus"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "vagrant-oracle-vm-saucy64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box"
  
  config.omnibus.chef_version = :latest
  
  nodes.each do |opts|
    config.vm.define opts[0] do |config|
      # ssh port
      if opts[1][':ssh_host'] then
        config.vm.network :forwarded_port, 
          host:  opts[1][':ssh_host'][':host_port'], 
          guest: opts[1][':ssh_host'][':guest_port'], 
          id:    opts[1][':ssh_host'][':id']
      end

      # Oracle WebLogic listen port
      if opts[1][':wls_admin'] then
        config.vm.network :forwarded_port, 
          host:  opts[1][':wls_admin'][':host_port'], 
          guest: opts[1][':wls_admin'][':guest_port'], 
          id:    opts[1][':wls_admin'][':id']
      end

      # Oracle Database XE http port
      if opts[1][':xe_db'] then
        config.vm.network :forwarded_port, 
          host:  opts[1][':xe_db'][':host_port'], 
          guest: opts[1][':xe_db'][':guest_port'], 
          id:    opts[1][':xe_db'][':id']
      end

      # Oracle Database XE database listener port
      if opts[1][':xe_listen'] then
        config.vm.network :forwarded_port, 
          host:  opts[1][':xe_listen'][':host_port'], 
          guest: opts[1][':xe_listen'][':guest_port'], 
          id:    opts[1][':xe_listen'][':id']
      end

      config.vm.hostname = opts[1][':node']
      config.vm.network :public_network, ip: opts[1][':ip']
      config.vm.synced_folder "#{ENV['HOME']}/Documents/GitHub/chef-artifacts", "/vagrant"

      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", opts[1][':memory']]
        vb.customize ["modifyvm", :id, "--name", opts[1][':node']]
      end

      config.vm.provision :chef_client do |chef|
        chef.environment = environment
        chef.provisioning_path = "/etc/chef"
        chef.chef_server_url = "https://api.opscode.com/organizations/paychexenvironmentsteam"
        chef.validation_key_path = "~/.chef/dev-ops.pem"
        chef.node_name = opts[1][':node']
        chef.validation_client_name = "dev-ops"
        chef.client_key_path = "/etc/chef/dev-ops.pem"
      end
    end
  end
end
