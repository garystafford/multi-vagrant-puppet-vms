# -*- mode: ruby -*-
# vi: set ft=ruby :

# Multi-VM Configuration: WebLogic Application Server and Oracle Database Server
# Author: Gary A. Stafford
# Inspired from David Lutz's https://gist.github.com/dlutzy/2469037
# Configures VMs based on Chef Server defined Environment and Node (vs. Roles)

# node definitions
nodes = [
  { :name             =>  :apps,
    :node             =>  'ApplicationServer-201',
    :environment      =>  'Development',
    :ip               =>  '192.168.33.21',
    :host             =>  'apps.server-201',
    :ssh_port_host    =>  2201,
    :wls_port         =>  7709,
    :memory           =>  2048},
  { :name             =>  :dbs,
    :node             =>  'DatabaseServer-301',
    :environment      =>  'Development',
    :ip               =>  '192.168.33.31',
    :host             =>  'dbs.server-301',
    :ssh_port_host    =>  2202,
    :xe_db_port       =>  1529,
    :xe_listen_port   =>  8380,
    :memory           =>  2048}
  ]
  
default_ssh_port_guest  = 22
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_plugin "vagrant-omnibus"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "vagrant-oracle-vm-saucy64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box"
  
  config.omnibus.chef_version = :latest
  
  nodes.each do |opts|
    config.vm.define opts[:name] do |config|
      # ssh port
      if opts[:ssh_port_host] then
        config.vm.network :forwarded_port, 
          guest: default_ssh_port_guest, 
          host: opts[:ssh_port_host], 
          id: "ssh"
      end

      # Oracle WebLogic listen port
      if opts[:wls_port] then
        config.vm.network :forwarded_port, 
          guest: opts[:wls_port], 
          host: opts[:wls_port], 
          id: "wls-listen"
      end

      # Oracle Database XE http port
      if opts[:xe_db_port] then
        config.vm.network :forwarded_port, 
          guest: opts[:xe_db_port], 
          host: opts[:xe_db_port], 
          id: "xe-http"
      end

      # Oracle Database XE database listener port
      if opts[:xe_listen_port] then
        config.vm.network :forwarded_port, 
          guest: opts[:xe_listen_port], 
          host: opts[:xe_listen_port], 
          id: "xe-listener"
      end

      config.vm.hostname = opts[:node]
      config.vm.network :public_network, ip: opts[:ip]
      config.vm.synced_folder "#{ENV['HOME']}/Documents/GitHub/chef-artifacts", "/vagrant"

      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", opts[:memory]]
        vb.customize ["modifyvm", :id, "--name", opts[:node]]
      end

      config.vm.provision :chef_client do |chef|
        chef.environment = opts[:environment]
        chef.provisioning_path = "/etc/chef"
        chef.chef_server_url = "https://api.opscode.com/organizations/paychexenvironmentsteam"
        chef.validation_key_path = "~/.chef/dev-ops.pem"
        chef.node_name = opts[:node]
        chef.validation_client_name = "dev-ops"
        chef.client_key_path = "/etc/chef/dev-ops.pem"
      end
    end
  end
end
