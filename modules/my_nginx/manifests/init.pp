class my_nginx {
  include nginx
  include my_nginx::params

  file { [$my_nginx::params::certdir, $my_nginx::params::wwwroot,
          $my_nginx::params::gitroot, $my_nginx::params::buildroot]:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 0644,
  }

  firewall { '100 Allow inbound HTTP/HTTPS (v4)':
    dport    => [80, 443],
    proto    => tcp,
    action   => accept,
    provider => iptables,
  }
  firewall { '100 Allow inbound HTTP/HTTPS (v6)':
    dport    => [80, 443],
    proto    => tcp,
    action   => accept,
    provider => ip6tables,
  }
}
