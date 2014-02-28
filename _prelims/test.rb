require 'json'

nodes = JSON.parse(File.read("../nodes.json"))
nodes = nodes['nodes']

nodes.each do |node|
  puts node[0]
  node[1].each do |k,v|
    if k.include? ":port_"
      port = node[1][k]
      puts port[':host']
      puts port[':guest']
      puts port[':id']
      puts
    end
  end
end

chef_config = (JSON.parse(File.read("../chef.json")))['chef']
puts chef_config[':provisioning_path']
