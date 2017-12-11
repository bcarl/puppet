class my_mosh {
  require my_ssh

  package { 'mosh':
    ensure => installed,
  }

  firewall { '007 Allow inbound mosh (v4)':
    dport    => '60000-60100',
    proto    => udp,
    action   => accept,
    provider => iptables,
  }
  firewall { '007 Allow inbound mosh (v6)':
    dport    => '60000-60100',
    proto    => udp,
    action   => accept,
    provider => ip6tables,
  }
}
