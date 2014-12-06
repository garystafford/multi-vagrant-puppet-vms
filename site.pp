node "default" {
# Test 1 : Create File
  file { "/home/vagrant/puppet_test.txt":
    ensure => file,
    owner  => "vagrant",
    group  => "vagrant",
    mode   => 0644
  }

# Test 2 : Message
  notify { "This test message is getting logged this node.": }

# Test 3: Install ntp
  class { '::ntp':
    servers => ['pool.ntp.org','utcnist.colorado.edu'],
    udlc    => true,
  }
}
