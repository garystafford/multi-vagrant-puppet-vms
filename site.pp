node default {
# Test message
  notify { "Debug output on ${hostname} node.": }

  include ntp, git
}

node 'node01', 'node02' {
# Test message
  notify { "Debug output on ${hostname} node.": }

  include ntp, git, docker, fig
}