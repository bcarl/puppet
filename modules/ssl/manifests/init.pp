class ssl {
  package { 'openssl':
    ensure => installed,
  }
}
