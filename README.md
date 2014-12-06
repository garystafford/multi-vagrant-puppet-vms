##Vagrant Multiple-VM Creation and Configuration
Builds Puppet Master and multiple Puppet Agent Nodes using JSON config file
#### JSON Configuration File
The Vagrantfile retrieves multiple VM configurations from a separate `nodes.json` file. All VM configuration is contained in the JSON file. You can add additional VMs to the JSON file, following the existing pattern. The Vagrantfile will loop through all nodes (VMs) in the `nodes.json` file and create the VMs. You can easily swap configuration files for alternate environments since the Vagrantfile is designed to be generic and portable.
#### Instructions
```
vagrant up
vagrant ssh puppetmaster
sh /vagrant/bootstrap-master.sh
sudo service puppetmaster stop
sudo puppet master --verbose --no-daemonize
Ctrl+C # kill puppet master
sudo service puppetmaster start
sudo puppet cert list --all # check for 'puppet' cert

Shift+Ctrl+T # new tab
vagrant ssh puppetnode-01
sh /vagrant/bootstrap-node.sh
sudo puppet agent --test # will now wait for signature on puppetmaster...
```
Back on puppetmaster
```
sudo puppet cert list # should see 'node01' cert wating for signature
sudo puppet cert sign --all
sudo puppet cert list --all # check for 'node01' cert
```
#### Forwarding Ports
Used by Vagrant and VirtualBox. To create additional forwarding ports, add them to the 'ports' array. For example:
 ```
 "ports": [
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
      ]
```
#### Useful Multi-VM Commands
`vagrant up`                        # creates and configures all Vagrant machines  
`vagrant reload`                    # runs halt and up all Vagrant machines (if you make changes to the Vagrantfile)  
`vagrant destroy -f && vagrant up`  # destroys and recreates all Vagrant machines  
`vagrant status`                    # state of the machines Vagrant is managing  
`vagrant ssh <machine>`             # ssh into SSH into a running Vagrant machine (ie. 'puppetmaster')   