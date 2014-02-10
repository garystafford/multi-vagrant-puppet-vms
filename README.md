##Vagrant Multiple-VM Creation and Configuration

Vagrantfile project to create multiple VirtualBox VMs. Currently, configured to create (2) 64-bit Ubuntu Server-based Oracle VMs, used to build and test Java EE projects.

### JSON Configuration File
Vagrantfile retrieves the multiple VM configurations from a separate '`nodes.json`' file. All configuration is abstracted out of Vagrantfile to json file. Just add additional VMs to the json file, following the existing json pattern. The Vagrantfile will loop through all nodes (VMs) in the json file and create VMs.

### Forwarding Ports
To create forwarding ports, use a '`:port_`' prefix to indicate a port to be forwarded. For example:

 ```":port_wls_admin": {
        ":host": 7709,
        ":guest": 7709,
        ":id": "wls-listen"
      }```

### Chef Configuration
Vagrantfile depends on Hosted Chef 'Environments' and 'Nodes' for configuration of VMs. This can easily be changes to 'Roles', if desired. Those Nodes use the Chef '`dev-setup`' cookbook, located here: [https://github.com/garystafford/chef-cookbooks](https://github.com/garystafford/chef-cookbooks)