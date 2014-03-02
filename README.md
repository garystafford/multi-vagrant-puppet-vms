##Vagrant Multiple-VM Creation and Configuration

A Vagrant project to create multiple VirtualBox VMs. Currently, configured to create (2) 64-bit Ubuntu Server-based Oracle VMs, used to build and test Java EE projects.

#### JSON Configuration File
The Vagrantfile retrieves multiple VM configurations from a separate '`nodes.json`' file. All VM configuration is contained in the json file. You add additional VMs to the json file, following the existing json pattern. The Vagrantfile will loop through all nodes (VMs) in the json file and create VMs. You can also swap json files for alternate environments by re-pointing the '`nodes`' variable in the Vargrantfile.

#### Forwarding Ports
To create forwarding ports, use a '`:port_`' prefix to indicate a port to be forwarded. For example:

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
My Vagrantfile uses Chef, which in turn uses my Hosted Chef account's 'Environments' and 'Nodes' for configuration of VMs. This can easily be changed to use 'Roles', if desired. The Hosted Chef 'Nodes' use recipes from the '`dev-setup`', located here: [https://github.com/garystafford/chef-cookbooks](https://github.com/garystafford/chef-cookbooks)    