#node "dockervm-03" {
file { "/home/vagrant/helloworld.txt":
  ensure => file,
  owner  => "vagrant",
  group  => "vagrant",
  mode   => 0644
}

notify { "This message is getting logged on the agent node.": }

class { '::ntp':
  servers => ['pool.ntp.org','utcnist.colorado.edu'],
  udlc    => true,
}
#}
