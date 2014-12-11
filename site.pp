node 'default' {
# Test Message
  notify { 'This test message is getting logged on $::fqdn.': }
}

node 'node01' {
  include ntp, git, docker, fig

# install ubuntu docker image
  docker::image { 'ubuntu':
    image_tag => 'trusty'
  }

# install node docker image
  docker::image { 'node':
    image_tag => 'latest'
  }

# git clone mean-estimator repo
  vcsrepo { '/vagrant/mean-estimator':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/garystafford/mean-estimator.git'
  }
}