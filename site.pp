node default {
# Test message
  notify { "Debug output on ${hostname} node.": }

  include ntp, git
}

node 'node01.example.com', 'node02.example.com' {
# Test message
  notify { "Debug output on ${hostname} node.": }

  include ntp, git, docker, fig
}