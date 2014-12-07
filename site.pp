node "default" {
## Test 1 : Create File
#  file { "/home/vagrant/puppet_test.txt":
#    ensure => file,
#    owner  => "vagrant",
#    group  => "vagrant",
#    mode   => 0644
#  }
#
## Test 2 : Message
#  notify { "This test message is getting logged this node.": }

# Install ntp
  class { '::ntp':
    servers => ['pool.ntp.org','utcnist.colorado.edu'],
    udlc    => true,
  }
}

node "node01" {
  include 'docker'
  include 'git'

  docker::image { 'ubuntu':
    image_tag => 'trusty'
  }

  docker::image { 'node':
    image_tag => 'latest'
  }

  vcsrepo { "/vagrant/mean-estimator":
    ensure   => present,
    provider => git,
    source   => "https://github.com/garystafford/mean-estimator.git",
  }
}
