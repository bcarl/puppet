class my_fw::pre {
  Firewall {
    require => undef,
  }
  # Default firewall rules (v4)
  firewall { '000 accept all icmp (v4)':
    proto    => 'icmp',
    action   => 'accept',
    provider => 'iptables',
  }->
  firewall { '001 accept all to lo interface (v4)':
    proto    => 'all',
    iniface  => 'lo',
    action   => 'accept',
    provider => 'iptables',
  }->
  firewall { '002 reject local traffic not on loopback interface (v4)':
    iniface     => '! lo',
    proto       => 'all',
    destination => '127.0.0.1/8',
    action      => 'reject',
    provider    => 'iptables',
  }->
  firewall { '003 accept related established rules (v4)':
    proto    => 'all',
    state    => ['RELATED', 'ESTABLISHED'],
    action   => 'accept',
    provider => 'iptables',
  }
  # Default firewall rules (v6)
  firewall { '000 accept all icmp (v6)':
    proto    => 'icmp',
    action   => 'accept',
    provider => 'ip6tables',
  }->
  firewall { '001 accept all to lo interface (v6)':
    proto    => 'all',
    iniface  => 'lo',
    action   => 'accept',
    provider => 'ip6tables',
  }->
  firewall { '002 reject local traffic not on loopback interface (v6)':
    iniface     => '! lo',
    proto       => 'all',
    destination => '::1/128',
    action      => 'reject',
    provider    => 'ip6tables',
  }->
  firewall { '003 accept related established rules (v6)':
    proto    => 'all',
    state    => ['RELATED', 'ESTABLISHED'],
    action   => 'accept',
    provider => 'ip6tables',
  }
}
