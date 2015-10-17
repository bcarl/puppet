class my_fw::post {
  firewall { '999 drop all (v4)':
    proto    => 'all',
    action   => 'drop',
    before   => undef,
    provider => 'iptables',
  }
  firewall { '999 drop all (v6)':
    proto    => 'all',
    action   => 'drop',
    before   => undef,
    provider => 'ip6tables',
  }
}
