# -*- mode: ruby -*-
# vi: set ft=ruby :

# Multi-VM Configuration: WebLogic Application Server and Oracle Database Server
# Author: Gary A. Stafford
# Inspired from David Lutz's https://gist.github.com/dlutzy/2469037
# Configures VMs based on Chef Server defined Environment and Node (vs. Roles)

# node definitions
nodes = [
  { :name             =>  :apps,
    :node             =>  'ApplicationServer',
    :environment      =>  'Development',
    :ip               =>  '192.168.33.10',
    :host             =>  'app.server',
    :ssh_port         =>  2201,
    :wls_port         =>  7709,
    :memory           =>  2048,
    :shares           =>  true },
  { :name             =>  :dbs,
    :node             =>  'DatabaseServer',
    :environment      =>  'Development',
    :ip               =>  '192.168.33.21',
    :host             =>  'db.server',
    :ssh_port         =>  2202,
    :xe_db_port       =>  1529,
    :xe_listen_port   =>  8380,
    :memory           =>  2048,
    :shares           =>  true }
  ]
  
default_ssh_port = 22
VAGRANTFILE_API_VERSION = "2"
Vagrant.require_plugin "vagrant-omnibus"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "vagrant-oracle-vm-saucy64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box"
  
  config.omnibus.chef_version = :latest
  
  nodes.each do |opts|
    config.vm.define opts[:name] do |config|
      # ssh port
      #if opts[:ssh_port] then
      #  config.vm.network :forwarded_port, guest: default_ssh_port, host: opts[:ssh_port]
      #end

      # Oracle WebLogic AdminServer port
      if opts[:wls_port] then
        config.vm.network :forwarded_port, guest: opts[:wls_port], host: opts[:wls_port]
      end

      # Oracle Database XE Oracle Application Express
      if opts[:xe_db_port] then
        config.vm.network :forwarded_port, guest: opts[:xe_db_port], host: opts[:xe_db_port]
      end

      # Oracle Database XE database listener port
      if opts[:xe_listen_port] then
        config.vm.network :forwarded_port, guest: opts[:xe_listen_port], host: opts[:xe_listen_port]
      end

      config.vm.hostname = opts[:node]

      config.vm.network :private_network, ip: opts[:ip]
      # config.vm.network :public_network, ip: opts[:ip]

      ## use nfs rather than VirtualBox shared files.  It's heaps faster. (not in use yet...)
      # config.vm.share_folder  "stuff", "/usr/local/tmp", "${HOME}/GitHub/chef-artifacts", :nfs => true if opts[:shares]

      config.vm.synced_folder "#{ENV['HOME']}/Documents/GitHub/chef-artifacts", "/artifacts"

      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", opts[:memory]]
        vb.customize ["modifyvm", :id, "--name", opts[:node]]
      end

      config.vm.provision :chef_client do |chef|
        chef.environment = opts[:environment]
        chef.provisioning_path = "/etc/chef"
        chef.chef_server_url = "https://api.opscode.com/organizations/paychexenvironmentsteam"
        chef.validation_key_path = "~/.chef/paychexenvironmentsteam-validator.pem"
        chef.node_name = opts[:node]
        chef.validation_client_name = "paychexenvironmentsteam-validator"
        chef.client_key_path = "/etc/chef/paychexenvironmentsteam-validator.pem"
      end
    end
  end
end
