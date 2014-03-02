##Vagrant Multiple-VM Creation and Configuration

A Vagrant project to create multiple VirtualBox VMs using JSON configuration files. Currently, provisions (3) 64-bit Ubuntu Server-based VMs: Web, Application, and Database.

#### JSON Configuration File
The Vagrantfile retrieves multiple VM configurations from a separate '`nodes.json`' file. All VM configuration is contained in the JSON file. You can add additional VMs to the JSON file, following the existing pattern. The Vagrantfile will loop through all nodes (VMs) in the '`nodes.json`' file and create the VMs. You can easily swap configuration files for alternate environments since the Vagrantfile is designed to be generic and portable.

#### Forwarding Ports
To create additional forwarding ports, add them to the 'ports' array. For example:

 ```"ports": [
        {
          ":host": 1234,
          ":guest": 2234,
          ":id": "port-1"
        },
        {
          ":host": 5678,
          ":guest": 6789,
          ":id": "port-2"
        }
      ]```

#### Chef Configuration
The Vagrantfile uses Chef, which in turn uses a Hosted Chef account's 'Environments' and 'Nodes' for configuration of VMs. This can easily be changed to use 'Roles', if desired. The Hosted Chef 'Nodes' use recipes from the '`dev-setup`', located here: [https://github.com/garystafford/chef-cookbooks](https://github.com/garystafford/chef-cookbooks)    