node basenode {
# Test message
  notify { 'This test message is getting logged on $::fqdn.': }

  include ntp, git
}

node 'node01', 'node02' inherits basenode {
  include docker, fig

# install ubuntu docker image
  docker::image { 'ubuntu':
    image_tag => 'trusty'
  }

# install node docker image
  docker::image { 'node':
    image_tag => 'latest'
  }

## git clone mean-estimator repo
#  vcsrepo { '/vagrant/mean-estimator':
#    ensure   => present,
#    provider => git,
#    source   => 'https://github.com/garystafford/mean-estimator.git'
#  }
}