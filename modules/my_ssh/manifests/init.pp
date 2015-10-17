class my_ssh ($port = 2422) {
  ensure_resource('group', 'ssh', {ensure => present})

  class { 'ssh':
    server_options => {
      'AllowGroups' => 'ssh',
      'DenyUsers' => 'root',
      'PasswordAuthentication' => 'no',
      'PermitEmptyPasswords' => 'no',
      'PermitRootLogin' => 'no',
      'Port' => $port,
      'Protocol' => '2',
      'PubkeyAuthentication' => 'yes',
      'RSAAuthentication' => 'yes',
      'TCPKeepAlive' => 'yes',
      'UsePAM' => 'no',
      'X11Forwarding' => 'no',
    },
    require => Group['ssh'],
  }

  firewall { '006 Allow inbound SSH (v4)':
    dport    => $port,
    proto    => tcp,
    action   => accept,
    provider => 'iptables',
  }
  firewall { '006 Allow inbound SSH (v6)':
    dport    => $port,
    proto    => tcp,
    action   => accept,
    provider => 'ip6tables',
  }
}
