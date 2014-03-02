# Ruby scratchpad for Vagrantfile
# use 'Ruby test.rb' to execute

require 'json'

nodes = (JSON.parse(File.read("../nodes.json")))['nodes']

# current method to get ports from array
nodes.each do |node|
  #puts node
      current_node = node[1]
#puts current_node
#puts node[0]
  ports = node[1]['ports']
  puts ports
  current_node[':node']
  ports.each do |port|
    #puts port[':host']
    #puts port[':guest']
    #puts port[':id']
  end
end

=begin
# original method to get ports
nodes.each do |node|
  puts node[0]
  node[1].each do |k,v|
    if k.include? ":port_"
      port = node[1][k]
      puts port[':host']
      puts port[':guest']
      puts port[':id']
    end
  end
end
=end

chef_config = (JSON.parse(File.read("../chef.json")))['chef']
puts chef_config[':provisioning_path']
